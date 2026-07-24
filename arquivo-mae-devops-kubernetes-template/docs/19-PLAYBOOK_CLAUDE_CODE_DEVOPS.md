# Playbook DevOps para Claude Code e Codex

> Procedimento linear para desenvolvimento e deploy em Kubernetes. Não concede permissão; apenas define como agir quando o acesso e a autorização já existem.

## 1. Objetivo operacional

Executar mudanças de forma rastreável, com um único caminho:

```text
ler -> inspecionar -> planejar -> editar -> validar localmente -> revisar diff
-> publicar branch autorizada -> observar CI Drone -> promover build autorizado
-> validar Kubernetes -> aplicar -> observar rollout -> registrar evidências
```

Não pule fases. Não execute uma fase posterior quando a anterior estiver incompleta.

## 2. Estados do fluxo

| Estado | Entrada obrigatória | Saída esperada | Escrita externa? |
|---|---|---|---|
| S0 Contexto | documentação disponível | fatos, lacunas e alvo | não |
| S1 Baseline | repositório limpo ou mudanças conhecidas | snapshot Git | não |
| S2 Plano | requisito e critérios claros | plano e arquivos | não |
| S3 Implementação | plano aprovado | diff local mínimo | somente arquivos locais |
| S4 Validação | comandos oficiais preenchidos | testes e build | não, salvo caches aprovados |
| S5 Publicação Git | autorização para commit/push | commit e branch remota | sim |
| S6 CI Drone | webhook/build existente | build verde e imagem identificada | Drone executa conforme pipeline |
| S7 Deploy dev | promoção autorizada | dry-run, diff, apply e rollout | namespace de desenvolvimento |
| S8 Pós-deploy | rollout concluído | smoke test e evidências | leitura/telemetria |
| S9 Promoção superior | aprovação humana | staging/produção | ambiente aprovado |

## 3. Cabeçalho obrigatório antes de comandos remotos

```text
OBJETIVO=
REPOSITORIO=
BRANCH=
COMMIT_SHA=
DRONE_BUILD=
DRONE_EVENT=
DRONE_TARGET=
AMBIENTE=
RANCHER_SERVER=
KUBE_CONTEXT=
EXPECTED_KUBE_CONTEXT=
EXPECTED_KUBE_SERVER=
KUBE_NAMESPACE=
EXPECTED_KUBE_NAMESPACE=
K8S_OVERLAY=
IMAGEM=
APROVACAO=
CHANGE_TICKET=
ROLLBACK=
```

Os valores `EXPECTED_KUBE_*` devem ser copiados da identidade operacional aprovada, não inferidos do contexto ativo. O script também compara a URL real do API Server do contexto com `EXPECTED_KUBE_SERVER`.

Qualquer campo essencial desconhecido deve ser marcado `DESCONHECIDO`. Um campo essencial desconhecido bloqueia a escrita.

## 4. Fase S0 — leitura e contexto

Leia, nesta ordem:

1. `ARQUIVO_MAE.md`;
2. `CLAUDE.md` ou `AGENTS.md`;
3. `docs/13-PROTOCOLO_DE_IA.md`;
4. documentos `14` a `19`;
5. ADRs aceitos;
6. arquivos e testes envolvidos.

Produza:

```text
FATOS:
HIPOTESES:
DESCONHECIDOS:
CONFLITOS:
DECISAO NECESSARIA:
```

## 5. Fase S1 — baseline local

```sh
python3 scripts/verificar_base.py
sh scripts/devops/git_snapshot.sh
sh scripts/devops/preflight.sh local
```

Pare quando:

- houver mudança local que não pertence à tarefa;
- o branch estiver incorreto;
- a base obrigatória estiver incompleta de forma material;
- um comando oficial necessário estiver `PENDENTE`.

## 6. Fases S2 e S3 — plano e implementação

Antes de editar, informe objetivo, arquivos, riscos e validações. Durante a edição:

- altere apenas os arquivos declarados;
- não faça refatoração paralela;
- não instale dependência sem aprovação;
- não altere `.drone.yml`, manifests, RBAC ou produção como consequência indireta;
- preserve mudanças preexistentes de outras pessoas;
- mantenha cada alteração reversível.

Ao terminar:

```sh
git diff --check
git diff --stat
git diff -- path/to/affected/files
```

## 7. Fase S4 — validação local

Execute somente os comandos oficiais preenchidos no `ARQUIVO_MAE.md`. Nunca adivinhe a stack.

Ordem sugerida:

```text
instalação reproduzível -> lint -> tipos -> testes -> build -> scanners -> base-check
```

Para manifests:

