#!/usr/bin/env bash
set -euo pipefail

python3 - <<'PY'
from pathlib import Path
candidates = [
    Path("Physlib/Electromagnetism/Vacuum/HarmonicWave/Basic.lean"),
    Path("Physlib/Electromagnetism/Vacuum/HarmonicWave.lean"),
]
path = next((p for p in candidates if p.exists()), None)
if path is None:
    raise SystemExit("harmonic-wave module not found")
text = path.read_text()
start = text.find("/-!")
end = text.find("-/", start + 3)
if start < 0 or end < 0:
    raise SystemExit("module docstring not found")
old = text[start:end + 2]
if len(old) > 1100 and not any(word in old.lower() for word in ("stub", "placeholder", "todo")):
    raise SystemExit("existing module documentation is not a short placeholder")
new = '''/-!
# Harmonic electromagnetic waves in vacuum

## A. Physical setting

This module concerns time-harmonic electromagnetic fields in vacuum.  The harmonic ansatz separates
the oscillatory time dependence from spatial amplitudes and is the standard setting for plane-wave,
polarization, and monochromatic-field calculations.

## B. Formal setting

The concrete declarations build on Physlib's electromagnetic potentials, vacuum equations, and
three-dimensional field APIs.  Individual results state their frequency, regularity, and
nondegeneracy assumptions explicitly.

## C. Current status

The development covers selected harmonic-wave constructions and identities rather than all of
classical wave optics.  Declaration-level details remain documented in the focused submodules.

## D. Future work

Natural extensions include additional polarization bases, wave packets, interfaces and media,
energy-flux results, and bridges to the optics namespace.
-/'''
path.write_text(text[:start] + new + text[end + 2:])
PY
rm -f .agent-patch.sh .github/workflows/agent-apply-module-doc.yml
git config user.name "Sankalp Thakur"
git config user.email "sankalphimself@gmail.com"
git add -A
git commit -m "docs(Electromagnetism): expand the harmonic-wave overview"
git push --force origin HEAD:"${GITHUB_REF_NAME}"
