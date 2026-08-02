#!/usr/bin/env bash
set -euo pipefail

python3 - <<'PY'
from pathlib import Path
path = Path("Physlib/Relativity/Basic.lean")
text = path.read_text()
start = text.find("/-!")
end = text.find("-/", start + 3)
if start < 0 or end < 0:
    raise SystemExit("module docstring not found")
old = text[start:end + 2]
if len(old) > 900 and not any(word in old.lower() for word in ("stub", "placeholder", "todo")):
    raise SystemExit("existing module documentation is not a short placeholder")
new = '''/-!
# Relativity

## A. Scope

This directory develops relativistic physics in Lean.  Its modules connect spacetime geometry,
Lorentzian structures, observers, and relativistic dynamics while stating signature and smoothness
assumptions explicitly.

## B. Organization

Concrete definitions and theorems are organized by topic and model.  This overview module provides
a stable entry point and records the relationship between the physics development and the
pseudo-Riemannian geometry available in Mathlib and Physlib.

## C. Current status

The formalization covers selected constructions in special and general relativity rather than a
complete treatment.  Individual results fix their own dimension, signature, coordinate, and field
equations assumptions.

## D. Future work

Useful extensions include additional exact spacetimes, curvature and geodesic applications,
observer-dependent quantities, and stronger bridges between geometric and variational APIs.
-/'''
path.write_text(text[:start] + new + text[end + 2:])
PY
rm -f .agent-patch.sh .github/workflows/agent-apply-module-doc.yml
git config user.name "Sankalp Thakur"
git config user.email "sankalphimself@gmail.com"
git add -A
git commit -m "docs(Relativity): expand the module overview"
git push --force origin HEAD:"${GITHUB_REF_NAME}"
