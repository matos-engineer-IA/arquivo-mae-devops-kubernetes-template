#!/bin/sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
ROOT=$(CDPATH= cd -- "$SCRIPT_DIR/../.." && pwd)
. "$SCRIPT_DIR/common.sh"

require_command kubectl

DEPLOY_ENV=${DEPLOY_ENV:-development}
case "$DEPLOY_ENV" in
  development|staging|production) ;;
  *) die "DEPLOY_ENV inválido: $DEPLOY_ENV" ;;
esac

K8S_OVERLAY=${K8S_OVERLAY:-"$ROOT/devops/kubernetes/overlays/$DEPLOY_ENV"}
K8S_IMAGE_PLACEHOLDER=${K8S_IMAGE_PLACEHOLDER:-registry.example.invalid/team/app-template:replace-me}
require_env IMAGE

[ -d "$K8S_OVERLAY" ] || die "Overlay não encontrado: $K8S_OVERLAY"
case "$IMAGE" in
  *replace-me*|*example.invalid*|*'{{'* ) die "IMAGE ainda contém placeholder: $IMAGE" ;;
esac

OUTPUT=${OUTPUT:-"$ROOT/devops/rendered/$DEPLOY_ENV.yaml"}
mkdir -p "$(dirname -- "$OUTPUT")"
TMP=$(mktemp_dir)
trap 'rm -rf "$TMP"' EXIT HUP INT TERM

kubectl kustomize "$K8S_OVERLAY" > "$TMP/rendered.yaml"

grep -F "$K8S_IMAGE_PLACEHOLDER" "$TMP/rendered.yaml" >/dev/null 2>&1 || \
  die "Imagem placeholder não encontrada no manifest renderizado."

PLACEHOLDER_ESCAPED=$(printf '%s' "$K8S_IMAGE_PLACEHOLDER" | sed 's/[\\&|]/\\&/g')
IMAGE_ESCAPED=$(printf '%s' "$IMAGE" | sed 's/[\\&|]/\\&/g')
sed "s|$PLACEHOLDER_ESCAPED|$IMAGE_ESCAPED|g" "$TMP/rendered.yaml" > "$OUTPUT"

if grep -Eq '\{\{|replace-me|example\.invalid' "$OUTPUT"; then
  die "Manifest renderizado ainda contém placeholder."
fi

if grep -Eq '^kind: (Namespace|Role|RoleBinding|ClusterRole|ClusterRoleBinding|CustomResourceDefinition|PersistentVolume|PersistentVolumeClaim|ResourceQuota|LimitRange)$' "$OUTPUT"; then
  die "Manifest contém recurso de plataforma, RBAC, armazenamento ou escopo de cluster não permitido por este fluxo."
fi

if grep -Eq '^kind: Secret$' "$OUTPUT"; then
  die "Manifest contém Secret. Use o mecanismo de segredos aprovado fora deste fluxo."
fi

log "Manifest renderizado: $OUTPUT"