```sh
IMAGE='<registry/repository:commit-sha>' \
DEPLOY_ENV=development \
sh scripts/devops/k8s_validate.sh
```

A CLI do Drone não deve ser usada como prova local de lint ou execução de um pipeline Kubernetes. Valide YAML, scripts e comandos separadamente e confirme o resultado no runner real.

## 8. Fase S5 — Git, somente com autorização

```sh
git status --short --branch
git diff --check
git add -- path/to/explicit/files
git diff --cached
git commit -m '<tipo>: <descricao objetiva>'
git push --set-upstream origin '<branch>'
```

Pare antes de `commit` ou `push` quando a autorização não for explícita. Nunca use force push, reset destrutivo ou limpeza ampla.

## 9. Fase S6 — Drone

Inspeção:

```sh
drone repo info "$DRONE_REPO"
drone build ls "$DRONE_REPO" --limit 10
drone build info "$DRONE_REPO" '<BUILD_NUMBER>'
```

Confirme:

- repositório correto;
- commit do build igual ao commit pretendido;
- CI concluída com sucesso;
- etapa de publicação autorizada;
- imagem/tag/digest identificados;
- ausência de segredo em logs.

O agente não deve reiniciar ou aprovar build por tentativa e erro.

## 10. Fase S7 — deploy de desenvolvimento

### 10.1 Pré-condições

- `DEPLOY_ENV=development`;
- contexto e namespace documentados;
- kubeconfig mínimo;
- imagem imutável já publicada;
- CI verde;
- promoção autorizada;
- nenhuma pendência crítica.

### 10.2 Promoção

```sh
export ALLOW_DRONE_WRITE=1
sh scripts/devops/drone_promote.sh '<BUILD_NUMBER>' development
```

Esse comando cria a solicitação de promoção; não prova que o deploy terminou.

### 10.3 Deploy direto controlado, quando o processo aprovado exigir

Primeiro, somente leitura e diff:

```sh
export DEPLOY_ENV=development
export DRY_RUN_ONLY=1
sh scripts/devops/preflight.sh cluster-read
sh scripts/devops/k8s_deploy.sh development
```

Depois, somente com autorização para escrita e após revisão do diff:

```sh
export DRY_RUN_ONLY=0
export ALLOW_CLUSTER_WRITE=1
sh scripts/devops/preflight.sh cluster-write
sh scripts/devops/k8s_deploy.sh development
```

Nunca use deploy direto para contornar uma promoção obrigatória do Drone.

## 11. Fase S8 — pós-deploy

Confirme e registre:

```sh
kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" \
  rollout status "deployment/$K8S_DEPLOYMENT" --timeout="$ROLLOUT_TIMEOUT"
kubectl --context "$KUBE_CONTEXT" --namespace "$KUBE_NAMESPACE" \
  get "deployment/$K8S_DEPLOYMENT" -o wide
```

Execute os smoke tests oficiais e observe métricas, logs e alertas. `rollout status` positivo não substitui validação funcional.

## 12. Fase S9 — staging e produção

O agente pode preparar plano, diff e evidências, mas não deve promover nem aplicar sem aprovação humana específica para aquele build, imagem e ambiente.

Produção exige, no mínimo:

- build e digest aprovados;
- homologação concluída;
- janela/ticket de mudança;
- responsável presente;
- observabilidade operacional;
- rollback testado;
- autorização de promoção e escrita.

Variáveis de gate não substituem segregação de funções.

## 13. Condições universais de parada

Pare imediatamente quando houver:

- contexto, API Server, cluster ou namespace divergente;
- alvo com aparência de produção em fluxo não produtivo;
- `kubectl diff` inesperado ou muito maior que o escopo;
- placeholder no manifest;
- recurso cluster-scoped não aprovado;
- RBAC insuficiente ou excessivo;
- necessidade de ler/criar segredo fora do processo;
- imagem diferente da validada;
- CI, teste, scanner, rollout ou smoke test com falha;
- mudança local de terceiro em risco;
- necessidade de comando destrutivo;
- ausência de rollback ou aprovação.

## 14. Relatório ao concluir cada fase

```text
FASE:
STATUS: CONCLUIDA | BLOQUEADA | FALHOU
ALVO:
COMANDOS EXECUTADOS:
RESULTADOS:
ARQUIVOS/RECURSOS AFETADOS:
EVIDENCIAS:
RISCOS:
PROXIMA FASE PERMITIDA:
AUTORIZACAO NECESSARIA:
ROLLBACK:
```

Não declare o pipeline concluído antes de CI, deploy, rollout, smoke tests e evidências estarem completos.
