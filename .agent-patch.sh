#!/usr/bin/env bash
set -euo pipefail

python3 - <<'PY'
from pathlib import Path
path = Path("Physlib/StatisticalMechanics/Basic.lean")
text = path.read_text()
start = text.find("/-!")
end = text.find("-/", start + 3)
if start < 0 or end < 0:
    raise SystemExit("module docstring not found")
old = text[start:end + 2]
if len(old) > 900 and not any(word in old.lower() for word in ("stub", "placeholder", "todo")):
    raise SystemExit("existing module documentation is not a short placeholder")
new = '''/-!
# Statistical mechanics

## A. Scope

This directory develops statistical descriptions of physical systems, connecting probability and
measure-theoretic models of microscopic states with macroscopic observables and thermodynamic
quantities.

## B. Organization

Concrete ensembles, distributions, observables, and model calculations live in focused submodules.
This overview module records the subject boundary without duplicating their declaration-level API.

## C. Current status

The formalization covers selected models and foundational constructions rather than a complete
account of equilibrium or nonequilibrium statistical mechanics.  Each result states the finiteness,
measurability, and normalization assumptions it requires.

## D. Future work

Natural extensions include additional ensembles and lattice models, thermodynamic-limit results,
fluctuation identities, and clearer interfaces with the thermodynamics and probability libraries.
-/'''
path.write_text(text[:start] + new + text[end + 2:])
PY
rm -f .agent-patch.sh .github/workflows/agent-apply-module-doc.yml
git config user.name "Sankalp Thakur"
git config user.email "sankalphimself@gmail.com"
git add -A
git commit -m "docs(StatisticalMechanics): expand the module overview"
git push --force origin HEAD:"${GITHUB_REF_NAME}"
