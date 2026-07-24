# ARQUIVO MÃE DO PROJETO

> **Sim: este arquivo é a documentação central do projeto.** Ele funciona como constituição, índice e contrato operacional.  
> Ele não substitui a documentação especializada; define onde cada verdade oficial está registrada e como pessoas, Claude Code, Codex e pipelines devem trabalhar.

---

## 1. Controle do documento

| Campo | Valor |
|---|---|
| Projeto | `{{NOME_DO_PROJETO}}` |
| Identificador/repositório | `{{IDENTIFICADOR_OU_URL_DO_REPOSITORIO}}` |
| Responsável de negócio | `{{NOME_OU_TIME}}` |
| Responsável técnico | `{{NOME_OU_TIME}}` |
| Status | `IDEIA / DESCOBERTA / DESENVOLVIMENTO / HOMOLOGAÇÃO / PRODUÇÃO / ENCERRADO` |
| Criticidade | `BAIXA / MÉDIA / ALTA / CRÍTICA` |
| Versão deste documento | `0.3.0` |
| Última revisão | `AAAA-MM-DD` |
| Próxima revisão | `AAAA-MM-DD` |
| Aprovadores | `{{NOMES_OU_PAPÉIS}}` |

### Histórico de revisões

| Data | Versão | Autor | Alteração | Aprovador |
|---|---:|---|---|---|
| `AAAA-MM-DD` | `0.1.0` | `{{AUTOR}}` | Criação da base | `{{APROVADOR}}` |
| `AAAA-MM-DD` | `0.2.0` | `{{AUTOR}}` | Inclusão da base DevOps, Drone, Rancher e Kubernetes | `{{APROVADOR}}` |
| `AAAA-MM-DD` | `0.3.0` | `{{AUTOR}}` | Reforço de identidade do cluster, namespace, RBAC e gates de deploy | `{{APROVADOR}}` |

---

## 2. Como usar este documento

Antes de implementar, revisar ou sugerir qualquer mudança:

1. Leia este arquivo integralmente.
2. Consulte os documentos especializados indicados na seção **Mapa da documentação**.
3. Confirme se a tarefa está dentro do escopo.
4. Diferencie fatos comprovados, hipóteses e informações desconhecidas.
5. Apresente um plano curto antes de alterar código.
6. Faça a menor mudança capaz de atender ao objetivo.
7. Valide o resultado com os comandos oficiais do projeto.
8. Registre a alteração e as limitações da validação.

### Ordem de precedência das fontes

Quando duas fontes entrarem em conflito, siga esta ordem:

1. Requisito ou decisão aprovada e registrada.
2. Este `ARQUIVO_MAE.md`.
3. ADRs aceitos em `docs/decisions/`.
4. Contratos versionados e testes automatizados.
5. Documentação especializada em `docs/`.
6. Código em produção.
7. Comentários de código.
8. Suposições, mensagens antigas e conhecimento informal.

> Um conflito entre fontes deve ser registrado e resolvido. Não escolha silenciosamente a interpretação mais conveniente.

---

## 3. Resumo executivo

### Problema

`{{DESCREVA_EM_3_A_6_LINHAS_O_PROBLEMA_REAL}}`

### Solução proposta

`{{DESCREVA_EM_3_A_6_LINHAS_A_SOLUCAO_E_O_VALOR_ENTREGUE}}`

### Usuários e beneficiários

| Perfil | Necessidade | Valor esperado |
|---|---|---|
| `{{PERFIL_1}}` | `{{NECESSIDADE}}` | `{{VALOR}}` |
| `{{PERFIL_2}}` | `{{NECESSIDADE}}` | `{{VALOR}}` |

### Métricas de sucesso

| Métrica | Linha de base | Meta | Fonte de medição |
|---|---:|---:|---|
| `{{METRICA}}` | `{{VALOR_ATUAL}}` | `{{META}}` | `{{FONTE}}` |

---

## 4. Escopo

### Dentro do escopo

- `{{ENTREGA_OU_CAPACIDADE_1}}`
- `{{ENTREGA_OU_CAPACIDADE_2}}`
- `{{ENTREGA_OU_CAPACIDADE_3}}`

### Fora do escopo atual

- `{{ITEM_FORA_DO_ESCOPO_1}}`
- `{{ITEM_FORA_DO_ESCOPO_2}}`
- Alterações não relacionadas à tarefa em execução.
- Refatorações amplas sem aprovação.
- Inclusão de dependências sem justificativa e análise de impacto.
- Operações destrutivas em dados ou infraestrutura sem autorização explícita.

### Não objetivos

`{{REGISTRE_AQUI_O_QUE_PODE_PARECER_RELACIONADO_MAS_NAO_E_OBJETIVO_DO_PROJETO}}`

---

## 5. Estado atual do projeto

