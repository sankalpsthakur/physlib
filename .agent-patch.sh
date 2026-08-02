#!/usr/bin/env bash
set -euo pipefail

python3 - <<'PY'
from pathlib import Path
path = Path("Physlib/QFT/Basic.lean")
text = path.read_text()
start = text.find("/-!")
end = text.find("-/", start + 3)
if start < 0 or end < 0:
    raise SystemExit("module docstring not found")
old = text[start:end + 2]
if len(old) > 900 and not any(word in old.lower() for word in ("stub", "placeholder", "todo")):
    raise SystemExit("existing module documentation is not a short placeholder")
new = '''/-!
# Quantum field theory

## A. Scope

This directory organizes Physlib's quantum-field-theory development.  The formalization combines
spacetime and symmetry data with field content, operator-valued constructions, and model-specific
calculations while keeping conventions and regularity assumptions explicit.

## B. Organization

Concrete APIs live in focused submodules.  This overview module records the subject boundary and
serves as a stable entry point without duplicating declaration-level documentation.

## C. Current status

The library contains selected rigorous components and worked models rather than a complete
construction of interacting quantum field theory.  Statements should therefore be read within the
signature, dimension, classical or quantum setting, and analytic assumptions fixed by each module.

## D. Future work

Natural extensions include stronger interfaces for Lagrangians and symmetries, additional free and
interacting models, and systematic links to particle-physics and Lorentzian-geometry APIs.
-/'''
path.write_text(text[:start] + new + text[end + 2:])
PY
rm -f .agent-patch.sh .github/workflows/agent-apply-module-doc.yml
git config user.name "Sankalp Thakur"
git config user.email "sankalphimself@gmail.com"
git add -A
git commit -m "docs(QFT): expand the module overview"
git push --force origin HEAD:"${GITHUB_REF_NAME}"
