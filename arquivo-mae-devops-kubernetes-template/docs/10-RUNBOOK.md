# Runbook operacional

## Identificação

| Item | Valor |
|---|---|
| Serviço | `{{NOME}}` |
| Drone repo | `{{OWNER/REPO}}` |
| Deployment | `{{NOME}}` |
| Contexto | `{{CONTEXTO}}` |
| Namespace | `{{NAMESPACE}}` |
| Dashboard | `{{LINK}}` |
| Logs | `{{FERRAMENTA}}` |
| Responsável | `{{TIME}}` |

## Diagnóstico somente leitura

```sh
git status --short --branch
drone build last "$DRONE_REPO"
kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" get deployments,pods,services
kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" describe deployment "$K8S_DEPLOYMENT"
kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" logs "deployment/$K8S_DEPLOYMENT" --tail=200
kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" events --sort-by='.lastTimestamp'
```

## Deploy controlado

Use `docs/16-OPERACAO_DO_PIPELINE.md` e `scripts/devops/k8s_deploy.sh`. Não aplique manualmente em produção como atalho.

## Rollback

Com autorização explícita:

```sh
kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" \
  rollout undo "deployment/$K8S_DEPLOYMENT"
kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" \
  rollout status "deployment/$K8S_DEPLOYMENT" --timeout=180s
```

## Escalonamento

| Severidade | Critério | Canal | Responsável | Prazo |
|---|---|---|---|---|
| `{{SEV}}` | `{{CRITERIO}}` | `{{CANAL}}` | `{{PAPEL}}` | `{{SLA}}` |

## Evidências

Registre commit, build Drone, imagem/digest, ambiente, contexto, namespace, comandos, resultados, métricas, decisão e rollback. Nunca registre segredos.
