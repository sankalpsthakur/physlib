/-
Copyright (c) 2025 Joseph Tooby-Smith. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Joseph Tooby-Smith
-/
module

/-!

# A. String theory

String theory models fundamental objects using extended degrees of freedom and connects quantum
field theory, geometry, and gravity. Physlib's current string-theory development has a focused
scope: phenomenological data and consistency conditions for F-theory models with an `SU(5)` gauge
group.

## A.1. Current APIs

The `FTheory.SU5` modules organize potential terms, representation charges, fluxes, and combined
quanta. They formalize constraints such as anomaly cancellation, the absence of exotic matter,
allowed interaction terms, and phenomenological viability. Several definitions reuse the related
supersymmetric `SU(5)` infrastructure under `Physlib.Particles.SuperSymmetry.SU5`.

## A.2. Current status

This module is an overview and introduces no declarations. The substantive results live under
`Physlib.StringTheory.FTheory.SU5`, including finite classifications of flux and quanta data for
selected configurations.

## A.3. Future work

Broader string-theory formalization should be introduced through focused modules with explicit
mathematical and physical scope. Natural directions include additional compactification data,
geometric constructions, consistency conditions, and connections between effective field
content and the underlying geometry.

-/

@[expose] public section
