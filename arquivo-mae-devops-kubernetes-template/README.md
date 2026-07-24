# Arquivo-Mãe — template universal de projeto

## O que é

`ARQUIVO_MAE.md` é a **documentação central** do projeto: constituição, índice e contrato operacional. Ele registra o que está sendo construído, quais fontes são oficiais, quais limites existem e como pessoas e agentes de IA devem trabalhar.

Ele não deve carregar todos os detalhes. A documentação especializada fica em `docs/`, enquanto o arquivo-mãe aponta para cada fonte e resolve precedência.

## O que esta versão adiciona

- protocolo seguro para Claude Code e Codex;
- catálogo de comandos Git, Drone, Rancher e kubectl;
- pipeline Drone Kubernetes de exemplo;
- manifests Kustomize para três ambientes;
- RBAC mínimo de referência;
- scripts com dry-run, diff, gates e bloqueio de produção;
- práticas de CI/CD, SRE, observabilidade e supply chain;
- checklists de release e rollback;
- playbook linear específico para Claude Code/Codex;
- templates não sensíveis de alvo por ambiente.

## Estrutura principal

```text
ARQUIVO_MAE.md
CLAUDE.md
AGENTS.md
.drone.yml.example
Makefile
docs/
devops/
  drone/
  kubernetes/
  rancher/
  environments/
scripts/devops/
checklists/
diagrams/
prototypes/
```

## Primeiros passos

1. Copie a estrutura para a raiz do projeto.
2. Preencha primeiro `ARQUIVO_MAE.md`.
3. Leia `docs/19-PLAYBOOK_CLAUDE_CODE_DEVOPS.md` antes de habilitar ações remotas para agentes.
4. Execute:

```sh
python3 scripts/verificar_base.py
```

5. Preencha contexto, arquitetura, comandos oficiais e ambientes.
6. Adapte `devops/kubernetes/` à aplicação.
7. Copie `.drone.yml.example` para `.drone.yml` apenas depois de substituir os placeholders.
8. Configure segredos no gerenciador aprovado/Drone, nunca no Git.
9. Teste CI e deploy apenas no ambiente de desenvolvimento.
10. Habilite homologação/produção após validar observabilidade e rollback.

## Guardrails

Os scripts de deploy exigem contexto, API Server esperado, namespace, imagem e permissões explícitos. Por padrão executam validação e diff; a escrita exige `ALLOW_CLUSTER_WRITE=1`. Produção exige também `ALLOW_PRODUCTION_DEPLOY=1` e `CHANGE_TICKET`.

Essas variáveis são gates adicionais, não substitutos de RBAC, aprovação humana, branch protection ou políticas do Drone/Rancher.

## Limites

O template não instala Drone, runner, Rancher, Kubernetes, registry ou ferramentas de observabilidade. Os comandos de build/teste dependem da stack. O pipeline Kubernetes do Drone pressupõe instalação self-hosted e precisa ser avaliado conforme a versão e o suporte da organização.
