#!/bin/sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
ROOT=$(CDPATH= cd -- "$SCRIPT_DIR/../.." && pwd)
. "$SCRIPT_DIR/common.sh"

require_command kubectl

DEPLOY_ENV=${DEPLOY_ENV:-development}
OUTPUT=${OUTPUT:-"$ROOT/devops/rendered/$DEPLOY_ENV.yaml"}
OUTPUT="$OUTPUT" DEPLOY_ENV="$DEPLOY_ENV" sh "$SCRIPT_DIR/k8s_render.sh"

if [ -n "${KUBE_NAMESPACE-}" ]; then
  assert_manifest_namespace "$OUTPUT" "$KUBE_NAMESPACE"
fi

kubectl apply --dry-run=client -f "$OUTPUT" >/dev/null
log "Validação client-side: OK"

if is_true "${CHECK_SERVER-}"; then
  require_env KUBE_CONTEXT
  require_env KUBE_NAMESPACE
  kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" \
    apply --dry-run=server -f "$OUTPUT" >/dev/null
  log "Validação server-side: OK"
fi
