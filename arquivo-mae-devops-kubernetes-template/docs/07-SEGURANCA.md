# Segurança

## 1. Princípios

- menor privilégio;
- negação por padrão;
- segregação por ambiente;
- segredo fora do Git;
- artefato imutável e rastreável;
- defesa em profundidade;
- auditoria de ações mutáveis;
- produção nunca como alvo implícito.

## 2. Dados e classificação

| Tipo de dado | Classificação | Pode ir ao log? | Pode ir ao ambiente de teste? | Retenção |
|---|---|---|---|---|
| `{{TIPO}}` | `PÚBLICO/INTERNO/CONFIDENCIAL/RESTRITO` | `SIM/NÃO/REDACTED` | `REGRA` | `PRAZO` |

## 3. Segredos

É proibido versionar ou exibir:

- senha, token, API key e cookie;
- chave privada e certificado privado;
- `.env` real;
- kubeconfig;
- conteúdo de Kubernetes `Secret`;
- credencial do Drone, Rancher ou registry;
- dump com dado real.

Controles:

- scanner de segredos local e no CI;
- valores em cofre, Drone Secret ou extensão aprovada;
- rotação e revogação documentadas;
- escopo e expiração mínimos;
- proteção de logs e artefatos;
- segredos indisponíveis para PRs por padrão.

## 4. Git e revisão

- branch principal protegida;
- revisão obrigatória para áreas críticas;
- commits e builds rastreáveis;
- CODEOWNERS quando aplicável;
- exceções com prazo e aprovador;
- proibição de reescrever histórico protegido sem processo de incidente.

## 5. Pipeline e supply chain

- dependências com lockfile;
- SAST, SCA e scan de segredos conforme risco;
- SBOM e scan de imagem quando aplicável;
- imagens de ferramentas fixadas por versão/digest;
- plugins privilegiados bloqueados por padrão;
- assinatura/attestation quando disponível;
- publicação somente em eventos autorizados;
- promoção do mesmo digest entre ambientes.

## 6. Kubernetes

- ServiceAccounts dedicadas;
- RBAC namespace-scoped e mínimo;
- sem `cluster-admin` para runner ou deployer;
- sem leitura de Secrets pelo deployer por padrão;
- Pod Security e políticas de admissão conforme a plataforma;
- `runAsNonRoot`, capabilities reduzidas e seccomp quando compatível;
- NetworkPolicy, quotas e limites conforme risco;
- audit log e eventos disponíveis para investigação.

## 7. Ameaças e controles

| Ameaça | Vetor | Controle preventivo | Detecção | Resposta |
|---|---|---|---|---|
| Exfiltração de segredo em PR | pipeline de fork/PR | segredo indisponível | scan/log review | revogar e investigar |
| Deploy no cluster errado | contexto implícito | contexto/namespace explícitos | cabeçalho e logs | interromper/reverter |
| Imagem trocada após CI | tag mutável | digest/tag imutável | comparação build/release | bloquear promoção |
| Privilégio excessivo | kubeconfig admin | RBAC mínimo | `auth can-i` e revisão | revogar/corrigir |
| Supply chain comprometida | dependência/plugin | pin, scan, assinatura | alertas/SBOM | bloquear e rotacionar |
| `{{AMEACA}}` | `{{VETOR}}` | `{{CONTROLE}}` | `{{DETECCAO}}` | `{{RESPOSTA}}` |

## 8. Incidente de credencial

1. não reproduzir nem compartilhar o valor;
2. interromper pipeline afetado;
3. revogar/rotacionar pelo responsável;
4. preservar evidências sem segredo;
5. identificar commits, logs, builds e acessos afetados;
6. remover a exposição e reescrever histórico apenas com plano aprovado;
7. registrar causa, impacto e ações preventivas.