| Área | Estado | Evidência | Próxima ação |
|---|---|---|---|
| Descoberta | `NÃO INICIADO / EM ANDAMENTO / CONCLUÍDO` | `{{LINK_OU_ARQUIVO}}` | `{{AÇÃO}}` |
| Protótipo | `NÃO INICIADO / EM ANDAMENTO / CONCLUÍDO` | `{{LINK_OU_ARQUIVO}}` | `{{AÇÃO}}` |
| Front-end | `NÃO INICIADO / EM ANDAMENTO / CONCLUÍDO` | `{{LINK_OU_ARQUIVO}}` | `{{AÇÃO}}` |
| Back-end | `NÃO INICIADO / EM ANDAMENTO / CONCLUÍDO` | `{{LINK_OU_ARQUIVO}}` | `{{AÇÃO}}` |
| Dados | `NÃO INICIADO / EM ANDAMENTO / CONCLUÍDO` | `{{LINK_OU_ARQUIVO}}` | `{{AÇÃO}}` |
| Integrações | `NÃO INICIADO / EM ANDAMENTO / CONCLUÍDO` | `{{LINK_OU_ARQUIVO}}` | `{{AÇÃO}}` |
| Testes | `NÃO INICIADO / EM ANDAMENTO / CONCLUÍDO` | `{{LINK_OU_ARQUIVO}}` | `{{AÇÃO}}` |
| Deploy | `NÃO INICIADO / EM ANDAMENTO / CONCLUÍDO` | `{{LINK_OU_ARQUIVO}}` | `{{AÇÃO}}` |
| CI/CD | `NÃO INICIADO / EM ANDAMENTO / CONCLUÍDO` | `.drone.yml` / `{{LINK}}` | `{{AÇÃO}}` |
| Kubernetes | `NÃO INICIADO / EM ANDAMENTO / CONCLUÍDO` | `devops/kubernetes/` / `{{LINK}}` | `{{AÇÃO}}` |

### Limitações conhecidas

- `{{LIMITACAO_1}}`
- `{{LIMITACAO_2}}`

### Funcionalidades simuladas ou desabilitadas

- `{{FUNCAO}}`: `{{MOTIVO_E_CONDICAO_PARA_HABILITAR}}`

---

## 6. Pessoas, papéis e decisões

| Papel | Responsável | Pode aprovar | Canal |
|---|---|---|---|
| Product owner | `{{NOME_OU_TIME}}` | Escopo e prioridade | `{{CANAL}}` |
| Tech lead | `{{NOME_OU_TIME}}` | Arquitetura e padrões | `{{CANAL}}` |
| Segurança | `{{NOME_OU_TIME}}` | Acessos e controles | `{{CANAL}}` |
| Operação | `{{NOME_OU_TIME}}` | Deploy e incidentes | `{{CANAL}}` |

### Decisões que exigem aprovação humana

- Mudança de arquitetura ou tecnologia principal.
- Inclusão ou remoção de dependência de produção.
- Mudança incompatível em API, evento, banco ou contrato público.
- Migração ou exclusão de dados.
- Alteração de autenticação, autorização ou criptografia.
- Mudança de infraestrutura, pipeline ou ambiente de produção.
- Operação destrutiva ou de difícil reversão.
- Ampliação de escopo.
- Desativação de testes, validações ou controles de segurança.

---

## 7. Arquitetura resumida

### Visão geral

`{{DESCREVA_OS_COMPONENTES_E_COMO_SE_RELACIONAM_EM_5_A_10_LINHAS}}`

### Componentes

| Componente | Responsabilidade | Tecnologia | Dono | Criticidade |
|---|---|---|---|---|
| `{{COMPONENTE}}` | `{{RESPONSABILIDADE}}` | `{{TECNOLOGIA}}` | `{{TIME}}` | `{{NÍVEL}}` |

### Fluxo principal

1. `{{ENTRADA}}`
2. `{{VALIDACAO}}`
3. `{{PROCESSAMENTO}}`
4. `{{PERSISTENCIA_OU_INTEGRACAO}}`
5. `{{SAIDA}}`
6. `{{AUDITORIA_E_MONITORAMENTO}}`

Diagramas oficiais:

- `diagrams/arquitetura.mmd`
- `diagrams/fluxo-principal.mmd`
- `diagrams/sequencia-principal.mmd`

Detalhes: `docs/02-ARQUITETURA.md`.

---

## 8. Tecnologias e versões

| Categoria | Tecnologia | Versão suportada | Fonte da versão | Observação |
|---|---|---:|---|---|
| Linguagem | `{{TECNOLOGIA}}` | `{{VERSAO}}` | `{{ARQUIVO_LOCK_OU_RUNTIME}}` | `{{OBS}}` |
| Framework | `{{TECNOLOGIA}}` | `{{VERSAO}}` | `{{ARQUIVO}}` | `{{OBS}}` |
| Banco | `{{TECNOLOGIA}}` | `{{VERSAO}}` | `{{CONFIGURACAO}}` | `{{OBS}}` |
| Infraestrutura | `{{TECNOLOGIA}}` | `{{VERSAO}}` | `{{CONFIGURACAO}}` | `{{OBS}}` |

