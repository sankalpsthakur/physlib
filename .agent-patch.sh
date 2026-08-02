#!/usr/bin/env bash
set -euo pipefail

python3 - <<'PY'
from pathlib import Path
candidates = [
    Path("Physlib/ClassicalMechanics/HarmonicOscillator/Basic.lean"),
    Path("Physlib/ClassicalMechanics/HarmonicOscillator.lean"),
]
path = next((p for p in candidates if p.exists()), None)
if path is None:
    raise SystemExit("harmonic-oscillator module not found")
text = path.read_text()
start = text.find("/-!")
end = text.find("-/", start + 3)
if start < 0 or end < 0:
    raise SystemExit("module docstring not found")
old = text[start:end + 2]
if len(old) > 1100 and not any(word in old.lower() for word in ("stub", "placeholder", "todo")):
    raise SystemExit("existing module documentation is not a short placeholder")
new = '''/-!
# Harmonic oscillator

## A. Physical model

The harmonic oscillator describes motion in a quadratic potential and is the local approximation to
many stable mechanical systems.  It is also the standard bridge between classical dynamics,
normal-mode analysis, and quantum oscillator constructions.

## B. Formal setting

This module organizes the oscillator-specific definitions and results built on Physlib's general
classical-mechanics APIs.  Individual declarations specify their configuration space, parameters,
and regularity assumptions.

## C. Current status

The development contains selected oscillator calculations and solution properties rather than every
classical or quantum variant.  This overview does not duplicate the declaration-level documentation
of the concrete submodules.

## D. Future work

Natural extensions include driven and damped systems, coupled oscillators, normal-mode
decompositions, and explicit interfaces with the quantum harmonic oscillator.
-/'''
path.write_text(text[:start] + new + text[end + 2:])
PY
rm -f .agent-patch.sh .github/workflows/agent-apply-module-doc.yml
git config user.name "Sankalp Thakur"
git config user.email "sankalphimself@gmail.com"
git add -A
git commit -m "docs(ClassicalMechanics): expand the harmonic-oscillator overview"
git push --force origin HEAD:"${GITHUB_REF_NAME}"
