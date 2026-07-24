# Como contribuir

## 1. Antes de começar

- Leia `ARQUIVO_MAE.md`, `docs/INDEX.md` e os ADRs aplicáveis.
- Confirme requisito, critérios de aceitação, escopo e responsável.
- Execute `python3 scripts/verificar_base.py` e `sh scripts/devops/git_snapshot.sh`.
- Crie ou vincule uma tarefa rastreável.
- Trabalhe a partir da branch definida em `docs/14-DEVOPS_E_CICD.md`.
- Não sobrescreva mudanças locais que não pertencem à tarefa.

## 2. Durante o desenvolvimento

- Faça mudanças pequenas, coesas e reversíveis.
- Preserve compatibilidade por padrão.
- Não misture correção, refatoração e atualização de dependências sem necessidade.
- Escreva ou atualize testes.
- Atualize documentação, manifests e diagramas afetados.
- Não coloque credenciais, kubeconfigs, dumps ou dados reais no repositório.
- Não altere pipeline, RBAC ou infraestrutura como efeito colateral.

## 3. Git

Fluxo de referência, sempre respeitando a autorização do projeto:

```sh
git status --short --branch
git switch -c feature/123-descricao
git add -- path/to/explicit/files
git diff --cached
git commit -m 'feat: descricao objetiva'
git push --set-upstream origin feature/123-descricao
```

Regras:

- uma intenção principal por commit;
- stage explícito por caminho;
- revisar `git diff --cached` antes do commit;
- não usar force push, reset destrutivo ou limpeza ampla;
- tags e releases seguem o processo documentado, não decisões individuais.

## 4. Pull request

A descrição deve informar:

- problema e solução;
- tarefa e critérios de aceitação;
- arquivos e componentes afetados;
- riscos e limitações;
- testes e scanners executados;
- impacto em contratos, dados, segurança e desempenho;
- impacto em Docker, Drone, Rancher, Kubernetes e observabilidade;
- imagem, manifests e migrações, quando aplicável;
- plano de deploy e reversão.

Use `.github/pull_request_template.md`.

## 5. CI/CD

- Pull requests executam validações sem credenciais de deploy.
- Publicação de imagem ocorre apenas nos eventos autorizados.
- A imagem deve ter identidade imutável vinculada ao commit.
- Deploy ocorre por promoção ou processo aprovado; push comum não deve atingir produção.
- `kubectl diff`, rollout e smoke tests devem gerar evidências.
- Falha de pipeline não deve ser contornada desabilitando controle.

## 6. Participação de IA

Claude Code, Codex e outros agentes devem seguir `CLAUDE.md`, `AGENTS.md` e `docs/19-PLAYBOOK_CLAUDE_CODE_DEVOPS.md`. Registre alterações assistidas em `docs/CHANGELOG_IA.md`.
