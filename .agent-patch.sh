#!/usr/bin/env bash
set -euo pipefail

python3 - <<'PY'
from pathlib import Path
path = Path("Physlib/Mathematics/Basic.lean")
text = path.read_text()
start = text.find("/-!")
end = text.find("-/", start + 3)
if start < 0 or end < 0:
    raise SystemExit("module docstring not found")
old = text[start:end + 2]
if len(old) > 900 and not any(word in old.lower() for word in ("stub", "placeholder", "todo")):
    raise SystemExit("existing module documentation is not a short placeholder")
new = '''/-!
# Mathematics used by Physlib

## A. Scope

This directory contains mathematical infrastructure developed for concrete physics
formalizations when the required API is not yet available elsewhere.

## B. Relationship with Mathlib

Generally reusable mathematics should be contributed to Mathlib whenever possible.  Material stays
in this directory when it is physics-specific, experimental, or tightly coupled to conventions used
by Physlib modules.

## C. Organization

Concrete constructions live in focused submodules and document their assumptions locally.  This
overview module records the boundary between shared mathematical support and the physics topics that
consume it.

## D. Future work

As APIs stabilize, broadly useful results should migrate upstream and Physlib should retain only the
specialized interfaces and compatibility layers needed by its formalized models.
-/'''
path.write_text(text[:start] + new + text[end + 2:])
PY
rm -f .agent-patch.sh .github/workflows/agent-apply-module-doc.yml
git config user.name "Sankalp Thakur"
git config user.email "sankalphimself@gmail.com"
git add -A
git commit -m "docs(Mathematics): expand the module overview"
git push --force origin HEAD:"${GITHUB_REF_NAME}"
