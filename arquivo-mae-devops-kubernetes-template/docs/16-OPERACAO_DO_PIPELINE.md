# Operação do pipeline

## 1. Pré-requisitos

- Drone Server self-hosted e runner compatível. O template de plataforma está em `devops/drone/runner-kubernetes/` e exige aprovação administrativa.
- Repositório habilitado no Drone e webhook funcional.
- Registry aprovado.
- Cluster Kubernetes administrado pelo Rancher.
- Namespace e RBAC provisionados por ambiente.
- `git`, `drone`, `rancher` e `kubectl` nas versões aprovadas.
- Credenciais de deploy distintas e mínimas.

## 2. Bootstrap

1. Preencher `ARQUIVO_MAE.md` e a identidade operacional dos ambientes.
2. Copiar `.drone.yml.example` para `.drone.yml`.
3. Substituir todos os `{{PLACEHOLDERS}}`.
4. Adaptar os comandos de qualidade à stack.
5. Definir o construtor/publicador de imagem aprovado.
6. Adaptar `devops/kubernetes/base/` e overlays.
7. Validar probes, portas, recursos e `securityContext`.
8. Provisionar namespace e RBAC fora do pipeline de aplicação.
9. Baixar ou gerar kubeconfig mínimo por ambiente via processo do Rancher.
10. Registrar os kubeconfigs como segredos Drone, sem liberar para pull requests.
11. Habilitar o repositório no Drone.
12. Executar um build de teste e uma promoção para desenvolvimento.

## 3. Verificações locais

```sh
python3 scripts/verificar_base.py
sh scripts/devops/git_snapshot.sh
sh scripts/devops/preflight.sh local
IMAGE='registry.example.invalid/team/app:commit-sha' \
  K8S_OVERLAY='devops/kubernetes/overlays/development' \
  sh scripts/devops/k8s_render.sh
```

## 4. Verificação de acesso ao cluster

```sh
export KUBECONFIG='/caminho/seguro/kubeconfig.yaml'
export KUBE_CONTEXT='{{CONTEXTO}}'
export EXPECTED_KUBE_CONTEXT='{{CONTEXTO}}'
export EXPECTED_KUBE_SERVER='{{URL_EXATA_DO_API_SERVER}}'
export KUBE_NAMESPACE='{{NAMESPACE}}'
export EXPECTED_KUBE_NAMESPACE='{{NAMESPACE}}'
sh scripts/devops/preflight.sh cluster-read
```

Não use kubeconfig de administrador. A verificação deve falhar quando contexto, API Server ou namespace não estiverem explicitamente definidos ou divergirem da identidade aprovada.

## 5. CI

Fluxo esperado:

1. push ou pull request aciona webhook;
2. Drone cria Pod efêmero;
3. valida a base;
4. instala dependências de forma reproduzível;
5. executa lint, tipos, testes e build;
6. executa segurança conforme política;
7. publica imagem imutável apenas em eventos autorizados;
8. registra build, commit e digest.

Comandos de acompanhamento:

```sh
drone repo info "$DRONE_REPO"
drone build ls "$DRONE_REPO" --limit 10
drone build info "$DRONE_REPO" <BUILD_NUMBER>
```

## 6. Promoção para desenvolvimento

```sh
export ALLOW_DRONE_WRITE=1
sh scripts/devops/drone_promote.sh <BUILD_NUMBER> development
```

A pipeline deve usar o commit do build promovido. Depois do deploy:

```sh
kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" \
  rollout status deployment/app-template --timeout=180s
```

## 7. Promoção para produção

Pré-condições:

- build e imagem já validados;
- homologação concluída;
- janela e mudança aprovadas;
- métricas e logs disponíveis;
- rollback definido;
- responsáveis de operação disponíveis.

```sh
export ALLOW_DRONE_WRITE=1
export ALLOW_PRODUCTION_DEPLOY=1
export CHANGE_TICKET='CHG-0000'
sh scripts/devops/drone_promote.sh <BUILD_NUMBER> production
```

O script de deploy valida novamente `ALLOW_PRODUCTION_DEPLOY` e `CHANGE_TICKET` dentro da etapa.

## 8. Falha de rollout

1. Não afirmar sucesso.
2. Coletar `get`, `describe`, `logs` e eventos sem exibir segredos.
3. Verificar imagem, probes, ConfigMaps, quotas e permissões.
4. Comparar com a revisão anterior.
5. Decidir entre correção para frente e rollback.
6. Com autorização:

```sh
kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" \
  rollout undo deployment/app-template
kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" \
  rollout status deployment/app-template --timeout=180s
```

7. Abrir incidente ou registrar falha no changelog.

## 9. Diagnóstico rápido

| Sintoma | Verificar | Ação segura inicial |
|---|---|---|
| Drone não inicia | webhook e repo habilitado | `drone repo info` |
| Pipeline sem runner | labels/capacidade do runner | consultar administração Drone |
| ImagePullBackOff | tag, registry e pull secret | `describe pod` |
| Forbidden | RBAC/contexto/namespace | `kubectl auth can-i` |
| CrashLoopBackOff | logs, configuração e probes | `logs --previous` quando aplicável |
| ProgressDeadlineExceeded | readiness, imagem e recursos | `describe deployment` |
| Diff inesperado | overlay e recurso vivo | interromper e revisar |

## 10. Evidência mínima

```text
Commit:
Build Drone:
Imagem/tag/digest:
Ambiente:
Contexto/namespace:
Resultado do dry-run:
Resumo do diff:
Resultado do apply:
Resultado do rollout:
Smoke tests:
Métricas/logs observados:
Rollback disponível:
Aprovação/ticket:
```
