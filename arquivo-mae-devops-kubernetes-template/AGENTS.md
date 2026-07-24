# Instruções para agentes de desenvolvimento

Aplica-se a Codex, Claude Code e outros agentes.

## Ordem obrigatória

1. `ARQUIVO_MAE.md`.
2. `docs/13-PROTOCOLO_DE_IA.md`.
3. `docs/INDEX.md`.
4. Documentos da tarefa.
5. Para DevOps: documentos `14` a `19`, `.drone.yml.example`, `devops/` e `scripts/devops/`.
6. Código, configuração e testes afetados.

## Contrato

- Não inventar informação ausente.
- Separar fatos, hipóteses e desconhecidos.
- Planejar antes de editar.
- Alterar o mínimo necessário.
- Não instalar, promover, publicar ou aplicar sem autorização.
- Não usar credenciais reais em texto, arquivo, log ou argumento exibido.
- Não afirmar sucesso sem evidência.
- Informar o estado/fase do playbook e não avançar após bloqueio.
- Atualizar documentação e `docs/CHANGELOG_IA.md`.

## Infraestrutura

- Git é fonte da mudança.
- Drone é o orquestrador.
- Rancher administra o cluster/acesso.
- `kubectl` valida e aplica.
- Todo alvo mutável deve declarar contexto, API Server esperado e namespace.
- Produção exige aprovação, referência de mudança e rollback.
- Não usar `cluster-admin`, kubeconfig administrativo ou leitura de Secrets para simplificar.
- Comandos destrutivos permanecem proibidos sem autorização exata.

## Saída final

Informe objetivo, arquivos, diff, testes, comandos, alvos, resultados, limitações e reversão. Não inclua raciocínio privado nem segredos.
