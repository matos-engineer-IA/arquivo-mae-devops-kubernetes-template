# Protocolo de trabalho com agentes de IA

Este documento define como agentes de IA devem analisar, alterar e relatar mudanças no projeto.

## 1. Objetivo

Reduzir:

- alucinações;
- mudanças fora de escopo;
- duplicação de soluções;
- alterações incompatíveis;
- uso indevido de credenciais;
- comandos destrutivos;
- conclusões sem validação;
- perda de rastreabilidade.

O protocolo diminui riscos, mas não substitui revisão humana, testes, controles de acesso e backups.

## 2. Preparação obrigatória

Antes de editar, o agente deve ler:

1. `ARQUIVO_MAE.md`;
2. este documento;
3. `docs/INDEX.md`;
4. requisitos, arquitetura, regras, contratos, segurança e testes relacionados;
5. código e testes diretamente afetados;
6. ADRs relevantes.

## 3. Classificação das informações

Toda análise material deve separar:

### FATO

Informação confirmada por código, teste, contrato, documento aprovado ou saída real de ferramenta.

### HIPÓTESE

Interpretação plausível que ainda precisa ser validada.

### DESCONHECIDO

Informação necessária que não foi encontrada.

O agente não pode transformar hipótese em fato apenas para continuar.

## 4. Contrato da tarefa

Antes de alterar arquivos, registre:

```text
Objetivo:
Critérios de aceitação:
Fatos encontrados:
Hipóteses:
Desconhecidos:
Fora do escopo:
Arquivos pretendidos:
Plano:
Validações:
Riscos:
Aprovações necessárias:
```

## 5. Inspeção mínima

O agente deve:

- localizar a implementação atual;
- identificar pontos de entrada;
- identificar consumidores e dependências;
- procurar testes existentes;
- procurar soluções equivalentes;
- revisar configuração e contratos relacionados;
- verificar ADRs;
- verificar se o arquivo está gerado automaticamente;
- verificar se existem instruções locais em subpastas.

## 6. Regras de alteração

### Obrigatório

- Modificar apenas o necessário.
- Preservar estilo e convenções existentes.
- Manter compatibilidade por padrão.
- Validar entradas nas fronteiras.
- Tratar erros de maneira explícita.
- Atualizar testes e documentação afetados.
- Manter a mudança reversível.
- Revisar o diff completo.

### Proibido sem aprovação

- Nova dependência.
- Atualização ampla de dependências.
- Mudança de arquitetura.
- Mudança de contrato público.
- Migração de banco.
- Mudança de autenticação ou autorização.
- Alteração de infraestrutura ou pipeline.
- Escrita em produção.
- Operação destrutiva.
- Remoção de funcionalidade.
- Desativação de testes ou controles.
- Ampliação de escopo.

### Sempre proibido

- Inserir segredos no repositório.
- Inventar credenciais.
- Exfiltrar dados.
- Ocultar falhas.
- Alegar testes não executados.
- Apagar evidências de erro.
- Contornar controles de segurança.
- Usar dados reais em exemplos sem autorização.

## 7. Política de edição mínima

Antes de criar algo novo, verifique:

1. Existe módulo equivalente?
2. Existe função reutilizável?
3. Existe padrão semelhante?
4. Existe contrato que já resolve o problema?
5. Existe uma correção menor que evita reestruturação?

Não faça “limpeza” em arquivos não relacionados.

## 8. Política para código aparentemente sem uso

Antes de remover, procure:

- importações diretas;
- referências por string;
- reflexão;
- registro de plugins;
- rotas;
- configuração;
- injeção de dependência;
- jobs;
- scripts;
- templates;
- chamadas externas;
- uso em testes;
- carregamento dinâmico.

Sem evidência suficiente, registre como desconhecido e não remova.

## 9. Política de comandos

### Pode executar, quando aplicável

- inspeção e busca;
- status e diff do Git;
- testes locais;
- lint;
- tipos;
- build;
- ferramentas em `dry-run`.

### Requer aprovação

- instalar ou atualizar pacotes;
- gerar ou aplicar migrações;
- escrever em serviços externos;
- publicar artefatos;
- fazer push, merge ou rebase;
- alterar pipeline;
- usar ambiente compartilhado.

### Não executar sem autorização explícita

- exclusão em massa;
- reset destrutivo;
- force push;
- remoção de banco ou recurso;
- rotação de segredo;
- alteração de produção;
- comandos com impacto irreversível.

## 10. Protocolo de Git, pipeline e Kubernetes

Antes de ação remota, o agente deve declarar repositório, branch, commit, build, ambiente, cluster/contexto, namespace, imagem e aprovação.

### Normalmente permitido

- Git: status, diff, log, show e verificações.
- Drone: repo info, build list/last/info.
- Rancher/kubectl: listagem, describe, logs, events, auth can-i, rollout status e diff.

### Exige autorização

- commit, push, merge, rebase, tag ou revert;
- habilitar/alterar repo Drone;
- promover, reiniciar, parar ou aprovar build;
- criar, alterar ou remover segredo;
- login/troca de contexto Rancher;
- apply, undo, restart, patch, edit, scale, exec ou delete no Kubernetes.

### Sequência de deploy

1. Confirmar documentação e alvo.
2. Verificar RBAC.
3. Renderizar e procurar placeholders/segredos.
4. Validar client-side.
5. Validar server-side.
6. Executar diff.
7. Obter/verificar autorização.
8. Aplicar com contexto e namespace explícitos.
9. Aguardar rollout.
10. Executar smoke test e observar sinais.
11. Registrar evidências e reversão.

Produção exige `ALLOW_PRODUCTION_DEPLOY=1`, referência de mudança e aprovação humana. Esses gates não substituem RBAC nem políticas do servidor.

## 11. Validação

O agente deve executar as validações oficiais documentadas. Quando uma validação não puder ser executada:

- diga qual não foi executada;
- explique o motivo;
- informe o risco;
- não afirme conclusão total;
- forneça o comando para execução posterior.

Uma falha preexistente deve ser diferenciada de uma falha introduzida pela mudança.

## 12. Revisão do diff

Antes de concluir:

- confirme que somente arquivos esperados mudaram;
- procure segredos e dados sensíveis;
- procure logs temporários;
- procure código comentado e `TODO` não aprovado;
- verifique alterações acidentais em lockfiles;
- verifique quebra de compatibilidade;
- verifique documentação e testes;
- confirme que arquivos gerados não foram editados manualmente.

## 13. Relatório final obrigatório

```text
Objetivo:
Mudança realizada:
Arquivos alterados:
Comportamento anterior:
Comportamento novo:
Validações executadas:
Resultados:
Validações não executadas:
Riscos e limitações:
Documentação atualizada:
Como reverter:
Pendências:
```

## 14. Registro

Toda mudança implementada com auxílio de IA deve ser resumida em `CHANGELOG_IA.md`.

O registro deve ser objetivo e não incluir raciocínio privado, credenciais ou dados sensíveis.
