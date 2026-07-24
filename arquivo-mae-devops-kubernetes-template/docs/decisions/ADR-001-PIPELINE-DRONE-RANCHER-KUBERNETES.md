# ADR-001 — Pipeline com Drone, Rancher e Kubernetes

- Status: `PROPOSTA`
- Data: `AAAA-MM-DD`
- Decisores: `{{PAPEIS_OU_NOMES}}`
- Revisão prevista: `AAAA-MM-DD`

## Contexto

O projeto precisa de um processo de desenvolvimento e entrega rastreável, repetível e compatível com clusters Kubernetes administrados pelo Rancher. Agentes como Claude Code e Codex devem seguir o mesmo fluxo, sem escolher ferramentas, ambientes ou privilégios por suposição.

## Decisão proposta

Adotar o seguinte desenho:

1. Git e pull request como fonte da mudança e revisão;
2. Drone self-hosted como orquestrador de CI/CD;
3. runner Kubernetes do Drone para executar pipelines em Pods efêmeros, após avaliação de suporte;
4. imagem construída uma vez, publicada com identidade imutável e promovida entre ambientes;
5. Rancher para administração de cluster e distribuição controlada de acesso;
6. `kubectl` e Kustomize para render, dry-run, diff, apply e rollout;
7. RBAC mínimo e credencial separada por ambiente;
8. promoção explícita para deploy;
9. produção com aprovação humana, mudança e rollback.

## Alternativas consideradas

| Alternativa | Vantagem | Desvantagem/risco | Decisão |
|---|---|---|---|
| Drone com runner Kubernetes | integração direta ao ambiente Kubernetes | runner classificado como beta/comunitário | avaliar |
| Drone com runner Docker/Exec | maturidade ou compatibilidade diferente | pode exigir infraestrutura fora do cluster | avaliar como contingência |
| GitOps com Argo CD ou Flux | reconciliação e separação entre CI e CD | adiciona plataforma e modelo operacional | avaliar para evolução |
| Deploy manual pelo Rancher | simples no início | menor reprodutibilidade e automação | não preferencial |

## Consequências

### Positivas

- fluxo único e documentado;
- melhor rastreabilidade entre commit, build, imagem e release;
- deploy declarativo e reproduzível;
- controles explícitos para agentes de IA;
- rollback e observabilidade incorporados ao processo.

### Negativas e riscos

- dependência de Drone self-hosted e do runner escolhido;
- manutenção de RBAC, kubeconfigs e políticas;
- necessidade de validar plugins e imagens no pipeline Kubernetes;
- risco operacional se promoções ou credenciais forem excessivas;
- gates por variável não substituem autorização real.

## Critérios para aceitar esta ADR

- [ ] matriz de versões validada;
- [ ] runner testado em ambiente não produtivo;
- [ ] alternativa de contingência definida;
- [ ] RBAC revisado por segurança/plataforma;
- [ ] segredos fora do Git e indisponíveis para PRs;
- [ ] build once/promote many comprovado;
- [ ] rollback e observabilidade testados;
- [ ] responsáveis e aprovações definidos.

## Evidências

- `docs/14-DEVOPS_E_CICD.md`
- `docs/16-OPERACAO_DO_PIPELINE.md`
- `docs/19-PLAYBOOK_CLAUDE_CODE_DEVOPS.md`
- `.drone.yml.example`
- `devops/`

## Observação

Enquanto o status for `PROPOSTA`, o template não deve ser interpretado como decisão arquitetural aprovada para um projeto específico.
