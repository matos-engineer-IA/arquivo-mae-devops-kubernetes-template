# Templates DevOps

## Estrutura

- `drone/`: pipeline, build de imagem e runner Kubernetes de plataforma.
- `kubernetes/base/`: recursos comuns.
- `kubernetes/overlays/`: diferenças por ambiente.
- `kubernetes/rbac/`: RBAC mínimo de exemplo.
- `rancher/`: orientação de acesso e kubeconfig.
- `environments/`: configuração não sensível de contexto, namespace e overlay por ambiente.

## Ativação

1. Preencha o `ARQUIVO_MAE.md`.
2. Adapte nomes, portas, probes, recursos e imagem.
3. Copie `.drone.yml.example` para `.drone.yml`.
4. Substitua todos os placeholders.
5. Valide localmente e no cluster de desenvolvimento.
6. Não habilite produção antes de testar rollback e observabilidade.

Os arquivos são templates e não devem ser aplicados sem revisão.

## Agentes de IA

O fluxo obrigatório por fases está em `docs/19-PLAYBOOK_CLAUDE_CODE_DEVOPS.md`. Os templates de ambiente não contêm segredos e não devem ser usados para habilitar escrita por padrão.