### Política de dependências

- Use apenas dependências necessárias e compatíveis com as versões suportadas.
- Não atualize pacotes por conveniência durante uma tarefa não relacionada.
- Não altere arquivos de lock sem que uma dependência tenha sido adicionada, removida ou atualizada intencionalmente.
- Toda nova dependência precisa de justificativa, licença compatível, avaliação de manutenção e impacto no build.
- Prefira recursos já existentes no projeto e bibliotecas padrão.

---

## 9. Ambientes e configuração

| Ambiente | Finalidade | Dados permitidos | Deploy | Acesso |
|---|---|---|---|---|
| Local | Desenvolvimento | Sintéticos ou anonimizados | Manual | Desenvolvedor |
| Teste | Integração automatizada | Sintéticos | Pipeline | Time técnico |
| Homologação | Validação de negócio | Conforme política | Pipeline | Aprovados |
| Produção | Operação real | Reais | Controlado | Restrito |

### Comandos oficiais

| Ação | Comando | Observação |
|---|---|---|
| Instalar | `{{COMANDO}}` | `{{OBS}}` |
| Executar localmente | `{{COMANDO}}` | `{{OBS}}` |
| Testar | `{{COMANDO}}` | `{{OBS}}` |
| Lint | `{{COMANDO}}` | `{{OBS}}` |
| Formatar | `{{COMANDO}}` | `{{OBS}}` |
| Verificar tipos | `{{COMANDO}}` | `{{OBS}}` |
| Build | `{{COMANDO}}` | `{{OBS}}` |

> Não invente comandos. Quando não houver comando oficial, registre como `PENDENTE`.

### Identidade operacional DevOps

Preencha esta tabela antes de permitir que um agente execute comandos remotos ou de cluster.

| Item | Desenvolvimento | Homologação | Produção |
|---|---|---|---|
| Repositório | `{{OWNER/REPO}}` | mesmo artefato | mesmo artefato |
| Branch protegida | `{{BRANCH_DEV}}` | `{{BRANCH_STAGING_OU_PROMOCAO}}` | `{{BRANCH_PRINCIPAL}}` |
| Drone Server | `{{DRONE_SERVER_URL}}` | `{{DRONE_SERVER_URL}}` | `{{DRONE_SERVER_URL}}` |
| Pipeline Drone | `ci` / `deploy-development` | `deploy-staging` | `deploy-production` |
| Rancher Server | `{{RANCHER_URL}}` | `{{RANCHER_URL}}` | `{{RANCHER_URL}}` |
| Cluster | `{{CLUSTER_DEV}}` | `{{CLUSTER_STAGING}}` | `{{CLUSTER_PROD}}` |
| Contexto kubectl | `{{KUBE_CONTEXT_DEV}}` | `{{KUBE_CONTEXT_STAGING}}` | `{{KUBE_CONTEXT_PROD}}` |
| API Server esperado | `{{KUBE_SERVER_DEV}}` | `{{KUBE_SERVER_STAGING}}` | `{{KUBE_SERVER_PROD}}` |
| Namespace | `{{NAMESPACE_DEV}}` | `{{NAMESPACE_STAGING}}` | `{{NAMESPACE_PROD}}` |
| Registry/repositório | `{{REGISTRY/IMAGEM}}` | mesmo repositório | mesmo repositório |
| Credencial de deploy | `{{SEGREDO_DRONE_DEV}}` | `{{SEGREDO_DRONE_STAGING}}` | `{{SEGREDO_DRONE_PROD}}` |
| Aprovação | automática ou manual conforme risco | manual | manual + mudança aprovada |

Regras obrigatórias:

- O artefato deve ser construído uma vez e promovido pelo mesmo digest ou tag imutável.
- Não usar `latest` como identidade de release.
- Todo comando mutável do `kubectl` deve informar `--context` e `--namespace` explicitamente.
- O nome do contexto, o endereço do API Server e o namespace devem coincidir com a identidade aprovada do ambiente.
- O pipeline não cria clusters nem namespaces por padrão.
- Produção nunca é alvo implícito, padrão ou fallback.
- Rancher administra o cluster e fornece acesso; Drone orquestra; `kubectl` aplica e verifica os recursos.
- Segredos ficam no gerenciador aprovado, no Drone ou em uma extensão de segredos; nunca no Git.

### Fluxo padrão de entrega

