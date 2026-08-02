/-
Copyright (c) 2025 Joseph Tooby-Smith. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Joseph Tooby-Smith
-/
module

/-!

# A. Thermodynamics

Thermodynamics describes macroscopic systems through state variables such as temperature, energy,
volume, particle number, and entropy, together with relations between equilibrium states and
thermodynamic processes.

## A.1. Current APIs

The `Temperature` development represents absolute temperature, relates it to inverse temperature,
and provides common temperature-unit conversions. The `IdealGas` development defines an entropy
model for a monophase ideal gas and proves equivalent logarithmic and product forms of its
adiabatic relation.

## A.2. Current status

This module is an overview and introduces no declarations. Statistical ensembles and additional
thermodynamic quantities are developed under `Physlib.StatisticalMechanics`, while the modules in
this directory focus on temperature and a direct thermodynamic ideal-gas model.

## A.3. Future work

Future developments may organize thermodynamic systems and state spaces into a common API, connect
macroscopic laws systematically to statistical mechanics, and formalize further equations of
state, response coefficients, and thermodynamic processes.

-/

@[expose] public section
