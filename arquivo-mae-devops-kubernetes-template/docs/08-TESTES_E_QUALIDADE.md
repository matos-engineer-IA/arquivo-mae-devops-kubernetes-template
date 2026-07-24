# Testes e qualidade

## 1. Pirâmide e responsabilidades

| Camada | Objetivo | Comando oficial | Gate |
|---|---|---|---|
| Unitário | regra isolada | `{{COMANDO}}` | `{{REGRA}}` |
| Integração | fronteiras reais/controladas | `{{COMANDO}}` | `{{REGRA}}` |
| Contrato | compatibilidade entre serviços | `{{COMANDO}}` | `{{REGRA}}` |
| End-to-end | jornada crítica | `{{COMANDO}}` | `{{REGRA}}` |
| Smoke | saúde pós-deploy | `{{COMANDO}}` | obrigatório por release |
| Performance | capacidade/latência | `{{COMANDO}}` | conforme criticidade |
| Segurança | SAST/SCA/segredos/imagem | `{{COMANDO}}` | conforme política |

## 2. Qualidade local

Ordem recomendada, usando apenas comandos oficiais preenchidos:

```text
format check -> lint -> tipos -> testes rápidos -> build -> testes ampliados
```

Não afirme que uma validação passou sem executar. Registre comando, código de saída e limitações.

## 3. Qualidade do pipeline

O pipeline deve verificar:

- documentação base;
- instalação reproduzível;
- lint e tipos;
- testes e cobertura relevante;
- build da aplicação;
- segredos e dependências;
- imagem e SBOM conforme política;
- manifests renderizados sem placeholders;
- scripts com análise sintática;
- YAML parseável;
- promoção somente de artefato publicado.

## 4. Testes de manifests

Mínimo:

```sh
IMAGE='<imagem-imutavel>' DEPLOY_ENV=development \
  sh scripts/devops/k8s_validate.sh
```

Em ambiente com acesso controlado:

```sh
CHECK_SERVER=1 IMAGE='<imagem-imutavel>' DEPLOY_ENV=development \
  sh scripts/devops/k8s_validate.sh
```

Validar também:

- nomes e namespaces;
- selectors e labels;
- probes e portas;
- requests/limits;
- `securityContext`;
- ausência de recursos cluster-scoped não aprovados;
- compatibilidade com políticas do cluster.

## 5. Testes do pipeline e scripts

- analisar todos os YAMLs;
- executar `sh -n scripts/devops/*.sh`;
- testar gates com CLI simulada em ambiente isolado;
- provar que `DRY_RUN_ONLY=1` impede apply;
- provar que produção falha sem gate e ticket;
- provar que contexto inexistente bloqueia deploy;
- tratar corretamente o código `1` de `kubectl diff`;
- testar falha de rollout sem rollback automático oculto.

A CLI local do Drone não deve ser considerada validação suficiente para pipeline Kubernetes; o teste final ocorre no runner homologado.

## 6. Cobertura e exceções

| Métrica | Meta | Bloqueia? | Exceção |
|---|---:|---|---|
| `{{METRICA}}` | `{{META}}` | `SIM/NÃO` | `{{PROCESSO}}` |

Uma exceção precisa de justificativa, mitigação, responsável e data de expiração.

## 7. Evidência

Para cada alteração, registre:

```text
Comandos:
Resultados:
Testes não executados:
Motivo:
Ambiente:
Commit/build:
Imagem:
Riscos remanescentes:
```
