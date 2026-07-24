## Problema e tarefa

- Tarefa/ticket: `{{ID_OU_LINK}}`
- Problema: `{{DESCREVA_O_PROBLEMA}}`
- Critérios de aceitação: `{{CRITERIOS}}`

## Solução

`{{DESCREVA_A_MUDANCA_E_POR_QUE_ESTA_ABORDAGEM_FOI_ESCOLHIDA}}`

## Escopo

- [ ] A alteração está limitada à tarefa.
- [ ] Não inclui refatoração ou dependência não relacionada.
- [ ] Mudanças locais preexistentes foram preservadas.

## Impactos

| Área | Impacto |
|---|---|
| Contratos/APIs | `{{NENHUM_OU_DESCRICAO}}` |
| Dados/migrações | `{{NENHUM_OU_DESCRICAO}}` |
| Segurança/privacidade | `{{NENHUM_OU_DESCRICAO}}` |
| Desempenho/capacidade | `{{NENHUM_OU_DESCRICAO}}` |
| Compatibilidade | `{{NENHUM_OU_DESCRICAO}}` |
| Docker/imagem | `{{NENHUM_OU_DESCRICAO}}` |
| Drone/pipeline | `{{NENHUM_OU_DESCRICAO}}` |
| Rancher/Kubernetes/RBAC | `{{NENHUM_OU_DESCRICAO}}` |
| Observabilidade | `{{NENHUM_OU_DESCRICAO}}` |

## Validações executadas

```text
{{COMANDOS_E_RESULTADOS_REAIS}}
```

- [ ] Lint/tipos/testes aplicáveis passaram.
- [ ] Build foi executado.
- [ ] Scan de segredos e vulnerabilidades foi revisado.
- [ ] `git diff --check` passou.
- [ ] Manifests foram renderizados e validados, quando aplicável.
- [ ] Nenhum segredo ou dado sensível aparece no diff/log.

## Evidências de CI/CD

- Commit SHA: `{{SHA}}`
- Build Drone: `{{NUMERO_OU_LINK}}`
- Imagem/tag/digest: `{{IDENTIDADE_OU_NAO_APLICAVEL}}`
- Ambiente/contexto/API Server/namespace: `{{ALVO_OU_NAO_APLICAVEL}}`
- Resumo do `kubectl diff`: `{{RESUMO_OU_NAO_APLICAVEL}}`
- Rollout/smoke test: `{{RESULTADO_OU_NAO_APLICAVEL}}`

## Riscos e limitações

`{{RISCOS_INCLUSIVE_O_QUE_NAO_PODE_SER_VALIDADO}}`

## Deploy e reversão

- Estratégia de deploy: `{{DESCRICAO}}`
- Como reverter código/configuração: `{{DESCRICAO}}`
- Como reverter dados/migração: `{{DESCRICAO_OU_NAO_APLICAVEL}}`

## Documentação

- [ ] Documentação afetada atualizada.
- [ ] ADR criado ou atualizado, quando necessário.
- [ ] `docs/CHANGELOG_IA.md` atualizado, quando aplicável.
