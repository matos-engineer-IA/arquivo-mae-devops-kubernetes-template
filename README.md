# Arquivo-Mãe

> Base reutilizável de documentação, governança técnica e instruções para desenvolvimento assistido por IA.

O **Arquivo-Mãe** é uma estrutura portátil para iniciar projetos de software com contexto, padrões, segurança e rastreabilidade desde o primeiro commit.

Ele organiza as informações essenciais do projeto e orienta pessoas, Claude Code, Codex e outros agentes de IA a trabalharem de forma mais linear, previsível e segura.

---

## Visão geral

Em muitos projetos, decisões importantes ficam espalhadas entre conversas, arquivos, commits e conhecimento informal da equipe. Isso dificulta a manutenção e aumenta o risco de alterações inconsistentes.

O Arquivo-Mãe centraliza:

- objetivo e escopo do projeto;
- arquitetura e fluxos;
- regras de negócio;
- padrões de desenvolvimento;
- contratos de dados e integrações;
- comandos de execução, testes e deploy;
- requisitos de segurança;
- decisões técnicas;
- estado atual do projeto;
- instruções para agentes de IA;
- critérios de validação e conclusão.

A proposta não é substituir toda a documentação por um único arquivo. O `ARQUIVO_MAE.md` funciona como a **fonte central de verdade e índice da documentação**, enquanto os detalhes ficam distribuídos em arquivos especializados.

---

## Objetivos

O projeto foi criado para:

1. reduzir perda de contexto entre sessões de desenvolvimento;
2. evitar decisões técnicas contraditórias;
3. diminuir alterações indesejadas feitas por agentes de IA;
4. impedir invenção de endpoints, regras, schemas ou dependências;
5. facilitar onboarding de desenvolvedores;
6. tornar mudanças mais rastreáveis;
7. padronizar testes, revisão e deploy;
8. melhorar a apresentação técnica de projetos pessoais e profissionais.

---

## Como funciona

O Arquivo-Mãe estabelece uma hierarquia simples:

```text
ARQUIVO_MAE.md
        ↓
Contexto, escopo e regras centrais
        ↓
Documentação especializada em docs/
        ↓
CLAUDE.md e AGENTS.md
        ↓
Plano de alteração
        ↓
Implementação pequena e rastreável
        ↓
Testes, revisão de diff e documentação
```

Antes de alterar qualquer código, um agente deve:

1. ler o `ARQUIVO_MAE.md`;
2. consultar os documentos relacionados à tarefa;
3. verificar o estado atual do Git;
4. identificar fatos, hipóteses e informações ausentes;
5. apresentar um plano;
6. listar os arquivos que pretende modificar;
7. implementar apenas o necessário;
8. executar validações;
9. revisar o diff;
10. registrar limitações, riscos e próximos passos.

---

## Estrutura do projeto

```text
.
├── ARQUIVO_MAE.md
├── CLAUDE.md
├── AGENTS.md
├── README.md
├── Makefile
├── .env.example
├── .gitignore
├── .dockerignore
│
├── docs/
│   ├── ARQUITETURA.md
│   ├── REGRAS_E_CONTRATOS.md
│   ├── DESENVOLVIMENTO.md
│   ├── OPERACAO_E_DEPLOY.md
│   ├── SEGURANCA.md
│   ├── CHANGELOG_IA.md
│   └── decisions/
│       └── ADR-000-template.md
│
├── diagrams/
│   ├── arquitetura.md
│   ├── fluxo-principal.md
│   └── sequencia.md
│
├── prompts/
│   ├── TAREFA_PARA_IA.md
│   └── REVISAO_POR_IA.md
│
└── scripts/
    └── verificar_base.py
```

A estrutura pode ser reduzida ou expandida conforme o tamanho do projeto.

---

## Arquivos principais

### `ARQUIVO_MAE.md`

É a documentação central do projeto.

Deve conter:

- identidade do projeto;
- problema e objetivo;
- escopo e fora de escopo;
- estado atual;
- arquitetura resumida;
- stack tecnológica;
- regras de negócio;
- restrições;
- comandos oficiais;
- definição de pronto;
- matriz de permissões;
- protocolo de atuação para IA;
- mapa da documentação.

Ele deve ser atualizado quando uma decisão central do projeto mudar.

---

### `CLAUDE.md`

Contém instruções específicas para o Claude Code.

Seu objetivo é garantir que o Claude:

- leia o Arquivo-Mãe;
- não altere código sem contexto;
- não invente requisitos;
- apresente plano antes de mudanças;
- preserve alterações existentes;
- execute testes;
- não faça push ou deploy sem autorização.

---

