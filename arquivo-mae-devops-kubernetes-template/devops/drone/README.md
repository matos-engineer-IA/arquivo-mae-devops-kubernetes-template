# Drone

O pipeline principal de exemplo está em `/.drone.yml.example`. O bloco opcional de publicação está em `image-build-step.template.yml`, e o runner de plataforma em `runner-kubernetes/`.

## Regras

- Drone Kubernetes pipelines exigem instalação self-hosted.
- Fixe versões/digests das imagens usadas nos passos.
- Separe CI de pipelines de promoção.
- Use uma credencial de cluster por ambiente.
- Não permita credenciais de deploy em pull requests.
- Construa uma vez e promova a mesma imagem.
- Não use plugin privilegiado sem aprovação de segurança.
- A CLI Drone atual não executa/linta localmente pipelines do tipo Kubernetes; valide YAML, placeholders e comportamento no servidor controlado.

## Segredos esperados

```text
kubeconfig_development_b64
kubeconfig_staging_b64
kubeconfig_production_b64
{{REGISTRY_USERNAME_SECRET}}
{{REGISTRY_PASSWORD_SECRET}}
```

Documente apenas os nomes. Os valores ficam fora do Git.
