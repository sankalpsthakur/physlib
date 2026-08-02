/-
Copyright (c) 2025 Joseph Tooby-Smith. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Joseph Tooby-Smith
-/
module

/-!

# A. Optics

Optics studies the propagation, transformation, and measurement of light. In Physlib, optical
phenomena are closely connected to the electromagnetism API because light is represented through
electromagnetic waves and their fields.

## A.1. Current organization

The earlier real-valued polarization development has been reorganized under
`Physlib.Electromagnetism.Vacuum.HarmonicWave`, where monochromatic plane waves and polarization
properties can share the surrounding electromagnetic definitions. The
`Physlib.Optics.Polarization` namespace remains available for future optics-specific material.

## A.2. Current status

This module is an overview and introduces no declarations. The existing optics directory is small,
and its substantive polarization content currently lives in the electromagnetism hierarchy.

## A.3. Future work

Potential additions include optics-specific APIs for polarization representations, interference,
diffraction, geometric optics, optical elements, and measurement conventions, with equivalence
results connecting them to the electromagnetic-wave formulation where appropriate.

-/
@[expose] public section
