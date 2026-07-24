# Rancher e acesso aos clusters

## Papel do Rancher

Rancher administra clusters, projetos, usuários e kubeconfigs. O deploy da aplicação continua sendo feito por `kubectl` a partir dos manifests versionados.

## Uso humano

```sh
rancher login "$RANCHER_URL" --token "$RANCHER_TOKEN"
rancher context switch
rancher kubectl get pods --namespace "$KUBE_NAMESPACE"
```

## Uso no Drone

1. Criar identidade mínima por ambiente.
2. Obter kubeconfig associado a essa identidade.
3. Confirmar que não possui `cluster-admin`.
4. Testar `kubectl auth can-i`.
5. Armazenar o kubeconfig como segredo Drone em base64.
6. Não disponibilizar o segredo para pull requests.
7. Renovar conforme política.

Não armazene kubeconfig nesta pasta ou em qualquer parte do Git.
