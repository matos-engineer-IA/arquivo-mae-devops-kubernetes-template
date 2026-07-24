# Checklist de revisão de código

## Funcional

- [ ] A mudança resolve o requisito e os critérios de aceitação.
- [ ] O diff está limitado ao escopo.
- [ ] Não há refatoração oportunista.
- [ ] Contratos e compatibilidade foram preservados ou migrados conscientemente.
- [ ] Entradas, erros, retries e casos extremos são tratados.

## Qualidade e segurança

- [ ] Não há segredos, kubeconfigs ou dados sensíveis.
- [ ] Logs são seguros, úteis e correlacionáveis.
- [ ] Testes cobrem sucesso, erro e regressão.
- [ ] Dependências e lockfiles mudaram somente quando necessário.
- [ ] Scanner de segredos/vulnerabilidades foi revisado.
- [ ] Imagens e ferramentas não usam referência mutável sem justificativa.

## DevOps

- [ ] Dockerfile/contexto não copia arquivos sensíveis.
- [ ] Pipeline não expõe segredos a pull requests.
- [ ] Build e publicação ocorrem apenas nos eventos esperados.
- [ ] A imagem é identificada por commit e/ou digest.
- [ ] Manifests são declarativos, renderizáveis e sem placeholders ativos.
- [ ] Contexto e namespace são explícitos em comandos mutáveis.
- [ ] RBAC segue menor privilégio.
- [ ] Probes, recursos e `securityContext` são coerentes.
- [ ] Deploy, rollout, smoke test e rollback estão definidos.
- [ ] Produção não pode ser atingida por push ou fallback acidental.

## Documentação

- [ ] `ARQUIVO_MAE.md`, docs e diagramas foram atualizados quando necessário.
- [ ] ADR foi criado/atualizado para decisão estrutural.
- [ ] Riscos, limitações e validações não executadas estão explícitos.
- [ ] Participação de IA foi registrada quando aplicável.
