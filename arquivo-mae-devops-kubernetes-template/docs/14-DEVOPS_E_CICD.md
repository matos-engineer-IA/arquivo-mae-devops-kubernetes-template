# DevOps e CI/CD

> Template de decisões. Preencha os campos `{{...}}` antes de habilitar o pipeline.

## 1. Objetivo

Definir uma entrega previsível, auditável e reversível, na qual Git registra a mudança, Drone executa CI/CD, Rancher administra o acesso aos clusters e `kubectl` valida/aplica os manifests Kubernetes.

## 2. Arquitetura da entrega

```text
Desenvolvedor/Claude Code
        |
        v
Git + Pull Request
        |
        | webhook
        v
Drone Server (self-hosted)
        |
        v
Drone Kubernetes Runner -> Pods efêmeros de CI
        |
        +--> testes, lint, segurança e build
        +--> registry: imagem imutável
        |
        | promoção explícita
        v
Etapa de deploy com credencial mínima
        |
        v
Kubernetes administrado pelo Rancher
        |
        v
rollout -> smoke test -> métricas/logs -> evidências
```

### Responsabilidades

| Componente | Responsabilidade | Não deve fazer |
|---|---|---|
| Git | versionar, revisar e acionar webhook | armazenar segredos |
| Drone | orquestrar CI, promoção e auditoria | decidir ambiente por suposição |
| Rancher | administrar clusters, projetos e acessos | substituir os manifests versionados |
| kubectl | validar, comparar, aplicar e acompanhar rollout | usar contexto implícito em escrita |
| Registry | armazenar imagem imutável | depender apenas de `latest` |
| Claude Code/Codex | analisar, editar, validar e relatar | promover ou aplicar sem autorização |

## 3. Estratégia de branches

| Tipo | Padrão | Origem | Destino | Vida útil |
|---|---|---|---|---|
| Principal | `{{main}}` | — | produção por promoção | longa |
| Funcionalidade | `feature/{{id}}-{{descricao}}` | principal | PR | curta |
| Correção | `fix/{{id}}-{{descricao}}` | principal | PR | curta |
| Hotfix | `hotfix/{{id}}-{{descricao}}` | tag/produção aprovada | PR controlado | curta |

Regras:

- proteger a branch principal;
- exigir revisão e pipeline aprovado;
- proibir push direto quando aplicável;
- manter commits coesos;
- não misturar refatoração ampla com correção funcional;
- usar merge strategy definida: `{{SQUASH / MERGE COMMIT / REBASE}}`.

## 4. Pipeline de referência

| Estágio | Executa em | Gate | Saída |
|---|---|---|---|
| Base | todo evento | documentação consistente | relatório |
| Qualidade | push/PR/tag | lint, tipos e testes | evidências |
| Segurança | push/PR/tag | política de severidade | relatórios/SBOM |
| Build | branch/tag aprovada | build reproduzível | imagem pelo SHA |
| Publicação | branch/tag aprovada | credencial de registry | imagem imutável |
| Deploy dev | promoção `development` | dry-run + diff | release dev |
| Deploy staging | promoção `staging` | aprovação | release candidata |
| Deploy produção | promoção `production` | aprovação + mudança | release |
| Pós-deploy | todo deploy | rollout + smoke test | evidências |

## 5. Build once, promote many

- A mesma imagem deve atravessar os ambientes.
- Tag mínima: commit completo ou identificador imutável equivalente.
- Registrar também o digest quando o registry disponibilizar.
- Não reconstruir a imagem durante promoção.
- Configuração específica de ambiente deve vir de ConfigMap, Secret ou ferramenta aprovada, não de recompilação.

## 6. Kubernetes

- Usar Kustomize, Helm ou ferramenta aprovada: `{{FERRAMENTA}}`.
- Manter base e overlays versionados.
- Fixar contexto, API Server esperado e namespace em todas as operações mutáveis.
- Usar RBAC por ambiente, sem `cluster-admin`.
- Não conceder leitura de `Secret` ao pipeline sem necessidade.
- Definir requests/limits, probes, estratégia de rollout e `securityContext`.
- Fazer `dry-run=server`, `diff`, `apply`, `rollout status` e smoke test.

## 7. Promoção e aprovações

| Ambiente | Quem pode promover | Pré-condições | Evidência |
|---|---|---|---|
| Desenvolvimento | `{{PAPEL}}` | CI verde | build Drone |
| Homologação | `{{PAPEL}}` | dev validado | aprovação |
| Produção | `{{PAPEL}}` | homologação + mudança + rollback | ticket e build |

Produção não pode ser acionada por push comum. Use promoção explícita e segregação de funções.

## 8. Rollback

- Aplicação sem migração incompatível: `kubectl rollout undo` ou reaplicar digest anterior.
- Configuração: reaplicar versão anterior do Git.
- Banco: seguir plano próprio de migração e restauração.
- Critério de rollback automático: `{{CRITERIO}}`.
- Critério de rollback humano: `{{CRITERIO}}`.

## 9. Runner Kubernetes do Drone

O template assume Drone self-hosted. Antes de produção, registrar:

| Item | Valor |
|---|---|
| Versão Drone Server | `{{VERSAO}}` |
| Versão runner | `{{VERSAO}}` |
| Versão Kubernetes suportada | `{{VERSAO}}` |
| Namespace do runner | `{{NAMESPACE}}` |
| API Server/cluster do runner | `{{URL_OU_IDENTIFICADOR}}` |
| ServiceAccount/RBAC | `{{REFERENCIA}}` |
| Limites de concorrência | `{{VALOR}}` |
| Política de atualização | `{{POLITICA}}` |
| Plano de contingência | `{{PLANO}}` |

A documentação atual do Drone classifica o runner Kubernetes como beta e informa limitações de CLI. Avalie suporte, compatibilidade de plugins e alternativa de runner antes de adotá-lo para cargas críticas. Um manifesto de plataforma separado está em `devops/drone/runner-kubernetes/`; ele nunca deve ser aplicado automaticamente por uma tarefa de aplicação.

## 10. Referências oficiais verificadas em 2026-07-24

- Git: https://git-scm.com/docs
- Drone Kubernetes pipeline: https://docs.drone.io/pipeline/kubernetes/
- Drone Kubernetes runner: https://docs.drone.io/runner/kubernetes/
- Drone promotions: https://docs.drone.io/promote/
- Rancher CLI: https://ranchermanager.docs.rancher.com/reference-guides/cli-with-rancher/rancher-cli
- Rancher kubeconfig: https://ranchermanager.docs.rancher.com/how-to-guides/new-user-guides/manage-clusters/access-clusters/use-kubectl-and-kubeconfig
- kubectl: https://kubernetes.io/docs/reference/kubectl/
