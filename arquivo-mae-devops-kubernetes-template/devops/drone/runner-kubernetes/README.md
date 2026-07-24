# Drone Kubernetes Runner — template de plataforma

> Infraestrutura sensível. A aplicação e agentes de desenvolvimento não devem instalar ou alterar este runner sem aprovação do time de plataforma.

A documentação atual do Drone classifica o runner Kubernetes como beta/comunitário. Este diretório serve para discussão, teste controlado e bootstrap por administradores.

## Pré-requisitos

- Drone Server self-hosted acessível pelo cluster;
- versão do runner fixada, nunca `latest`;
- segredo RPC igual ao configurado no Drone Server;
- namespace dedicado;
- RBAC revisado;
- capacidade e requests/limits definidos;
- política de Pods e imagens aprovada;
- estratégia de atualização sem interromper pipelines em andamento.

## Isolamento do exemplo

- `drone-runner`: ServiceAccount do processo runner, com permissão para criar Pods e Secrets temporários no namespace dedicado.
- `drone-pipeline`: ServiceAccount usado pelos Pods das pipelines, sem token montado por padrão.
- `policy.yml`: força namespace, recursos e ServiceAccount dos Pods de pipeline.
- credenciais de deploy: fornecidas separadamente pelo Drone Secret/extensão, com acesso apenas ao namespace do ambiente alvo.

Revise a política conforme sua versão do runner. Não permita que um repositório substitua controles de plataforma por configuração própria.

## Secret RPC

Crie fora do Git:

```sh
kubectl --context "$PLATFORM_CONTEXT" --namespace drone-runner \
  create secret generic drone-runner-rpc \
  --from-literal=rpc-secret='<VALOR_DO_COFRE>' \
  --dry-run=client -o yaml | \
  kubectl --context "$PLATFORM_CONTEXT" --namespace drone-runner apply -f -
```

Esse comando é apenas referência e exige aprovação. Não salve o YAML gerado.

## Instalação controlada

1. Substitua todos os `{{PLACEHOLDERS}}`.
2. Fixe o digest da imagem quando possível.
3. Revise `policy.yml`, ServiceAccounts e Role.
4. Execute validação e diff.
5. Aplique somente no contexto de plataforma aprovado.
6. Verifique logs, saúde e conexão com Drone Server.
7. Não reinicie o runner durante pipelines ativos.

```sh
kubectl --context "$PLATFORM_CONTEXT" apply --dry-run=server \
  -k devops/drone/runner-kubernetes
kubectl --context "$PLATFORM_CONTEXT" diff \
  -k devops/drone/runner-kubernetes
```

## Limite de escopo

O Role deste exemplo permite ao runner gerenciar Pods e Secrets temporários apenas no namespace do runner. Ele não concede acesso aos namespaces das aplicações. Deploys em outros clusters/namespaces usam credenciais mínimas separadas nas etapas.
