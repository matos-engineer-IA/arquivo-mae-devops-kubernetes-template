# Padrões de desenvolvimento

## 1. Estrutura do código

`{{DESCREVA_AS_PASTAS_E_RESPONSABILIDADES}}`

## 2. Nomenclatura

| Elemento | Convenção | Exemplo |
|---|---|---|
| Arquivos | `{{CONVENCAO}}` | `{{EXEMPLO}}` |
| Funções | `{{CONVENCAO}}` | `{{EXEMPLO}}` |
| Classes | `{{CONVENCAO}}` | `{{EXEMPLO}}` |
| Variáveis de ambiente | `MAIUSCULAS_COM_UNDERLINE` | `DATABASE_URL` |
| Recursos Kubernetes | DNS label, estável e descritivo | `orders-api` |
| Branches | tipo/id/descrição curta | `feature/123-orders-api` |

## 3. Erros e exceções

- Falhe de forma explícita.
- Preserve a causa original do erro.
- Não capture exceções genéricas sem tratamento adequado.
- Não exponha detalhes internos ou segredos ao usuário.
- Erros transitórios devem ter retry limitado, backoff e observabilidade.
- Não transforme falha real em sucesso aparente.

## 4. Logs e telemetria

- Use níveis coerentes e formato estruturado quando possível.
- Inclua identificadores de correlação.
- Não registre senhas, tokens, chaves, cookies, kubeconfigs ou dados pessoais desnecessários.
- Evite payloads completos em produção.
- Registre versão/commit da aplicação como metadado operacional.
- Logs de pipeline devem informar alvo e resultado, nunca o valor de credenciais.

## 5. Dependências

- Justifique novas bibliotecas.
- Verifique licença, manutenção e vulnerabilidades.
- Preserve arquivos de lock.
- Não atualize pacotes fora do escopo.
- Use instalação reproduzível no CI.
- Fixe imagens de ferramentas por versão e, quando possível, digest.

## 6. Git e commits

- Uma intenção principal por commit.
- Mensagens objetivas conforme `{{CONVENCAO_DE_COMMIT}}`.
- Não inclua arquivos gerados, segredos, kubeconfigs ou dumps.
- Faça stage por caminho; evite `git add .` quando houver mudanças não relacionadas.
- Revise `git diff --cached` antes de publicar.
- Não reescreva histórico compartilhado sem processo aprovado.

## 7. Configuração e feature flags

- Configuração varia por ambiente; código não.
- Valores sensíveis ficam em mecanismo de segredos.
- Defaults devem ser seguros e não apontar para produção.
- Feature flags precisam de dono, data de revisão e plano de remoção.
- Uma variável obrigatória ausente deve causar falha clara no startup ou preflight.

## 8. Docker e imagens

- Use build reproduzível e multi-stage quando apropriado.
- Execute como usuário não root, salvo justificativa.
- Minimize ferramentas e pacotes na imagem final.
- Não copie `.git`, `.env`, kubeconfig ou credenciais para o contexto/imagem.
- Defina healthcheck/probes coerentes com a aplicação.
- Publique tag imutável vinculada ao commit e registre digest.
- Não use `latest` como identidade de release.

## 9. Kubernetes

- Manifests são declarativos, versionados e idempotentes.
- Use base/overlays e evite cópia integral por ambiente.
- Defina requests, limits, probes, estratégia de rollout e `securityContext`.
- Todo comando mutável informa contexto e namespace.
- RBAC segue menor privilégio.
- Namespace e recursos cluster-scoped não são criados pelo pipeline da aplicação por padrão.
- Alterações em Secret seguem processo específico e não são exibidas no diff público.

## 10. Pipeline

- CI e CD são fases separadas.
- Pull request não recebe segredo de deploy.
- Build deve falhar cedo e de forma legível.
- O mesmo artefato é promovido entre ambientes.
- Produção é acionada por promoção aprovada, nunca por fallback.
- Desabilitar teste, scanner ou gate exige aprovação e registro de exceção.

## 11. Comentários e documentação

- Explique decisões e restrições, não o óbvio.
- Remova comentários obsoletos.
- Registre decisões estruturais em ADR.
- Atualize o `ARQUIVO_MAE.md` quando mudar uma fonte de verdade, política ou fluxo.