### `AGENTS.md`

Define regras gerais para Codex e outros agentes.

Pode conter:

- limites de atuação;
- comandos permitidos;
- arquivos protegidos;
- critérios de parada;
- formato esperado da resposta;
- procedimentos de validação.

---

### `docs/`

Reúne documentação especializada.

Exemplos:

| Arquivo | Finalidade |
|---|---|
| `ARQUITETURA.md` | Componentes, integrações e fluxos |
| `REGRAS_E_CONTRATOS.md` | Regras de negócio, payloads e schemas |
| `DESENVOLVIMENTO.md` | Padrões, comandos e convenções |
| `OPERACAO_E_DEPLOY.md` | Execução, ambientes, deploy e rollback |
| `SEGURANCA.md` | Segredos, acessos e restrições |
| `CHANGELOG_IA.md` | Registro de alterações feitas com apoio de IA |
| `decisions/` | Architecture Decision Records |

---

### `prompts/`

Contém modelos de solicitação para agentes.

Eles ajudam a transformar pedidos vagos em tarefas controladas.

Exemplo:

```text
Objetivo:
Contexto:
Arquivos permitidos:
Arquivos protegidos:
Critérios de aceitação:
Comandos de validação:
Restrições:
Resultado esperado:
```

---

### `scripts/verificar_base.py`

Verifica se os arquivos essenciais existem e identifica campos ainda não preenchidos.

Exemplo:

```bash
python3 scripts/verificar_base.py
```

---

## Início rápido

### 1. Copie a estrutura

Copie os arquivos do Arquivo-Mãe para a raiz do novo projeto.

```bash
cp -R arquivo-mae-portatil/. meu-projeto/
cd meu-projeto
```

### 2. Preencha o documento central

Edite:

```text
ARQUIVO_MAE.md
```

Substitua campos como:

```text
{{NOME_DO_PROJETO}}
{{DESCRICAO}}
{{RESPONSAVEL}}
{{STACK}}
{{COMANDO_DE_TESTE}}
```

### 3. Remova o que não se aplica

Nem todo projeto precisa de:

- Kubernetes;
- Docker;
- múltiplos ambientes;
- ADRs extensos;
- observabilidade avançada.

Mantenha apenas o que representa o projeto real.

### 4. Valide a base

```bash
python3 scripts/verificar_base.py
```

### 5. Inicialize o Git

```bash
git init
git add .
git commit -m "chore: adiciona estrutura inicial do projeto"
```

---

## Fluxo recomendado de desenvolvimento

### Criar uma branch

```bash
git checkout -b feature/nome-da-tarefa
```

### Verificar o estado atual

```bash
git status
git diff
git log --oneline -10
```

### Solicitar uma alteração à IA

Use o modelo em:

```text
prompts/TAREFA_PARA_IA.md
```

Exemplo:

```text
Leia primeiro ARQUIVO_MAE.md, CLAUDE.md e os documentos relacionados.

Objetivo:
Adicionar validação de entrada no endpoint de criação.

Arquivos permitidos:
- src/api/routes/items.py
- tests/test_items.py

Restrições:
- não alterar contratos existentes;
- não adicionar dependências;
- não modificar banco de dados.

Validação:
- executar testes;
- revisar o diff;
- informar riscos e limitações.
```

### Revisar as mudanças

```bash
git diff
git status
```

### Executar validações

```bash
make lint
make test
make build
```

### Criar commit

```bash
git add .
git commit -m "feat: adiciona validacao de entrada"
```

---

## Regras para agentes de IA

O projeto adota as seguintes regras:

### Antes de alterar

- ler a documentação relevante;
- inspecionar os arquivos envolvidos;
- verificar se já existe implementação semelhante;
- explicar o entendimento;
- apresentar plano;
- listar arquivos afetados.

### Durante a alteração

- fazer mudanças pequenas;
- preservar contratos existentes;
- não remover código sem justificativa;
- não instalar dependências sem aprovação;
- não alterar arquitetura silenciosamente;
- não inserir credenciais;
- não inventar endpoints, campos ou regras;
- não transformar correção local em refatoração ampla.

### Depois da alteração

- executar testes;
- executar lint e build quando aplicável;
- revisar o diff;
- descrever exatamente o que mudou;
- informar o que não foi validado;
- atualizar documentação;
- registrar riscos;
- explicar como reverter.

---

## Regras contra alucinação

Quando uma informação não estiver disponível, o agente deve registrar como:

```text
Desconhecido
Não documentado
Não validado
Necessita confirmação
```

O agente não deve:

