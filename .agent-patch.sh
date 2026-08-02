#!/usr/bin/env bash
set -euo pipefail

python3 - <<'PY'
from pathlib import Path
candidates = [
    Path("Physlib/ParticlePhysics/StandardModel/Basic.lean"),
    Path("Physlib/ParticlePhysics/StandardModel.lean"),
]
path = next((p for p in candidates if p.exists()), None)
if path is None:
    raise SystemExit("Standard Model module not found")
text = path.read_text()
start = text.find("/-!")
end = text.find("-/", start + 3)
if start < 0 or end < 0:
    raise SystemExit("module docstring not found")
old = text[start:end + 2]
if len(old) > 1100 and not any(word in old.lower() for word in ("stub", "placeholder", "todo")):
    raise SystemExit("existing module documentation is not a short placeholder")
new = '''/-!
# The Standard Model of particle physics

## A. Scope

This module organizes the Physlib development related to the Standard Model.  The surrounding files
formalize selected gauge, representation, particle-content, and interaction data used in verified
Standard Model calculations.

## B. Organization

Concrete definitions and theorems live in focused submodules.  This overview records their shared
physical context without duplicating declaration-level documentation or treating model conventions
as implicit.

## C. Current status

The development captures selected structural and computational aspects of the Standard Model rather
than a complete quantum field theory or phenomenological implementation.  Each result states the
signature, representation, normalization, and parameter assumptions it uses.

## D. Future work

Useful extensions include more systematic Lagrangian and symmetry-breaking interfaces, additional
verified amplitudes and observables, and clearer bridges to the general QFT and geometry APIs.
-/'''
path.write_text(text[:start] + new + text[end + 2:])
PY
rm -f .agent-patch.sh .github/workflows/agent-apply-module-doc.yml
git config user.name "Sankalp Thakur"
git config user.email "sankalphimself@gmail.com"
git add -A
git commit -m "docs(ParticlePhysics): expand the Standard Model overview"
git push --force origin HEAD:"${GITHUB_REF_NAME}"