1. Criar branch curta a partir da referência aprovada.
2. Executar validações locais e revisar `git diff`.
3. Abrir pull request e executar CI no Drone.
4. Construir imagem com tag imutável baseada no commit.
5. Publicar a imagem no registry aprovado.
6. Promover o build para o ambiente alvo.
7. Renderizar e validar os manifests.
8. Executar `dry-run` no servidor e `kubectl diff`.
9. Aplicar no namespace explícito.
10. Aguardar `rollout status` e executar smoke tests.
11. Registrar evidências, versão e procedimento de rollback.

Detalhes: `docs/14-DEVOPS_E_CICD.md`, `docs/15-COMANDOS_GIT_DRONE_RANCHER_KUBECTL.md` e `docs/16-OPERACAO_DO_PIPELINE.md`.

---

## 10. Regras de negócio essenciais

| ID | Regra | Origem | Teste/Evidência |
|---|---|---|---|
| RN-001 | `{{REGRA_CLARA_E_TESTAVEL}}` | `{{FONTE}}` | `{{TESTE_OU_CENARIO}}` |
| RN-002 | `{{REGRA_CLARA_E_TESTAVEL}}` | `{{FONTE}}` | `{{TESTE_OU_CENARIO}}` |

Regras completas: `docs/03-REGRAS_DE_NEGOCIO.md`.

---

## 11. Dados e contratos

### Entidades principais

| Entidade | Finalidade | Fonte de verdade | Contém dado sensível? |
|---|---|---|---|
| `{{ENTIDADE}}` | `{{FINALIDADE}}` | `{{BANCO_API_ARQUIVO}}` | `SIM / NÃO` |

### Contratos oficiais

| Contrato | Local | Versão | Compatibilidade |
|---|---|---:|---|
| `{{API_EVENTO_SCHEMA}}` | `{{CAMINHO}}` | `{{VERSAO}}` | `{{REGRA}}` |

Regras:

- Não invente campos, estados, códigos ou endpoints.
- Exemplos não substituem schemas, testes ou documentação oficial.
- Alterações incompatíveis exigem plano de migração e aprovação.
- Dados de teste devem ser sintéticos ou anonimizados.
- Toda migração precisa de estratégia de ida, validação e reversão.

Detalhes: `docs/05-CONTRATOS_E_DADOS.md`.

---

## 12. Integrações, ferramentas e acessos

| Ferramenta/serviço | Finalidade | Autenticação | Variáveis | Segredo armazenado em | Responsável |
|---|---|---|---|---|---|
| `{{SERVICO}}` | `{{FINALIDADE}}` | `{{TIPO}}` | `{{VAR_1}}, {{VAR_2}}` | `{{COFRE_OU_GERENCIADOR}}` | `{{TIME}}` |

### Política de credenciais

É proibido inserir neste repositório:

- senhas reais;
- tokens;
- chaves de API;
- chaves privadas;
- certificados privados;
- cookies de sessão;
- strings reais de conexão;
- dumps com dados sensíveis;
- segredos em exemplos, testes, logs ou capturas de tela.

Documente somente os nomes das variáveis e o processo de acesso. Use `.env.example` com valores fictícios. O arquivo `.env` real deve permanecer ignorado pelo Git.

Detalhes: `docs/06-INTEGRACOES_E_ACESSOS.md` e `docs/07-SEGURANCA.md`.

---

## 13. Padrões de desenvolvimento

### Princípios

- Clareza antes de esperteza.
- Mudanças pequenas, coesas e reversíveis.
- Uma responsabilidade por módulo.
- Reuso antes de duplicação.
- Erros explícitos e observáveis.
- Configuração fora do código.
- Contratos validados nas fronteiras.
- Compatibilidade preservada por padrão.
- Segurança e privacidade desde o desenho.

### Regras mínimas

- Siga a estrutura e as convenções já existentes no projeto.
- Não renomeie arquivos, funções ou campos fora do escopo.
- Não reescreva arquivos inteiros quando uma edição localizada for suficiente.
- Não remova código aparentemente sem uso sem confirmar referências diretas, indiretas, reflexão, configuração e execução dinâmica.
- Não silencie erros com blocos genéricos ou retornos vazios.
- Não deixe logs com segredos, dados pessoais ou payloads completos sem necessidade.
- Não introduza valores fixos que deveriam ser configuração.
- Atualize testes e documentação quando um comportamento for alterado.

Detalhes: `docs/04-PADROES_DE_DESENVOLVIMENTO.md`.

---

## 14. Protocolo obrigatório para agentes de IA

As regras abaixo aplicam-se a Claude Code, Codex e outros agentes.

### 14.1 Antes de editar

O agente deve:

