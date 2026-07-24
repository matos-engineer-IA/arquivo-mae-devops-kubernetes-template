# Segurança da cadeia de entrega

## 1. Controles mínimos

- branch protegida e revisão obrigatória;
- dependências bloqueadas por lockfile;
- scanner de segredos antes do push e no CI;
- SAST e análise de dependências;
- geração de SBOM quando aplicável;
- scanner de imagem antes da promoção;
- imagens e actions/plugins fixados por versão ou digest;
- registry privado/aprovado;
- assinatura e verificação de imagem quando disponível;
- credenciais curtas, mínimas e separadas por ambiente;
- RBAC namespace-scoped;
- logs de auditoria do Git, Drone, Rancher e Kubernetes.

## 2. Política de vulnerabilidades

| Severidade | Pull request | Deploy dev | Produção | Exceção |
|---|---|---|---|---|
| Crítica | bloquear | bloquear | bloquear | aprovação de segurança |
| Alta | `{{REGRA}}` | `{{REGRA}}` | bloquear por padrão | prazo e mitigação |
| Média | `{{REGRA}}` | permitir com registro | `{{REGRA}}` | backlog |
| Baixa | informar | permitir | permitir | backlog |

## 3. Segredos

- Não versionar `.env`, kubeconfig, token ou Secret em texto claro.
- Não imprimir variáveis completas no pipeline.
- Não habilitar segredos de deploy para pull requests.
- Preferir extensão de segredos, Vault ou mecanismo aprovado.
- Rotacionar após exposição real ou suspeita.
- Manter inventário de proprietário, uso, escopo e expiração.

## 4. Imagens

- usar base mínima e suportada;
- não executar como root sem justificativa;
- remover ferramentas de build da imagem final;
- usar multi-stage quando apropriado;
- definir usuário, filesystem e capabilities;
- publicar tag imutável;
- registrar digest e SBOM;
- não reutilizar credencial do registry como credencial do cluster.

## 5. Drone e Kubernetes

- Runner e plugins devem ter versões aprovadas.
- Evitar modo privilegiado; toda exceção precisa de revisão.
- ServiceAccount do runner não deve ser `cluster-admin`.
- Deployer não deve ler Secrets por padrão.
- Pipeline não deve criar Namespace, ClusterRole ou CRD.
- Produção deve usar promoção e credencial própria.

## 6. Checklist de release

- [ ] segredo scan sem achado não tratado;
- [ ] vulnerabilidades dentro da política;
- [ ] imagem e base identificadas;
- [ ] SBOM armazenada;
- [ ] digest registrado;
- [ ] RBAC revisado;
- [ ] logs não expõem dados;
- [ ] exceções aprovadas e com prazo.
