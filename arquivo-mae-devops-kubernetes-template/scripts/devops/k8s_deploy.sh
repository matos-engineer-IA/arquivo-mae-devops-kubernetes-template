#!/bin/sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
ROOT=$(CDPATH= cd -- "$SCRIPT_DIR/../.." && pwd)
. "$SCRIPT_DIR/common.sh"

DEPLOY_ENV=${1:-${DEPLOY_ENV:-development}}
case "$DEPLOY_ENV" in
  development|staging|production) ;;
  *) die "Ambiente inválido: $DEPLOY_ENV" ;;
esac

require_command kubectl
require_env KUBE_CONTEXT
require_env KUBE_NAMESPACE
require_env EXPECTED_KUBE_CONTEXT
require_env EXPECTED_KUBE_SERVER
require_env EXPECTED_KUBE_NAMESPACE
require_env IMAGE
require_env K8S_DEPLOYMENT

case "$IMAGE" in
  *[[:space:]]*) die "IMAGE contém espaço ou quebra de linha." ;;
esac

[ "$KUBE_CONTEXT" = "$EXPECTED_KUBE_CONTEXT" ] || \
  die "Contexto divergente: atual=$KUBE_CONTEXT esperado=$EXPECTED_KUBE_CONTEXT"
[ "$KUBE_NAMESPACE" = "$EXPECTED_KUBE_NAMESPACE" ] || \
  die "Namespace divergente: atual=$KUBE_NAMESPACE esperado=$EXPECTED_KUBE_NAMESPACE"

case "$KUBE_CONTEXT" in
  *production*|*prod*|*prd*)
    [ "$DEPLOY_ENV" = "production" ] || die "Contexto parece produção, mas ambiente declarado é $DEPLOY_ENV."
    ;;
esac
case "$KUBE_NAMESPACE" in
  *production*|*prod*|*prd*)
    [ "$DEPLOY_ENV" = "production" ] || die "Namespace parece produção, mas ambiente declarado é $DEPLOY_ENV."
    ;;
esac

if [ -n "${KUBE_CONFIG_B64-}" ]; then
  TMP_KUBE=$(mktemp_dir)
  trap 'rm -rf "$TMP_KUBE"' EXIT HUP INT TERM
  umask 077
  printf '%s' "$KUBE_CONFIG_B64" | base64 -d > "$TMP_KUBE/config"
  chmod 600 "$TMP_KUBE/config"
  export KUBECONFIG="$TMP_KUBE/config"
fi

if is_true "${DRONE-}"; then
  [ "${DRONE_BUILD_EVENT-}" = "promote" ] || die "No Drone, deploy exige evento promote."
  [ "${DRONE_DEPLOY_TO-}" = "$DEPLOY_ENV" ] || \
    die "Target Drone divergente: ${DRONE_DEPLOY_TO-VAZIO} != $DEPLOY_ENV"
  if [ -n "${DRONE_COMMIT_SHA-}" ]; then
    case "$IMAGE" in
      *"$DRONE_COMMIT_SHA"*|*@sha256:*) ;;
      *) die "Imagem não referencia o commit promovido nem um digest: $DRONE_COMMIT_SHA" ;;
    esac
  fi
fi

if [ "$DEPLOY_ENV" = "production" ]; then
  is_true "${ALLOW_PRODUCTION_DEPLOY-}" || die "ALLOW_PRODUCTION_DEPLOY=1 é obrigatório em produção."
  require_env CHANGE_TICKET
fi

log "Alvo: env=$DEPLOY_ENV context=$KUBE_CONTEXT namespace=$KUBE_NAMESPACE deployment=$K8S_DEPLOYMENT"
log "Imagem: $IMAGE"
[ -n "${CHANGE_TICKET-}" ] && log "Mudança: $CHANGE_TICKET"

kubectl config get-contexts -o name | grep -Fqx "$KUBE_CONTEXT" || die "Contexto não encontrado no kubeconfig: $KUBE_CONTEXT"
assert_expected_kube_server
allowed=$(kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" auth can-i get deployments)
[ "$allowed" = "yes" ] || die "RBAC não permite leitura de deployments no alvo."
kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" get deployments >/dev/null

OUTPUT=${OUTPUT:-"$ROOT/devops/rendered/$DEPLOY_ENV.yaml"}
DEPLOY_ENV="$DEPLOY_ENV" OUTPUT="$OUTPUT" sh "$SCRIPT_DIR/k8s_render.sh"
assert_manifest_namespace "$OUTPUT" "$KUBE_NAMESPACE"

log "Recursos renderizados:"
kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" \
  apply --dry-run=client -o name -f "$OUTPUT"
kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" \
  apply --dry-run=client -f "$OUTPUT" >/dev/null
kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" \
  apply --dry-run=server -f "$OUTPUT" >/dev/null
log "Dry-run local e no servidor: OK"

set +e
kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" diff -f "$OUTPUT"
DIFF_STATUS=$?
set -e
case "$DIFF_STATUS" in
  0) log "kubectl diff: nenhuma diferença." ;;
  1) log "kubectl diff: alterações detectadas acima." ;;
  *) die "kubectl diff falhou com código $DIFF_STATUS." ;;
esac

if is_true "${DRY_RUN_ONLY-}"; then
  log "DRY_RUN_ONLY ativo: nenhuma alteração aplicada."
  exit 0
fi

is_true "${ALLOW_CLUSTER_WRITE-}" || die "ALLOW_CLUSTER_WRITE=1 é obrigatório para aplicar."

assert_manifest_write_permissions "$OUTPUT" "$KUBE_CONTEXT" "$KUBE_NAMESPACE"

previous_image=$(kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" \
  get "deployment/$K8S_DEPLOYMENT" -o jsonpath='{.spec.template.spec.containers[0].image}' 2>/dev/null || true)
[ -n "$previous_image" ] && log "Imagem anterior registrada para rollback: $previous_image"

kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" apply -f "$OUTPUT"

ROLLOUT_TIMEOUT=${ROLLOUT_TIMEOUT:-180s}
if ! kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" \
  rollout status "deployment/$K8S_DEPLOYMENT" --timeout="$ROLLOUT_TIMEOUT"; then
  warn "Rollout falhou. Nenhum rollback automático foi executado."
  warn "Com autorização, use: kubectl --context '$KUBE_CONTEXT' --namespace '$KUBE_NAMESPACE' rollout undo deployment/$K8S_DEPLOYMENT"
  exit 1
fi

kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" \
  get "deployment/$K8S_DEPLOYMENT" -o wide
log "Deploy e rollout concluídos. Execute os smoke tests e observe métricas antes de declarar sucesso."