1. Ler `ARQUIVO_MAE.md`, `docs/13-PROTOCOLO_DE_IA.md` e os documentos relacionados à tarefa.
2. Inspecionar os arquivos envolvidos e suas dependências próximas.
3. Procurar implementações equivalentes antes de criar uma nova.
4. Identificar fatos, hipóteses e lacunas.
5. Declarar o objetivo em uma frase.
6. Apresentar um plano curto.
7. Listar os arquivos que pretende alterar.
8. Informar riscos, testes e critérios de conclusão.
9. Interromper o plano e pedir decisão quando a mudança exigir aprovação humana.

### 14.2 Durante a edição

O agente deve:

- limitar-se ao escopo solicitado;
- preferir alterações mínimas e localizadas;
- preservar contratos e comportamento não relacionado;
- evitar refatoração oportunista;
- não instalar dependências sem aprovação;
- não executar comandos destrutivos;
- não alterar configurações de produção;
- não usar nem exibir credenciais;
- não ignorar testes com falha;
- não criar fatos ausentes;
- manter compatibilidade com os padrões existentes;
- atualizar documentação e testes afetados.

### 14.3 Depois da edição

O agente deve:

1. Revisar o diff completo.
2. Executar as validações oficiais relacionadas.
3. Verificar build, lint, tipos e testes aplicáveis.
4. Informar exatamente quais arquivos foram modificados.
5. Explicar o comportamento anterior e o novo.
6. Registrar o que não pôde ser validado.
7. Apontar riscos remanescentes.
8. Descrever uma forma segura de reversão.
9. Atualizar `docs/CHANGELOG_IA.md`.

### 14.4 Regras contra alucinação

- Não invente endpoints, schemas, variáveis, tabelas, nomes de serviços ou comandos.
- Não trate um exemplo como contrato oficial.
- Não assuma que uma dependência está instalada.
- Não assuma que um recurso está sem uso apenas por não encontrar uma chamada direta.
- Não preencha informação ausente com o valor “mais provável”.
- Não apresente hipótese como fato.
- Não afirme que um teste passou sem executá-lo.
- Não afirme que um problema foi resolvido sem evidência.
- Quando houver dúvida, use os rótulos `FATO`, `HIPÓTESE` e `DESCONHECIDO`.
- Quando fontes conflitarem, registre o conflito e solicite decisão.

### 14.5 Formato esperado do relatório final

```text
Objetivo:
Resumo da mudança:
Arquivos alterados:
Validações executadas:
Resultados:
Riscos ou limitações:
Documentação atualizada:
Como reverter:
Pendências:
```

Detalhes completos: `docs/13-PROTOCOLO_DE_IA.md`.

### 14.6 Protocolo DevOps para Claude Code e Codex

O procedimento linear e os estados do playbook estão em `docs/19-PLAYBOOK_CLAUDE_CODE_DEVOPS.md`. O agente executa uma fase por vez e não avança após falha ou bloqueio.

Antes de qualquer pipeline ou deploy, o agente deve produzir e confirmar o seguinte cabeçalho operacional:

```text
Repositório e branch:
Commit SHA:
Evento Drone:
Build Drone:
Ambiente alvo:
Rancher Server:
Cluster/contexto:
API Server esperado:
Namespace:
Imagem e tag/digest:
Manifest/overlay:
Comandos somente leitura executados:
Comandos mutáveis pretendidos:
Aprovação encontrada:
Plano de validação:
Plano de rollback:
```

O agente pode inspecionar Git, builds, logs e recursos do cluster sem mutação quando tiver acesso. Para `commit`, `push`, promoção no Drone ou qualquer escrita no Kubernetes, deve existir autorização explícita compatível com a matriz deste documento.

Antes de `kubectl apply`, o agente deve executar, nessa ordem:

1. confirmar contexto, API Server e namespace;
2. executar `kubectl auth can-i` para as ações necessárias;
3. renderizar o manifest;
4. procurar placeholders e segredos;
5. executar validação local;
6. executar `--dry-run=server`;
7. executar `kubectl diff` e tratar os códigos de saída corretamente;
8. listar os recursos que serão criados ou alterados;
9. somente então aplicar, se autorizado.

O agente nunca deve:

- usar contexto ou namespace implícito para comandos mutáveis;
- aceitar um API Server diferente do registrado para o ambiente;
- trocar contexto para produção silenciosamente;
- executar `kubectl delete`, `drain`, `cordon`, `edit`, `patch`, `scale` ou `exec` por conveniência;
- criar ou alterar segredo para “fazer o pipeline funcionar” sem aprovação;
- imprimir `DRONE_TOKEN`, token Rancher, kubeconfig ou conteúdo de `Secret`;
- promover uma imagem diferente da validada no build original;
- ocultar falha de rollout ou afirmar sucesso antes dos checks.

---

## 15. Matriz de permissão para mudanças

