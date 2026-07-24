# Integrações e acessos

## 1. Inventário

| Sistema | Finalidade | URL/identificador | Autenticação | Variáveis/segredos | Escopo mínimo | Responsável |
|---|---|---|---|---|---|---|
| Provedor Git | código, PR e webhook | `{{URL}}` | SSO/token/SSH | `{{NOMES}}` | repositório necessário | `{{TIME}}` |
| Drone Server | CI/CD | `{{DRONE_SERVER}}` | token/SSO | `DRONE_SERVER`, `DRONE_TOKEN` | leitura ou promoção conforme papel | `{{TIME}}` |
| Registry | imagens | `{{REGISTRY}}` | robot account/token | `{{NOMES}}` | push/pull no repositório da aplicação | `{{TIME}}` |
| Rancher | gestão de cluster | `{{RANCHER_URL}}` | SSO/token | `RANCHER_URL`, `RANCHER_TOKEN` | projeto/cluster necessário | `{{TIME}}` |
| Kubernetes dev | runtime | `{{CLUSTER/CONTEXTO}}` | kubeconfig curto/mínimo | `KUBE_CONFIG_B64` ou mecanismo aprovado | namespace dev | `{{TIME}}` |
| Kubernetes staging | runtime | `{{CLUSTER/CONTEXTO}}` | credencial própria | `{{SEGREDO}}` | namespace staging | `{{TIME}}` |
| Kubernetes prod | runtime | `{{CLUSTER/CONTEXTO}}` | credencial própria | `{{SEGREDO}}` | namespace prod | `{{TIME}}` |
| Observabilidade | logs/métricas/traces | `{{URL}}` | SSO/token | `{{NOMES}}` | leitura do serviço | `{{TIME}}` |
| `{{OUTRO_SERVICO}}` | `{{FINALIDADE}}` | `{{URL}}` | `{{TIPO}}` | `{{NOMES}}` | `{{ESCOPO}}` | `{{TIME}}` |

## 2. Matriz de acesso

| Papel | Git | Drone | Rancher/Kubernetes | Registry | Produção |
|---|---|---|---|---|---|
| Desenvolvedor | branch/PR | leitura e CI | leitura/dev conforme política | leitura | não por padrão |
| Agente de IA | conforme sessão autorizada | leitura; escrita explícita | leitura; escrita explícita e limitada | não diretamente por padrão | bloqueado sem aprovação específica |
| Operação | conforme processo | promoção/diagnóstico | operação autorizada | leitura | conforme escala |
| Plataforma | administração | administração | administração | administração | conforme função |

Preencha esta matriz com os papéis reais. Não conceda privilégios administrativos ao agente para simplificar automação.

## 3. Solicitação e revogação

Para cada acesso, documente:

- requisito e justificativa;
- aprovador;
- escopo e ambiente;
- duração/expiração;
- mecanismo de entrega;
- registro de auditoria;
- procedimento de revogação;
- contato em incidente.

## 4. Credenciais do pipeline

- Use credenciais distintas por ambiente.
- Prefira identidade curta, rotacionável e restrita ao namespace.
- Não use kubeconfig de administrador.
- Não permita segredos de deploy em pull requests.
- Não compartilhe token humano com o pipeline.
- Registre apenas nomes dos segredos; valores permanecem no cofre/Drone/extensão aprovada.
- Teste `kubectl auth can-i` antes da escrita.

## 5. Rancher

Rancher é a camada administrativa. O processo deve registrar servidor, cluster, projeto, contexto, namespace e papel. Para automação do Drone, use kubeconfig mínimo ou integração aprovada; não dependa de uma sessão interativa do Rancher CLI dentro do pipeline.

## 6. Falha de integração

Para cada sistema, registre timeout, retry, limite, fallback, telemetria e responsável. Uma falha de acesso não deve ser contornada com credencial mais privilegiada sem revisão.
