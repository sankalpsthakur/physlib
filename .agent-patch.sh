#!/usr/bin/env bash
set -euo pipefail

python3 - <<'PY'
from pathlib import Path

path = Path("Physlib/ParticlePhysics/Basic.lean")
text = path.read_text()
start = text.find("/-!")
end = text.find("-/", start + 3)
if start < 0 or end < 0:
    raise SystemExit("module docstring not found")
old = text[start:end + 2]
if len(old) > 900 and not any(word in old.lower() for word in ("stub", "placeholder", "todo")):
    raise SystemExit("existing module documentation is not a short placeholder")
new = '''/-!
# Particle physics

## A. Scope

This directory organizes Physlib's formalization of particle-physics models.  Its modules combine
representation-theoretic data, field and particle content, interaction constraints, and
model-specific calculations while keeping physical assumptions visible in theorem statements.

## B. Organization

Concrete APIs are divided by model and topic, including material related to the Standard Model
and its extensions.  This overview module describes the subject boundary without duplicating the
declaration-level documentation maintained in those submodules.

## C. Current status

The library formalizes selected structures and calculations rather than a complete construction of
quantum field theory or phenomenology.  Individual results should therefore be interpreted within
the conventions, signatures, and approximations fixed by their modules.

## D. Future work

Useful directions include stronger links between symmetry data and Lagrangian constructions,
additional verified calculations, and systematic interfaces connecting particle models to the
more general field-theory and geometry libraries.
-/'''
path.write_text(text[:start] + new + text[end + 2:])
PY

rm -f .agent-patch.sh .github/workflows/agent-apply-module-doc.yml

git config user.name "Sankalp Thakur"
git config user.email "sankalphimself@gmail.com"
git add -A
git commit -m "docs(ParticlePhysics): expand the module overview"
git push --force origin HEAD:"${GITHUB_REF_NAME}"