| Tipo de mudança | Regra |
|---|---|
| Correção pequena e localizada | Permitida após análise e validação |
| Refatoração local | Permitida se preservar contratos e permanecer no escopo |
| Nova dependência | Exige aprovação |
| Atualização de dependência | Exige justificativa e testes de regressão |
| Alteração de banco | Exige plano de migração, backup e reversão |
| Mudança de contrato | Exige análise de consumidores e aprovação |
| Mudança de arquitetura | Exige ADR e aprovação |
| Remoção de funcionalidade | Exige aprovação explícita |
| Mudança de autenticação/autorização | Exige revisão de segurança |
| Alteração em produção | Exige procedimento operacional aprovado |
| Operação destrutiva | Proibida sem autorização explícita |
| Exposição de segredo ou dado pessoal | Proibida |

---

## 16. Política de comandos

### Geralmente seguros

Somente quando compatíveis com o projeto:

- leitura de arquivos;
- busca textual;
- inspeção de status e diff do Git;
- execução de testes;
- lint;
- verificação de tipos;
- build local;
- ferramentas em modo de simulação ou `dry-run`.

### Sensíveis, exigem análise e autorização

- instalação ou atualização de dependências;
- geração ou aplicação de migrações;
- comandos que escrevem em serviços externos;
- criação de recursos de infraestrutura;
- alteração de pipeline;
- rebase, merge ou push;
- execução contra homologação ou produção;
- `git commit`, `git push`, merge, rebase e criação de tag;
- `drone build promote`, restart, stop, approve e alterações de segredos;
- `rancher login`, troca de contexto e operações mutáveis;
- `kubectl apply`, set image, restart, undo, patch, scale ou delete.

### Proibidos sem autorização explícita

- exclusão em massa;
- `force push`;
- reset destrutivo;
- remoção de banco, schema, bucket ou recurso;
- limpeza de volumes;
- rotação ou revogação de credenciais;
- acesso ou cópia de segredos;
- desativação de controles de segurança;
- execução de código não revisado em produção;
- uso de `git reset --hard`, `git clean -fdx` ou `git push --force`;
- uso de kubeconfig de administrador no pipeline;
- concessão de `cluster-admin` para simplificar deploy;
- leitura ou exibição de valores de `Secret` do Kubernetes.

---

## 17. Testes e qualidade

### Estratégia

`{{RESUMA_A_ESTRATEGIA_DE_TESTES}}`

### Critérios mínimos

- Testes da funcionalidade alterada.
- Testes de regressão dos fluxos afetados.
- Validação de casos de erro.
- Build reproduzível.
- Lint e tipos sem novos erros.
- Sem segredos ou dados sensíveis no diff.
- Documentação coerente com o comportamento.

Detalhes: `docs/08-TESTES_E_QUALIDADE.md`.

---

## 18. Definição de pronto

Uma tarefa só está concluída quando:

- [ ] O requisito e os critérios de aceitação foram atendidos.
- [ ] A mudança permaneceu no escopo.
- [ ] O diff foi revisado.
- [ ] Os testes aplicáveis foram executados.
- [ ] Build, lint e tipos foram validados quando existirem.
- [ ] Erros e casos extremos relevantes foram tratados.
- [ ] Não existem segredos ou dados sensíveis expostos.
- [ ] Contratos e compatibilidade foram preservados ou migrados conscientemente.
- [ ] A documentação afetada foi atualizada.
- [ ] O procedimento de reversão é conhecido.
- [ ] Limitações e pendências foram registradas.
- [ ] O `CHANGELOG_IA.md` foi atualizado quando houve participação de IA.

Checklist detalhado: `checklists/DEFINICAO_DE_PRONTO.md`.

---

## 19. Deploy, operação e reversão

### Estratégia de deploy

Estratégia padrão deste template: **CI acionada por Git, promoção explícita no Drone e deploy declarativo com `kubectl` em cluster Kubernetes administrado pelo Rancher**.

Personalização obrigatória:

`{{DESCREVA_PIPELINE_APROVACAO_E_PROMOCAO_ENTRE_AMBIENTES}}`

Princípios:

- separar CI de CD;
- construir uma vez e promover o mesmo artefato;
- usar tag imutável baseada no commit e, quando possível, digest;
- validar manifests antes de aplicar;
- usar RBAC mínimo e credenciais distintas por ambiente;
- serializar deploys por ambiente;
- aguardar rollout e verificar saúde;
- bloquear produção sem aprovação e referência de mudança;
- manter rollback documentado e testado.

### Sinais de saúde

| Sinal | Fonte | Faixa saudável | Ação em caso de falha |
|---|---|---|---|
| `{{METRICA_OU_CHECK}}` | `{{FONTE}}` | `{{LIMITE}}` | `{{AÇÃO}}` |

### Reversão

`{{DESCREVA_COMO_REVER_CODIGO_CONFIGURACAO_MIGRACAO_E_DADOS}}`

Detalhes:

- `docs/09-DEPLOY_E_AMBIENTES.md`
- `docs/10-RUNBOOK.md`
- `checklists/RELEASE.md`

