#!/usr/bin/env python3
"""Verifica a estrutura, placeholders e riscos básicos da documentação base."""

from __future__ import annotations

import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

REQUIRED = [
    "ARQUIVO_MAE.md",
    "CLAUDE.md",
    "AGENTS.md",
    ".env.example",
    ".gitignore",
    ".drone.yml.example",
    "Makefile",
    ".gitattributes",
    "docs/INDEX.md",
    "docs/13-PROTOCOLO_DE_IA.md",
    "docs/14-DEVOPS_E_CICD.md",
    "docs/15-COMANDOS_GIT_DRONE_RANCHER_KUBECTL.md",
    "docs/16-OPERACAO_DO_PIPELINE.md",
    "docs/19-PLAYBOOK_CLAUDE_CODE_DEVOPS.md",
    "docs/CHANGELOG_IA.md",
    "devops/kubernetes/base/kustomization.yaml",
    "devops/environments/development.env.example",
    "scripts/devops/k8s_deploy.sh",
]

PLACEHOLDER = re.compile(r"\{\{[^{}]+\}\}|\bPENDENTE\b|replace-me|example\.invalid")
POSSIBLE_SECRET = re.compile(
    r"(?i)(api[_-]?key|token|password|passwd|secret)\s*[:=]\s*['\"]?([A-Za-z0-9_./+=-]{20,})"
)
TEXT_SUFFIXES = {".md", ".example", ".mmd", ".yaml", ".yml", ".sh", ".txt"}


def main() -> int:
    missing = [item for item in REQUIRED if not (ROOT / item).exists()]
    if missing:
        print("Arquivos obrigatórios ausentes:")
        for item in missing:
            print(f"- {item}")
        return 1

    gitignore = (ROOT / ".gitignore").read_text(encoding="utf-8")
    warnings: list[str] = []
    for expected in (".env", "kubeconfig", "devops/rendered/"):
        if expected not in gitignore:
            warnings.append(f".gitignore não parece proteger: {expected}")

    total = 0
    by_file: list[tuple[int, Path]] = []
    secret_hits: list[Path] = []

    for path in ROOT.rglob("*"):
        if not path.is_file():
            continue
        if path.suffix not in TEXT_SUFFIXES and path.name not in {"Makefile", ".gitignore"}:
            continue
        text = path.read_text(encoding="utf-8", errors="replace")
        count = len(PLACEHOLDER.findall(text))
        if count:
            total += count
            by_file.append((count, path.relative_to(ROOT)))
        if path.name != ".env.example":
            for match in POSSIBLE_SECRET.finditer(text):
                value = match.group(2).lower()
                known_example = any(token in value for token in (
                    "replace", "example", "obtido", "kubeconfig",
                    "from_secret", "placeholder", "secret_name"
                ))
                has_mixed_signal = bool(re.search(r"[a-z]", value) and re.search(r"[0-9]", value))
                if not known_example and has_mixed_signal:
                    secret_hits.append(path.relative_to(ROOT))
                    break

    print("Estrutura obrigatória: OK")
    print(f"Campos/valores de exemplo pendentes: {total}")
    for count, rel in sorted(by_file, reverse=True)[:20]:
        print(f"- {rel}: {count}")

    for warning in warnings:
        print(f"AVISO: {warning}")

    if secret_hits:
        print("AVISO: padrões que podem parecer segredos foram encontrados; revise:")
        for rel in secret_hits:
            print(f"- {rel}")

    active_drone = ROOT / ".drone.yml"
    if active_drone.exists():
        active_text = active_drone.read_text(encoding="utf-8", errors="replace")
        active_count = len(PLACEHOLDER.findall(active_text))
        if active_count:
            print(f"ERRO: .drone.yml ativo contém {active_count} placeholders/valores de exemplo.")
            return 1

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
