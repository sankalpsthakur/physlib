/-
Copyright (c) 2025 Joseph Tooby-Smith. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Joseph Tooby-Smith
-/
module

/-!

# A. Condensed matter physics

Condensed matter physics studies the collective behavior of many-particle systems, including the
electronic, thermal, and transport properties of solids and other materials. Physlib currently
contains focused models that connect microscopic or material parameters to observable behavior.

## A.1. Current APIs

The `TightBindingChain` development formalizes a one-dimensional periodic lattice with localized
states, a nearest-neighbor Hamiltonian, a Brillouin zone, and its energy eigenstates and
eigenvalues. The `Thermoelectric` development defines transport coefficients, the power factor,
total thermal conductivity, and the thermoelectric figure of merit together with positivity and
monotonicity results.

## A.2. Current status

This module is an overview and introduces no declarations. The substantive definitions and proofs
live in the corresponding submodules under `Physlib.CondensedMatter`.

## A.3. Future work

Further developments may connect these models to larger lattice systems, band structures,
statistical mechanics, and material-response APIs. New results should be placed in focused
submodules and reuse the quantum-mechanical and thermodynamic infrastructure already present in
Physlib.

-/
@[expose] public section
