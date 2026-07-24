# Instruções para Claude Code

Estas regras são obrigatórias para todo o repositório.

## Leitura inicial obrigatória

Antes de propor ou executar qualquer alteração:

1. Leia `ARQUIVO_MAE.md`.
2. Leia `docs/13-PROTOCOLO_DE_IA.md`.
3. Consulte `docs/INDEX.md`.
4. Para Git, CI/CD ou cluster, leia `docs/14-DEVOPS_E_CICD.md`, `docs/15-COMANDOS_GIT_DRONE_RANCHER_KUBECTL.md` e `docs/16-OPERACAO_DO_PIPELINE.md` e `docs/19-PLAYBOOK_CLAUDE_CODE_DEVOPS.md`.
5. Leia os documentos relacionados à tarefa.
6. Inspecione o código e os testes afetados.

## Forma de trabalho

Antes de editar, apresente:

- objetivo entendido;
- fatos encontrados;
- informações desconhecidas;
- plano curto;
- arquivos que pretende alterar;
- validações previstas;
- riscos e aprovações necessárias.

Durante a edição:

- limite-se ao escopo;
- faça mudanças pequenas e reversíveis;
- preserve contratos e comportamentos não relacionados;
- não invente requisitos, endpoints, campos, comandos ou credenciais;
- não instale dependências nem altere arquitetura sem aprovação;
- não execute comandos destrutivos;
- não modifique produção;
- não esconda falhas de testes.

Depois da edição:

- revise o diff;
- execute as validações oficiais;
- informe resultados reais, sem presumir sucesso;
- atualize a documentação afetada;
- registre a participação em `docs/CHANGELOG_IA.md`.

## Git

Normalmente permitidos: `status`, `diff`, `log`, `show`, `branch --show-current` e `diff --check`.

Exigem autorização: `commit`, `push`, `merge`, `rebase`, `tag`, `revert` e qualquer alteração remota.

Não use `reset --hard`, `clean -fdx`, `push --force`, `checkout -- .` ou `restore .` para resolver um problema.

## Drone, Rancher e Kubernetes

Execute uma fase do playbook por vez. Uma fase bloqueada ou com falha impede avançar.

Antes de ação remota, declare:

```text
repositório/branch/commit
build e evento Drone
ambiente alvo
Rancher/cluster/contexto/API Server/namespace
imagem/tag/digest
comando pretendido
aprovação
rollback
```

Leitura e diagnóstico são preferíveis. Promoção Drone, troca de contexto, criação de segredo e qualquer escrita Kubernetes exigem autorização.

Antes de aplicar:

1. confirme contexto, API Server e namespace;
2. execute `kubectl auth can-i`;
3. renderize o manifest;
4. confirme ausência de placeholders e segredos;
5. execute dry-run local e no servidor;
6. execute `kubectl diff`;
7. mostre o alvo e os recursos;
8. aplique somente com autorização;
9. aguarde rollout e smoke test.

Nunca use contexto ou namespace implícitos em comando mutável. Nunca leia ou imprima valores de `Secret`, `DRONE_TOKEN`, token Rancher ou kubeconfig. Nunca trate produção como padrão.

## Interrupção obrigatória

Pare e solicite decisão quando houver:

- conflito entre fontes;
- requisito ambíguo com impacto material;
- mudança de escopo;
- dependência nova;
- alteração de banco, contrato, autenticação, infraestrutura ou produção;
- operação destrutiva;
- impossibilidade de validar uma hipótese crítica;
- diff Kubernetes inesperado;
- alvo de cluster não documentado;
- necessidade de privilégio adicional.

## Relatório final

```text
Objetivo:
Resumo:
Arquivos alterados:
Comandos executados:
Validações e resultados:
Git/commit/build:
Ambiente/contexto/API Server/namespace:
Imagem:
Riscos e limitações:
Documentação atualizada:
Como reverter:
Pendências:
```
