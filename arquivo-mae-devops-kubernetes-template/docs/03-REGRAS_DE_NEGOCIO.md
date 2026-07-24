# Regras de negócio

Cada regra deve ser clara, testável e ter uma origem identificável.

| ID | Regra | Exceções | Fonte | Teste |
|---|---|---|---|---|
| RN-001 | `{{REGRA}}` | `{{EXCECAO_OU_NENHUMA}}` | `{{FONTE}}` | `{{CENARIO}}` |

## Estados e transições

| Estado atual | Evento | Condição | Próximo estado | Ação |
|---|---|---|---|---|
| `{{ESTADO}}` | `{{EVENTO}}` | `{{CONDICAO}}` | `{{PROXIMO}}` | `{{ACAO}}` |

## Prioridades e precedência

1. `{{REGRA_MAIS_FORTE}}`
2. `{{REGRA_SEGUINTE}}`

## Casos proibidos

- `{{COMPORTAMENTO_QUE_NUNCA_DEVE_OCORRER}}`
