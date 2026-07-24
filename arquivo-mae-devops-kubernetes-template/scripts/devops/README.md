# Scripts DevOps com guardrails

Todos os scripts usam `set -eu`, falham quando variáveis obrigatórias estão ausentes e evitam um alvo implícito de produção. Contexto, URL do API Server e namespace são comparados com valores aprovados antes de qualquer escrita.

| Script | Finalidade | Efeito padrão |
|---|---|---|
| `git_snapshot.sh` | registrar branch, commit e diffs | somente leitura |
| `preflight.sh` | verificar base, CLI, acesso e RBAC | somente leitura |
| `k8s_render.sh` | renderizar Kustomize e trocar imagem | grava apenas em `devops/rendered/` |
| `k8s_validate.sh` | validar client-side e opcionalmente server-side | sem aplicar |
| `k8s_deploy.sh` | dry-run, diff, apply e rollout | não aplica sem gate explícito |
| `drone_promote.sh` | promover um build existente | não promove sem gate explícito |

## Gates

- `ALLOW_CLUSTER_WRITE=1`: libera o `apply` após preflight, render, dry-run e diff.
- `ALLOW_DRONE_WRITE=1`: libera promoção pelo Drone CLI.
- `ALLOW_PRODUCTION_DEPLOY=1`: gate adicional de produção.
- `CHANGE_TICKET`: obrigatório no fluxo de produção deste template.
- `DRY_RUN_ONLY=1`: força término antes do `apply`.

Esses gates evitam acidentes simples, mas **não são autorização por si só**. RBAC, revisão, branch protection, promoção controlada e aprovação humana continuam obrigatórios.

## Regra para agentes

Claude Code, Codex e outros agentes devem executar uma fase por vez, relatar o resultado e parar em qualquer divergência de contexto, namespace, imagem, diff, RBAC ou aprovação. O playbook oficial está em `docs/19-PLAYBOOK_CLAUDE_CODE_DEVOPS.md`.