---

## 20. Riscos e pendências prioritárias

| ID | Tipo | Descrição | Probabilidade | Impacto | Responsável | Próxima ação |
|---|---|---|---|---|---|---|
| R-001 | Risco | `{{DESCRICAO}}` | `BAIXA/MÉDIA/ALTA` | `BAIXO/MÉDIO/ALTO` | `{{NOME}}` | `{{AÇÃO}}` |
| P-001 | Pendência | `{{DESCRICAO}}` | — | `{{IMPACTO}}` | `{{NOME}}` | `{{AÇÃO}}` |

Detalhes: `docs/12-PENDENCIAS_E_RISCOS.md`.

---

## 21. Mapa da documentação

| Tema | Fonte oficial |
|---|---|
| Contexto e glossário | `docs/00-CONTEXTO_DO_PROJETO.md` |
| Escopo e requisitos | `docs/01-ESCOPO_E_REQUISITOS.md` |
| Arquitetura | `docs/02-ARQUITETURA.md` |
| Regras de negócio | `docs/03-REGRAS_DE_NEGOCIO.md` |
| Padrões de desenvolvimento | `docs/04-PADROES_DE_DESENVOLVIMENTO.md` |
| Contratos e dados | `docs/05-CONTRATOS_E_DADOS.md` |
| Integrações e acessos | `docs/06-INTEGRACOES_E_ACESSOS.md` |
| Segurança | `docs/07-SEGURANCA.md` |
| Testes e qualidade | `docs/08-TESTES_E_QUALIDADE.md` |
| Deploy e ambientes | `docs/09-DEPLOY_E_AMBIENTES.md` |
| Operação e incidentes | `docs/10-RUNBOOK.md` |
| Roadmap | `docs/11-ROADMAP.md` |
| Riscos e pendências | `docs/12-PENDENCIAS_E_RISCOS.md` |
| Protocolo de IA | `docs/13-PROTOCOLO_DE_IA.md` |
| DevOps e CI/CD | `docs/14-DEVOPS_E_CICD.md` |
| Comandos Git, Drone, Rancher e kubectl | `docs/15-COMANDOS_GIT_DRONE_RANCHER_KUBECTL.md` |
| Operação do pipeline | `docs/16-OPERACAO_DO_PIPELINE.md` |
| SRE e observabilidade | `docs/17-SRE_E_OBSERVABILIDADE.md` |
| Segurança da cadeia de entrega | `docs/18-SEGURANCA_DA_CADEIA_DE_ENTREGA.md` |
| Playbook Claude Code/Codex | `docs/19-PLAYBOOK_CLAUDE_CODE_DEVOPS.md` |
| Decisões arquiteturais | `docs/decisions/` |
| Mudanças feitas com IA | `docs/CHANGELOG_IA.md` |
| Diagramas | `diagrams/` |
| Protótipos | `prototypes/` |
| Templates DevOps | `devops/` |
| Pipeline Drone de exemplo | `.drone.yml.example` |
| Automação segura | `scripts/devops/` |

> Corrigir este mapa sempre que um documento for renomeado ou movido.

---

## 22. Perguntas em aberto

| ID | Pergunta | Impacto | Responsável | Prazo | Estado |
|---|---|---|---|---|---|
| Q-001 | `{{PERGUNTA}}` | `{{IMPACTO}}` | `{{NOME}}` | `AAAA-MM-DD` | `ABERTA` |

---

## 23. Manutenção desta base

- Revise este arquivo em mudanças de escopo, arquitetura, segurança, integrações ou operação.
- Remova informações obsoletas; não apenas acrescente novas versões contraditórias.
- Prefira links para documentos especializados em vez de duplicar grandes blocos.
- Toda seção `PENDENTE` deve ter responsável ou justificativa.
- Faça uma revisão periódica, mesmo quando o projeto estiver estável.

---

## 24. Contrato do pipeline

| Estágio | Entrada | Saída | Gate obrigatório | Pode escrever externamente? |
|---|---|---|---|---|
| Inspeção | commit e documentação | plano e escopo | base preenchida | Não |
| Qualidade | código | relatórios de lint, tipos e testes | zero falha nova crítica | Não |
| Segurança | código, dependências e imagem | SAST/SCA/segredos/SBOM | política aprovada | Não, exceto relatórios |
| Build | commit aprovado | imagem imutável | build reproduzível | Registry aprovado |
| Deploy dev | imagem validada | workload atualizado | dry-run, diff e autorização | Sim, somente namespace dev |
| Deploy homologação | mesma imagem | release candidata | aprovação | Sim, somente homologação |
| Deploy produção | mesma imagem/digest | release | aprovação + mudança + rollback | Sim, somente produção |
| Pós-deploy | release | evidências e métricas | rollout e smoke test | Leitura/telemetria |

