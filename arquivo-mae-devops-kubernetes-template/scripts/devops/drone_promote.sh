#!/bin/sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
. "$SCRIPT_DIR/common.sh"

require_command drone
require_env DRONE_SERVER
require_env DRONE_TOKEN
require_env DRONE_REPO

BUILD_NUMBER=${1-}
TARGET=${2-}
[ -n "$BUILD_NUMBER" ] || die "Uso: $0 <BUILD_NUMBER> <development|staging|production>"
case "$BUILD_NUMBER" in *[!0-9]*) die "BUILD_NUMBER deve ser numérico." ;; esac
case "$TARGET" in
  development|staging|production) ;;
  *) die "TARGET inválido: $TARGET" ;;
esac

is_true "${ALLOW_DRONE_WRITE-}" || die "ALLOW_DRONE_WRITE=1 é obrigatório para promover."

log "Promoção: repo=$DRONE_REPO build=$BUILD_NUMBER target=$TARGET"
drone build info "$DRONE_REPO" "$BUILD_NUMBER"

if [ "$TARGET" = "production" ]; then
  is_true "${ALLOW_PRODUCTION_DEPLOY-}" || die "ALLOW_PRODUCTION_DEPLOY=1 é obrigatório para promoção de produção."
  require_env CHANGE_TICKET
  drone build promote "$DRONE_REPO" "$BUILD_NUMBER" "$TARGET" \
    --param=ALLOW_PRODUCTION_DEPLOY=1 \
    --param="CHANGE_TICKET=$CHANGE_TICKET"
else
  drone build promote "$DRONE_REPO" "$BUILD_NUMBER" "$TARGET"
fi

log "Promoção solicitada. Acompanhe o novo build no Drone e não presuma sucesso."
