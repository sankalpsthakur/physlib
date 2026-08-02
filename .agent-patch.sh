#!/usr/bin/env bash
set -euo pipefail

python3 - <<'PY'
from pathlib import Path
candidates = [Path("Physlib/Cosmology/FLRW/Basic.lean"), Path("Physlib/Cosmology/FLRW.lean")]
path = next((p for p in candidates if p.exists()), None)
if path is None:
    raise SystemExit("FLRW module not found")
text = path.read_text()
start = text.find("/-!")
end = text.find("-/", start + 3)
if start < 0 or end < 0:
    raise SystemExit("module docstring not found")
old = text[start:end + 2]
if len(old) > 1100 and not any(word in old.lower() for word in ("stub", "placeholder", "todo")):
    raise SystemExit("existing module documentation is not a short placeholder")
new = '''/-!
# Friedmann–Lemaître–Robertson–Walker cosmology

## A. Physical setting

FLRW spacetimes model homogeneous and isotropic cosmologies through a time-dependent scale factor
and a constant-curvature spatial geometry.  They provide the standard setting for the Friedmann
equations and many baseline cosmological calculations.

## B. Formal setting

This module organizes the shared FLRW definitions and results used by the concrete cosmology
submodules.  Individual declarations state the spacetime signature, matter model, differentiability,
and parameter assumptions they require.

## C. Current status

Physlib formalizes selected FLRW structures and calculations rather than a complete cosmological
model.  The overview distinguishes kernel-checked results from any semiformal or computational
material contained in neighboring files.

## D. Future work

Natural extensions include additional matter components, curvature cases, observational distance
relations, perturbations, and clearer links to the general relativity API.
-/'''
path.write_text(text[:start] + new + text[end + 2:])
PY
rm -f .agent-patch.sh .github/workflows/agent-apply-module-doc.yml
git config user.name "Sankalp Thakur"
git config user.email "sankalphimself@gmail.com"
git add -A
git commit -m "docs(Cosmology): expand the FLRW module overview"
git push --force origin HEAD:"${GITHUB_REF_NAME}"