Comandos específicos de linguagem continuam sendo definidos na seção **Comandos oficiais** e nunca devem ser adivinhados.

---

## 25. Contrato Kubernetes

- Manifests base: `devops/kubernetes/base/`.
- Variações por ambiente: `devops/kubernetes/overlays/`.
- RBAC de exemplo: `devops/kubernetes/rbac/`.
- O namespace deve existir previamente, salvo decisão arquitetural contrária.
- O deployer não recebe acesso a `Secret`, `Namespace`, RBAC, PVC, CRD ou recursos de cluster por padrão.
- `Deployment`, `Service`, `ConfigMap`, `ServiceAccount` e políticas opcionais devem ser idempotentes.
- Definir requests/limits, probes, `securityContext` e estratégia de rollout antes de produção.
- Toda imagem deve ter registry, repositório e tag/digest explícitos.
- A reversão padrão de aplicação é `kubectl rollout undo`, mas migrações e dados exigem plano separado.

---

## 26. Variáveis e segredos DevOps

| Nome | Sensível? | Origem | Consumidor | Regra |
|---|---|---|---|---|
| `DRONE_SERVER` | Não | configuração | Drone CLI | URL explícita |
| `DRONE_TOKEN` | Sim | cofre/Drone | Drone CLI | nunca registrar |
| `RANCHER_URL` | Não | configuração | Rancher CLI | URL explícita |
| `RANCHER_TOKEN` | Sim | cofre | Rancher CLI | uso humano/bootstrapping |
| `KUBE_CONFIG_B64` | Sim | segredo Drone | etapa de deploy | credencial mínima por ambiente |
| `KUBE_CONTEXT` | Não | sessão/pipeline | scripts | alvo efetivo, sem fallback |
| `EXPECTED_KUBE_CONTEXT` | Não | documentação aprovada | scripts | deve ser igual ao alvo efetivo |
| `EXPECTED_KUBE_SERVER` | Não | documentação aprovada | scripts | URL exata do API Server do contexto |
| `KUBE_NAMESPACE` | Não | sessão/pipeline | scripts | alvo efetivo, sem `default` implícito |
| `EXPECTED_KUBE_NAMESPACE` | Não | documentação aprovada | scripts | deve ser igual ao alvo efetivo |
| `IMAGE` | Não | build | deploy | tag imutável |
| `ALLOW_CLUSTER_WRITE` | Controle | pipeline/aprovação | script | deve ser `1` para escrita |
| `ALLOW_PRODUCTION_DEPLOY` | Controle | promoção aprovada | script | obrigatório em produção |
| `CHANGE_TICKET` | Não sensível | processo de mudança | produção | obrigatório quando aplicável |

---

## 27. Critérios DevOps de conclusão

Além da definição de pronto geral:

- [ ] branch, commit e build são rastreáveis;
- [ ] pipeline executou a partir do commit correto;
- [ ] imagem tem tag imutável e foi publicada no registry correto;
- [ ] nenhum segredo apareceu em diff, log ou artefato;
- [ ] manifest renderizado não contém placeholder;
- [ ] contexto, API Server, cluster e namespace foram confirmados;
- [ ] `dry-run=server` e `kubectl diff` foram avaliados;
- [ ] rollout terminou com sucesso;
- [ ] smoke tests e sinais de saúde foram verificados;
- [ ] rollback foi registrado;
- [ ] produção possui aprovação e referência de mudança.

---

## 28. Limitações conhecidas do template

- Os comandos de build, teste e empacotamento dependem da stack e devem ser preenchidos.
- As versões das imagens de ferramentas precisam ser fixadas conforme a matriz de compatibilidade local.
- O template de Drone Kubernetes exige Drone self-hosted e runner compatível.
- O runner Kubernetes do Drone deve ser avaliado pela organização antes de uso em produção.
- O template não instala Rancher, Drone Server, runner, cluster, registry ou observabilidade.
- O template não cria segredos nem fornece credenciais.
- Probes, portas, recursos e políticas de rede são exemplos e precisam refletir a aplicação real.

---

## 29. Referências operacionais internas

- Guia DevOps: `docs/14-DEVOPS_E_CICD.md`.
- Catálogo de comandos: `docs/15-COMANDOS_GIT_DRONE_RANCHER_KUBECTL.md`.
- Runbook do pipeline: `docs/16-OPERACAO_DO_PIPELINE.md`.
- Observabilidade: `docs/17-SRE_E_OBSERVABILIDADE.md`.
- Supply chain: `docs/18-SEGURANCA_DA_CADEIA_DE_ENTREGA.md`.
- Playbook de agentes: `docs/19-PLAYBOOK_CLAUDE_CODE_DEVOPS.md`.
- Templates de pipeline e manifests: `devops/`.
- Scripts com guardrails: `scripts/devops/`.
