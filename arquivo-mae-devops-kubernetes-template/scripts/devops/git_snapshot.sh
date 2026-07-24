#!/bin/sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
. "$SCRIPT_DIR/common.sh"

require_command git
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || die "Diretório atual não é um repositório Git."

log "Branch e estado"
git status --short --branch

log "Commit atual"
git show --no-patch --oneline --decorate HEAD

log "Resumo do diff não staged"
git diff --stat

log "Resumo do diff staged"
git diff --cached --stat

log "Verificação de whitespace"
git diff --check

log "Snapshot concluído sem alteração do repositório."
