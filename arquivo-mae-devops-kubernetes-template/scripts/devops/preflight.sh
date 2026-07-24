#!/bin/sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
ROOT=$(CDPATH= cd -- "$SCRIPT_DIR/../.." && pwd)
. "$SCRIPT_DIR/common.sh"

MODE=${1:-local}

require_command git
require_command python3

log "Git: $(git --version)"
log "Python: $(python3 --version 2>&1)"

python3 "$ROOT/scripts/verificar_base.py"

case "$MODE" in
  local)
    log "Preflight local concluído."
    ;;
  drone-read)
    require_command drone
    require_env DRONE_SERVER
    require_env DRONE_TOKEN
    require_env DRONE_REPO
    log "Drone: $(drone --version 2>&1 | head -n 1)"
    drone repo info "$DRONE_REPO" >/dev/null
    log "Acesso de leitura ao Drone confirmado para $DRONE_REPO."
    ;;
  cluster-read|cluster-write)
    require_command kubectl
    require_env KUBE_CONTEXT
    require_env KUBE_NAMESPACE
    require_env EXPECTED_KUBE_CONTEXT
    require_env EXPECTED_KUBE_SERVER
    require_env EXPECTED_KUBE_NAMESPACE

    [ "$KUBE_CONTEXT" = "$EXPECTED_KUBE_CONTEXT" ] || \
      die "Contexto divergente: atual=$KUBE_CONTEXT esperado=$EXPECTED_KUBE_CONTEXT"
    [ "$KUBE_NAMESPACE" = "$EXPECTED_KUBE_NAMESPACE" ] || \
      die "Namespace divergente: atual=$KUBE_NAMESPACE esperado=$EXPECTED_KUBE_NAMESPACE"

    log "kubectl client: $(kubectl version --client 2>&1 | head -n 1)"
    log "Alvo declarado: context=$KUBE_CONTEXT namespace=$KUBE_NAMESPACE"
    kubectl config get-contexts -o name | grep -Fqx "$KUBE_CONTEXT" || \
      die "Contexto não encontrado no kubeconfig: $KUBE_CONTEXT"
    assert_expected_kube_server
    kubectl --context "$KUBE_CONTEXT" cluster-info >/dev/null

    allowed=$(kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" auth can-i get deployments)
    [ "$allowed" = "yes" ] || die "RBAC não permite leitura de deployments em $KUBE_NAMESPACE."
    kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" get deployments >/dev/null

    if [ "$MODE" = "cluster-write" ]; then
      is_true "${ALLOW_CLUSTER_WRITE-}" || die "ALLOW_CLUSTER_WRITE=1 é obrigatório para preflight de escrita."
      for tuple in \
        "create deployments.apps" "patch deployments.apps" "update deployments.apps" \
        "create services" "patch services" "update services" \
        "create configmaps" "patch configmaps" "update configmaps" \
        "create serviceaccounts" "patch serviceaccounts" "update serviceaccounts"
      do
        verb=${tuple%% *}
        resource=${tuple#* }
        allowed=$(kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" auth can-i "$verb" "$resource")
        [ "$allowed" = "yes" ] || die "RBAC não permite $verb $resource em $KUBE_NAMESPACE."
      done
    fi
    log "Preflight $MODE concluído."
    ;;
  *)
    die "Modo inválido: $MODE. Use local, drone-read, cluster-read ou cluster-write."
    ;;
esac
