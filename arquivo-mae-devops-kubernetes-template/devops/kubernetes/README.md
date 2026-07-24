# Kubernetes

## Antes de aplicar

- troque `app-template` pelo nome real;
- ajuste portas e probes;
- ajuste requests/limits;
- confirme se a imagem funciona com filesystem somente leitura;
- confirme o contexto, o API Server esperado e os namespaces dos overlays;
- inclua Ingress/NetworkPolicy apenas após revisão;
- não inclua `Role`, `RoleBinding`, `Secret`, namespace, PVC ou recursos de cluster no fluxo padrão; provisione-os em um processo de plataforma aprovado;
- use tag ou digest imutável.

## Renderização

```sh
IMAGE='registry.example.invalid/team/app:commit-sha' \
K8S_OVERLAY='devops/kubernetes/overlays/development' \
sh scripts/devops/k8s_render.sh
```

O script substitui somente a imagem placeholder após `kubectl kustomize`.
