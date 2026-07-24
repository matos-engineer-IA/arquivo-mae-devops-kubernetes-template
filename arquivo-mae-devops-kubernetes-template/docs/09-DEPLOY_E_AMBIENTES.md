# Deploy e ambientes

## Ambientes

| Ambiente | Cluster/contexto | Namespace | Origem | Aprovação | Dados |
|---|---|---|---|---|---|
| Local | nenhum ou cluster local | `{{NAMESPACE}}` | máquina local | não aplicável | sintéticos |
| Desenvolvimento | `{{CONTEXT_DEV}}` | `{{NAMESPACE_DEV}}` | promoção Drone | `{{REGRA}}` | sintéticos |
| Homologação | `{{CONTEXT_STAGING}}` | `{{NAMESPACE_STAGING}}` | promoção Drone | manual | conforme política |
| Produção | `{{CONTEXT_PROD}}` | `{{NAMESPACE_PROD}}` | promoção Drone | manual + mudança | reais |

## Ferramentas

| Função | Ferramenta | Fonte de configuração |
|---|---|---|
| Código/revisão | Git + `{{FORGE}}` | repositório |
| Orquestração | Drone self-hosted | `.drone.yml` |
| Gestão de cluster | Rancher | plataforma |
| Aplicação | kubectl/Kustomize | `devops/kubernetes/` |
| Artefatos | `{{REGISTRY}}` | plataforma |
| Segredos | `{{COFRE/DRONE_EXTENSION}}` | fora do Git |

## Pipeline

1. validar documentação;
2. instalar de forma reproduzível;
3. lint e tipos;
4. testes;
5. segurança;
6. build de imagem;
7. publicação com tag imutável;
8. promoção explícita;
9. renderização dos manifests;
10. dry-run local e server-side;
11. diff;
12. apply;
13. rollout status;
14. smoke test e observabilidade;
15. evidências.

## Configuração

| Configuração | Local | Desenvolvimento | Homologação | Produção |
|---|---|---|---|---|
| `KUBE_CONTEXT` | `{{ORIGEM}}` | `{{VALOR}}` | `{{VALOR}}` | `{{VALOR}}` |
| `EXPECTED_KUBE_CONTEXT` | igual ao alvo | igual ao contexto dev | igual ao contexto staging | igual ao contexto prod |
| `EXPECTED_KUBE_SERVER` | URL exata do API Server | endpoint dev | endpoint staging | endpoint prod |
| `KUBE_NAMESPACE` | `{{ORIGEM}}` | `{{VALOR}}` | `{{VALOR}}` | `{{VALOR}}` |
| `EXPECTED_KUBE_NAMESPACE` | igual ao alvo | igual ao namespace dev | igual ao namespace staging | igual ao namespace prod |
| `KUBE_CONFIG_B64` | não usar | segredo Drone dev | segredo Drone staging | segredo Drone prod |
| Configuração da aplicação | `.env` local | ConfigMap/Secret | ConfigMap/Secret | ConfigMap/Secret |

Os valores de contexto, URL do API Server e namespace implementam um binding explícito. Qualquer divergência bloqueia os scripts antes do dry-run.

## Migração

`{{ORDEM_ENTRE_CODIGO_SCHEMA_E_DADOS}}`

Toda migração deve declarar compatibilidade, janela, backup, validação e reversão. Rollback de Deployment não reverte banco automaticamente.

## Rollback

```text
Aplicação: rollout undo ou digest anterior
Configuração: versão anterior no Git
Banco/dados: plano específico aprovado
Infraestrutura: procedimento da plataforma
```

## Critérios de bloqueio

- testes críticos falhando;
- vulnerabilidade fora da política;
- segredo no artefato ou log;
- imagem sem tag/digest imutável;
- manifest com placeholder;
- contexto/namespace desconhecido;
- RBAC excessivo ou insuficiente;
- migração sem reversão;
- ausência de aprovação;
- observabilidade indisponível;
- diff inesperado;
- rollout ou smoke test falhando.
