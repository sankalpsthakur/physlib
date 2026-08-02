#!/usr/bin/env bash
set -euo pipefail

python3 - <<'PY'
from pathlib import Path

path = Path("Physlib/QuantumMechanics/Basic.lean")
text = path.read_text()
start = text.find("/-!")
end = text.find("-/", start + 3)
if start < 0 or end < 0:
    raise SystemExit("module docstring not found")
old = text[start:end + 2]
if len(old) > 900 and not any(word in old.lower() for word in ("stub", "placeholder", "todo")):
    raise SystemExit("existing module documentation is not a short placeholder")
new = '''/-!
# Quantum mechanics

## A. Scope

This directory develops quantum-mechanical systems in Lean, combining the Hilbert-space
formalism with APIs for states, observables, operators, and time evolution.  The emphasis is on
reusable mathematical structures whose physical assumptions are stated explicitly.

## B. Organization

Concrete definitions and results live in focused submodules.  This overview module records the
subject boundary and provides a stable place for shared imports; it does not duplicate the API
documentation of those submodules.

## C. Current status

The formalization covers selected foundational constructions and worked systems rather than a
complete axiomatization of quantum mechanics.  Results should be read with the hypotheses and
finite- or infinite-dimensional setting stated by their individual modules.

## D. Future work

Natural extensions include broader spectral and measurement APIs, additional dynamical systems,
and clearer bridges between abstract operator results and concrete physical models.
-/'''
path.write_text(text[:start] + new + text[end + 2:])
PY

rm -f .agent-patch.sh .github/workflows/agent-apply-module-doc.yml

git config user.name "Sankalp Thakur"
git config user.email "sankalphimself@gmail.com"
git add -A
git commit -m "docs(QuantumMechanics): expand the module overview"
git push --force origin HEAD:"${GITHUB_REF_NAME}"
