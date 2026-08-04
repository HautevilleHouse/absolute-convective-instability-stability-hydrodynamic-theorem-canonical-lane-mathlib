/-
All Rights Reserved - No License Granted

Copyright (c) 2026 HautevilleHouse. All rights reserved.

This repository is published for academic review, citation, priority, public
notice, and research-reference purposes only.

No license is granted to use, copy, reproduce, redistribute, modify, merge,
publish, distribute, sublicense, sell, fork, mirror, scrape, use for training or
fine-tuning, include in a dataset or benchmark, use to create, evaluate, or
benchmark a derivative system, incorporate into another system, or create
derivative works from this repository or any substantial portion of it without
prior written permission from the rights holder.

Viewing this repository on GitHub for academic review and citation is permitted
with all rights reserved by the rights holder.

Any discussion, review, comparison, implementation, derivative research use, or
public reference to this repository must cite the repository and preserve this
notice.

Unauthorized reproduction or redistribution of this repository, including public
GitHub forks containing the repository contents, constitutes copyright
infringement and may be subject to DMCA.
-/
import Mathlib.Data.Real.Basic
import AbsoluteConvectiveInstabilityStabilityHydrodynamicTheoremCanonicalLaneLean.AdmissibleClass

namespace HautevilleHouse
namespace AbsoluteConvectiveInstabilityStabilityHydrodynamicTheoremCanonicalLaneLean

open HautevilleHouse.CanonicalLaneMathlibCore

/-- A projection structure: an idempotent endomap. -/
structure Projection (α : Type) where
  toFun : α → α
  idempotent : ∀ x : α, toFun (toFun x) = toFun x

/-- A hydrodynamic instability state: growth rate, group velocity, and flags. -/
structure HydrodynamicState where
  growthRate : ℝ
  groupVelocity : ℝ
  absolutelyUnstable : Prop
  convectivelyUnstable : Prop

/-- The canonical projection: maps any state to the canonical state determined solely by the growth rate and group velocity. -/
def canonicalProjection (s : HydrodynamicState) : HydrodynamicState := {
  growthRate := s.growthRate
  groupVelocity := s.groupVelocity
  absolutelyUnstable := s.growthRate > 0
  convectivelyUnstable := s.growthRate > 0 ∧ s.groupVelocity ≠ 0
}

/-- The canonical projection is idempotent. -/
theorem canonicalProjection_idempotent (s : HydrodynamicState) :
    canonicalProjection (canonicalProjection s) = canonicalProjection s := by
  unfold canonicalProjection
  rfl

/-- The full theorem projection as an instance of the `Projection` structure. -/
def theoremProjection : Projection HydrodynamicState := {
  toFun := canonicalProjection
  idempotent := canonicalProjection_idempotent
}

/-- The idempotence statement of the theorem projection. -/
theorem theoremProjection_idempotent (s : HydrodynamicState) :
    theoremProjection.toFun (theoremProjection.toFun s) = theoremProjection.toFun s := by
  exact theoremProjection.idempotent s

/-- Absolute instability is characterized by positive growth rate in the canonical projection. -/
theorem absolute_instability_iff (s : HydrodynamicState) :
    (canonicalProjection s).absolutelyUnstable ↔ s.growthRate > 0 := by
  unfold canonicalProjection
  constructor
  · intro h
    exact h
  · intro h
    exact h

/-- Convective instability is characterized by positive growth rate and nonzero group velocity in the canonical projection. -/
theorem convective_instability_iff (s : HydrodynamicState) :
    (canonicalProjection s).convectivelyUnstable ↔ s.growthRate > 0 ∧ s.groupVelocity ≠ 0 := by
  unfold canonicalProjection
  constructor
  · intro h
    exact h
  · intro h
    exact h

/-- A state is absolutely unstable if it has positive growth rate and its group velocity vanishes. -/
def IsAbsolutelyUnstable (s : HydrodynamicState) : Prop :=
  s.absolutelyUnstable ∧ s.growthRate > 0 ∧ s.groupVelocity = 0

/-- The canonical projection preserves absolute instability. -/
theorem projection_preserves_absolutely_unstable (s : HydrodynamicState)
    (h : IsAbsolutelyUnstable s) :
    IsAbsolutelyUnstable (canonicalProjection s) := by
  rcases h with ⟨h_abs, h_pos, h_vel⟩
  unfold IsAbsolutelyUnstable canonicalProjection
  constructor
  · exact h_pos
  · constructor
    · exact h_pos
    · exact h_vel

/-- The admissible-class bridge: HydrodynamicState is an admissible class under the theorem projection. -/
instance : HautevilleHouse.CanonicalLaneMathlibCore.AdmissibleClass HydrodynamicState where
  projection := theoremProjection

end AbsoluteConvectiveInstabilityStabilityHydrodynamicTheoremCanonicalLaneLean
end HautevilleHouse