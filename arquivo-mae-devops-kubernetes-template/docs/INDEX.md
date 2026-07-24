# Índice da documentação

`ARQUIVO_MAE.md` é a documentação central e define precedência. Os arquivos abaixo são fontes especializadas.

| Ordem | Documento | Consulte quando |
|---:|---|---|
| 0 | `00-CONTEXTO_DO_PROJETO.md` | contexto e glossário mudarem |
| 1 | `01-ESCOPO_E_REQUISITOS.md` | escopo ou requisito for discutido |
| 2 | `02-ARQUITETURA.md` | componentes e fluxos forem alterados |
| 3 | `03-REGRAS_DE_NEGOCIO.md` | comportamento funcional mudar |
| 4 | `04-PADROES_DE_DESENVOLVIMENTO.md` | código for criado ou revisado |
| 5 | `05-CONTRATOS_E_DADOS.md` | APIs, eventos, arquivos ou bancos forem usados |
| 6 | `06-INTEGRACOES_E_ACESSOS.md` | ferramentas externas e acessos forem necessários |
| 7 | `07-SEGURANCA.md` | dados, identidade e ameaças forem avaliados |
| 8 | `08-TESTES_E_QUALIDADE.md` | estratégia de validação for definida |
| 9 | `09-DEPLOY_E_AMBIENTES.md` | ambientes e entrega forem preparados |
| 10 | `10-RUNBOOK.md` | o sistema precisar ser operado |
| 11 | `11-ROADMAP.md` | prioridades futuras forem planejadas |
| 12 | `12-PENDENCIAS_E_RISCOS.md` | lacunas e riscos surgirem |
| 13 | `13-PROTOCOLO_DE_IA.md` | sempre, antes de usar agentes de IA |
| 14 | `14-DEVOPS_E_CICD.md` | fluxo Git/Drone/Kubernetes for definido |
| 15 | `15-COMANDOS_GIT_DRONE_RANCHER_KUBECTL.md` | comandos operacionais forem executados |
| 16 | `16-OPERACAO_DO_PIPELINE.md` | pipeline, promoção, deploy ou rollback ocorrer |
| 17 | `17-SRE_E_OBSERVABILIDADE.md` | SLOs, sinais e incidentes forem definidos |
| 18 | `18-SEGURANCA_DA_CADEIA_DE_ENTREGA.md` | supply chain, imagem ou segredos forem avaliados |
| 19 | `19-PLAYBOOK_CLAUDE_CODE_DEVOPS.md` | um agente executar o fluxo DevOps por fases |

## Regras

- Cada assunto deve ter uma fonte oficial.
- Evite duplicar a mesma regra em vários documentos.
- Quando uma regra mudar, atualize a fonte oficial e os links relacionados.
- Decisões estruturais devem virar ADR.
- Exemplos devem ser identificados como exemplos até se tornarem contratos reais.
- Comandos de versões instaladas prevalecem sobre exemplos, desde que não contrariem políticas.
- O alvo de infraestrutura deve ser explícito e confirmado antes de escrita.