- inventar URLs;
- inventar credenciais;
- presumir schemas;
- criar campos não documentados;
- afirmar que um teste passou sem executá-lo;
- assumir que um recurso não é usado;
- tratar hipótese como decisão aprovada.

---

## Segurança

Credenciais reais nunca devem ser armazenadas no repositório.

Use:

```text
.env
gerenciador de segredos
variáveis do pipeline
secret manager da nuvem
secrets do Kubernetes
```

O repositório deve conter apenas:

```text
.env.example
```

Exemplo:

```env
DATABASE_URL=postgresql://usuario:senha@localhost:5432/banco
API_KEY=change-me
APP_ENV=development
```

O `.gitignore` deve bloquear:

```text
.env
*.pem
*.key
kubeconfig*
secrets.yaml
credentials.json
```

---

## Uso com DevOps

A versão portátil pode ser usada somente com Git ou expandida para:

- Docker;
- GitHub Actions;
- GitLab CI;
- Drone;
- Kubernetes;
- Rancher;
- Terraform;
- serviços de nuvem.

O fluxo recomendado é:

```text
Commit
  ↓
Pull Request
  ↓
Lint e testes
  ↓
Build
  ↓
Imagem versionada
  ↓
Deploy em desenvolvimento
  ↓
Validação
  ↓
Promoção controlada
```

Claude Code e Codex podem auxiliar na execução, mas operações remotas devem permanecer condicionadas à autorização humana e às permissões da plataforma.

---

## Definition of Done

Uma tarefa só deve ser considerada concluída quando:

- o código foi implementado;
- os critérios de aceitação foram atendidos;
- os testes relacionados foram executados;
- o lint não apresenta erros relevantes;
- o build foi validado;
- o diff foi revisado;
- nenhum segredo foi exposto;
- a documentação necessária foi atualizada;
- limitações foram registradas;
- o resultado pode ser reproduzido.

---

## Decisões arquiteturais

Decisões importantes devem ser registradas como ADRs.

Exemplo:

```text
docs/decisions/
├── ADR-001-escolha-do-framework.md
├── ADR-002-estrategia-de-banco.md
└── ADR-003-pipeline-de-deploy.md
```

Cada ADR deve conter:

- contexto;
- problema;
- alternativas;
- decisão;
- justificativa;
- consequências;
- riscos;
- status.

---

## Para recrutadores e equipes técnicas

Este projeto demonstra práticas relacionadas a:

- documentação de engenharia;
- arquitetura de software;
- governança de IA;
- Git e rastreabilidade;
- DevOps;
- segurança;
- testes;
- gestão de mudanças;
- integração entre desenvolvimento humano e agentes de IA;
- criação de processos reutilizáveis.

A estrutura não representa uma aplicação final. Ela funciona como um **framework operacional e documental** para iniciar e conduzir outros projetos.

---

## Quando usar

O Arquivo-Mãe é útil para:

- projetos pessoais;
- portfólio;
- provas técnicas;
- automações;
- APIs;
- agentes de IA;
- aplicações web;
- projetos de infraestrutura;
- projetos DevOps;
- times pequenos;
- onboarding de novos desenvolvedores;
- repositórios mantidos com Claude Code ou Codex.

---

## Quando simplificar

Para projetos pequenos, pode ser suficiente manter:

```text
ARQUIVO_MAE.md
CLAUDE.md
AGENTS.md
README.md
docs/ARQUITETURA.md
docs/CHANGELOG_IA.md
```

A documentação deve ajudar o projeto, não criar burocracia desnecessária.

---

## Contribuição

Sugestões de melhoria podem seguir este fluxo:

```bash
git checkout -b improvement/nome-da-melhoria
git add .
git commit -m "docs: melhora estrutura do arquivo-mae"
git push origin improvement/nome-da-melhoria
```

Ao propor uma mudança, explique:

- problema atual;
- mudança sugerida;
- impacto;
- compatibilidade;
- exemplo de uso.

---

## Licença

Defina a licença adequada ao uso do projeto.

Sugestões comuns:

- MIT;
- Apache 2.0;
- uso privado;
- licença proprietária.

Substitua esta seção pela licença escolhida antes de publicar.

---

## Autor

**{{NOME_DO_AUTOR}}**

- LinkedIn: {{URL_LINKEDIN}}
- GitHub: {{URL_GITHUB}}
- E-mail: {{EMAIL_PUBLICO_OPCIONAL}}

---

## Resumo

O Arquivo-Mãe transforma documentação e instruções de IA em parte ativa do processo de desenvolvimento.

Seu princípio central é simples:

> A IA pode acelerar o desenvolvimento, mas deve operar dentro de contexto, regras, validações e limites explícitos.
