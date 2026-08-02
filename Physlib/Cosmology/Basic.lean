/-
Copyright (c) 2025 Joseph Tooby-Smith. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Joseph Tooby-Smith
-/
module

/-!

# A. Cosmology

Cosmology studies the large-scale geometry, composition, and evolution of the universe. Physlib's
current cosmology development is centered on homogeneous and isotropic
Friedmann–Lemaître–Robertson–Walker models.

## A.1. Current APIs

The `FLRW` submodules define spatial geometries and scale factors, conformal time, density
parameters, cosmological distances, dynamical equations, matter content, and selected solutions.
Together these modules provide the beginnings of a formal API for standard relativistic
cosmology.

## A.2. Current status

This module is an overview and introduces no declarations. Some parts of the FLRW development are
still informal or semiformal, while other definitions and analytic results are fully formalized.

## A.3. Future work

Further work includes reducing the remaining semiformal content, strengthening the connection to
general relativity and differential geometry, and developing models for perturbations,
observables, and additional cosmological matter sectors.

-/
@[expose] public section
