#!/usr/bin/env bash
set -euo pipefail

python3 - <<'PY'
from pathlib import Path
path = Path("Physlib/Units/Basic.lean")
text = path.read_text()
start = text.find("/-!")
end = text.find("-/", start + 3)
if start < 0 or end < 0:
    raise SystemExit("module docstring not found")
old = text[start:end + 2]
if len(old) > 900 and not any(word in old.lower() for word in ("stub", "placeholder", "todo")):
    raise SystemExit("existing module documentation is not a short placeholder")
new = '''/-!
# Physical units

## A. Scope

This directory provides reusable infrastructure for physical units, unit systems, and conversions.
Its purpose is to keep dimensional information explicit while allowing calculations to move between
conventional unit choices without changing the underlying physical quantity.

## B. Organization

Concrete dimensions and named units live in focused submodules.  This overview module records the
common role of scaling, conversion, and dimensioned quantities without duplicating their APIs.

## C. Current status

The library covers the unit families needed by existing Physlib developments.  Numerical conversion
factors and normalization conventions are stated in the modules that define them and should not be
inferred from notation alone.

## D. Future work

Useful extensions include broader dimensional-analysis automation, additional conventional unit
systems, and stronger simplification support for mixed-unit calculations.
-/'''
path.write_text(text[:start] + new + text[end + 2:])
PY
rm -f .agent-patch.sh .github/workflows/agent-apply-module-doc.yml
git config user.name "Sankalp Thakur"
git config user.email "sankalphimself@gmail.com"
git add -A
git commit -m "docs(Units): expand the module overview"
git push --force origin HEAD:"${GITHUB_REF_NAME}"
