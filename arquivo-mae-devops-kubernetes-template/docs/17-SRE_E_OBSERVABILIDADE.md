# SRE e observabilidade

## 1. Sinais essenciais

| Sinal | Métrica/consulta | Meta | Alerta | Dono |
|---|---|---|---|---|
| Disponibilidade | `{{METRICA}}` | `{{SLO}}` | `{{LIMIAR}}` | `{{TIME}}` |
| Latência | `{{PERCENTIL}}` | `{{META}}` | `{{LIMIAR}}` | `{{TIME}}` |
| Erros | `{{METRICA}}` | `{{META}}` | `{{LIMIAR}}` | `{{TIME}}` |
| Saturação | CPU/memória/fila | `{{META}}` | `{{LIMIAR}}` | `{{TIME}}` |

## 2. Requisitos antes de produção

- logs estruturados com correlação;
- métricas técnicas e de negócio;
- health/readiness/liveness coerentes;
- dashboard por serviço e ambiente;
- alertas acionáveis;
- retenção e mascaramento de dados;
- vínculo entre release, commit, imagem e incidente;
- runbook e responsável de plantão.

## 3. Pós-deploy

1. confirmar rollout;
2. verificar réplicas prontas;
3. executar smoke test;
4. observar erro, latência e saturação;
5. comparar com baseline anterior;
6. registrar evidência;
7. reverter quando critérios forem violados.

## 4. Orçamento de erro

| Período | SLO | Orçamento | Consumo atual | Política |
|---|---:|---:|---:|---|
| `{{30_DIAS}}` | `{{99.9%}}` | `{{VALOR}}` | `{{VALOR}}` | `{{AÇÃO}}` |

## 5. Incidente

- Prioridade: `{{SEVERIDADE}}`.
- Canal: `{{CANAL}}`.
- Responsável: `{{PAPEL}}`.
- Critério de rollback: `{{CRITERIO}}`.
- Fonte de logs: `{{FERRAMENTA}}`.
- Fonte de métricas: `{{FERRAMENTA}}`.
- Pós-incidente: `{{PROCESSO}}`.
