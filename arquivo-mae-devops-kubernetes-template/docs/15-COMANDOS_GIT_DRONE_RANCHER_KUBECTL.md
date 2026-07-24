# Comandos Git, Drone, Rancher e kubectl

> Catálogo operacional para pessoas e agentes. Confirme as versões instaladas com `--version` e consulte `--help`. Comandos de escrita obedecem às aprovações do `ARQUIVO_MAE.md`.

## 1. Variáveis esperadas

```sh
export DRONE_SERVER='https://drone.example.invalid'
export DRONE_TOKEN='obtido-do-gerenciador-de-segredos'
export DRONE_REPO='owner/repository'

export RANCHER_URL='https://rancher.example.invalid'
export RANCHER_TOKEN='obtido-do-gerenciador-de-segredos'

export KUBECONFIG='/caminho-fora-do-repositorio/kubeconfig.yaml'
export KUBE_CONTEXT='cluster-context'
export EXPECTED_KUBE_CONTEXT='cluster-context'
export EXPECTED_KUBE_SERVER='https://kubernetes-api.example.invalid'
export KUBE_NAMESPACE='app-development'
export EXPECTED_KUBE_NAMESPACE='app-development'
```

Os valores `EXPECTED_KUBE_CONTEXT`, `EXPECTED_KUBE_SERVER` e `EXPECTED_KUBE_NAMESPACE` devem repetir o alvo aprovado; qualquer divergência bloqueia os scripts.

Nunca use `set -x`, `env`, `printenv`, `kubectl config view --raw` ou comandos equivalentes em sessões com segredos.

## 2. Git

### Inspeção normalmente segura

```sh
git status --short --branch
git branch --show-current
git log --oneline --decorate -n 20
git diff --check
git diff --stat
git diff -- path/to/file
git diff --cached
git show --stat --oneline HEAD
git rev-parse --verify HEAD
```

`git fetch --prune --tags` atualiza referências remotas, mas não altera o working tree. Execute apenas quando acesso de rede for permitido.

### Fluxo de mudança com autorização

```sh
git switch -c feature/123-descricao
git add -- path/to/file another/path
git diff --cached
git commit -m 'feat: descrição objetiva'
git push --set-upstream origin feature/123-descricao
```

### Exigem decisão explícita

```sh
git pull --rebase
git merge <branch>
git rebase <branch>
git commit --amend
git tag <tag>
git push
git revert <commit>
```

### Não executar por conveniência

```sh
git reset --hard
git clean -fdx
git push --force
git push --force-with-lease
git checkout -- .
git restore .
git branch -D <branch>
```

## 3. Drone CLI

### Configuração e leitura

```sh
drone --version
drone repo info "$DRONE_REPO"
drone build ls "$DRONE_REPO" --limit 10
drone build last "$DRONE_REPO"
drone build info "$DRONE_REPO" <BUILD_NUMBER>
drone secret ls "$DRONE_REPO"
```

`drone secret ls` deve mostrar apenas metadados; nunca tente obter ou imprimir valores.

### Escrita controlada

```sh
drone repo enable "$DRONE_REPO"
drone repo update "$DRONE_REPO" --auto-cancel-pushes=true
drone build restart "$DRONE_REPO" <BUILD_NUMBER>
drone build stop "$DRONE_REPO" <BUILD_NUMBER>
drone build approve "$DRONE_REPO" <BUILD_NUMBER> <STAGE>
drone build promote "$DRONE_REPO" <BUILD_NUMBER> development
```

Produção, com parâmetros exigidos pelo template:

```sh
drone build promote "$DRONE_REPO" <BUILD_NUMBER> production \
  --param=ALLOW_PRODUCTION_DEPLOY=1 \
  --param=CHANGE_TICKET=<ID_DA_MUDANCA>
```

### Segredos — execução humana e auditada

```sh
umask 077
KUBECONFIG_B64_FILE=$(mktemp)
trap 'rm -f "$KUBECONFIG_B64_FILE"' EXIT HUP INT TERM
base64 < /caminho/seguro/kubeconfig.yaml | tr -d '\n' > "$KUBECONFIG_B64_FILE"
drone secret add --name kubeconfig_development_b64 \
  --data @"$KUBECONFIG_B64_FILE" \
  "$DRONE_REPO"
rm -f "$KUBECONFIG_B64_FILE"
trap - EXIT HUP INT TERM
```

Não use `--allow-pull-request` para credenciais de deploy.

## 4. Rancher CLI

### Login e seleção

```sh
rancher --version
rancher login "$RANCHER_URL" --token "$RANCHER_TOKEN"
rancher context switch
```

O login e a troca de contexto modificam configuração local e exigem atenção. Não cole tokens em documentação, tickets ou logs.

### Inspeção

```sh
rancher clusters
rancher projects
rancher namespaces
rancher ps
rancher kubectl get pods --namespace "$KUBE_NAMESPACE"
rancher kubectl describe deployment app-template --namespace "$KUBE_NAMESPACE"
```

Para automação no Drone, prefira `kubectl` com kubeconfig mínimo por ambiente. Rancher CLI é mais adequado ao bootstrap e à operação assistida.

## 5. kubectl

### Contexto e autorização

```sh
kubectl config get-contexts
kubectl config current-context
kubectl --context "$KUBE_CONTEXT" config view --minify \
  -o jsonpath='{.clusters[0].cluster.server}{"\n"}'
kubectl --context "$KUBE_CONTEXT" cluster-info
kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" auth can-i get deployments
kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" auth can-i patch deployments
```

### Inspeção

```sh
kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" get deployments,pods,services
kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" describe deployment app-template
kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" logs deployment/app-template --tail=200
kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" events --sort-by='.lastTimestamp'
kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" rollout history deployment/app-template
kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" rollout status deployment/app-template --timeout=180s
```

### Renderização e validação

```sh
kubectl kustomize devops/kubernetes/overlays/development > /tmp/rendered.yaml
kubectl apply --dry-run=client -f /tmp/rendered.yaml
kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" \
  apply --dry-run=server -f /tmp/rendered.yaml
kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" \
  diff -f /tmp/rendered.yaml
```

`kubectl diff` retorna normalmente `0` sem diferença, `1` quando há diferença e valor maior que `1` em erro. Não trate o código `1` como falha operacional.

### Escrita controlada

```sh
kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" apply -f /tmp/rendered.yaml
kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" \
  rollout status deployment/app-template --timeout=180s
kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" \
  rollout undo deployment/app-template
```

### Comandos de alto risco

Exigem comando exato, recurso exato, ambiente confirmado e autorização explícita:

```text
kubectl delete
kubectl patch
kubectl edit
kubectl scale
kubectl rollout restart
kubectl exec
kubectl drain
kubectl cordon
kubectl uncordon
kubectl create secret
```

## 6. Sequência mínima para o agente

```text
1. git status/diff
2. validar documentação e código
3. identificar commit e imagem
4. drone build info
5. kubectl auth can-i
6. renderizar manifests
7. dry-run local
8. dry-run no servidor
9. kubectl diff
10. solicitar/verificar autorização
11. apply
12. rollout status
13. smoke test
14. registrar evidências
```
