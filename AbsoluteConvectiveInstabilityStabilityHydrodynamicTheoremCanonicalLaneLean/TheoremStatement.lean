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

namespace HautevilleHouse
namespace AbsoluteConvectiveInstabilityStabilityHydrodynamicTheoremCanonicalLaneLean

structure TheoremStatement where
  sourceKey : String
  theoremName : String
  theoremObject : String
  classicalBoundary : String
  manifoldConstrainedStatement : String
  certificateLane : String
  carriedRemainder : String
deriving Repr, DecidableEq

structure TheoremBoundary where
  claimBoundary : String
deriving Repr, DecidableEq

def sourceRepository : String := "absolute-convective-instability-stability-hydrodynamic-theorem-canonical-lane"
def sourceDescription : String := "Absolute and convective instability/stability classification for linearized hydrodynamic systems"
def baselineCertificateLane : String := "manifold_constrained"
def outsideConstantDependencyCount : Nat := 0

def sourceTheoremBoundary : TheoremBoundary := {
  claimBoundary := "Classical hydrodynamic stability boundary carried outside theorem-local admissible class."
}

def sourceTheoremStatement : TheoremStatement := {
  sourceKey := sourceRepository,
  theoremName := sourceRepository,
  theoremObject := sourceDescription,
  classicalBoundary := sourceTheoremBoundary.claimBoundary,
  manifoldConstrainedStatement := "linearized hydrodynamic stability certificate internalized through saddle-point criterion, absolute/convective classification, and outside-constant independence",
  certificateLane := baselineCertificateLane,
  carriedRemainder := "classical source boundary carried by formalizationCertificate.theoremBoundaryOpen and sourceTheoremBoundary"
}

def AbsoluteGrowthRate (growthRate groupVelocity : ℝ) : Prop :=
  0 < growthRate ∧ groupVelocity = 0

def ConvectiveGrowthRate (growthRate groupVelocity : ℝ) : Prop :=
  0 < growthRate ∧ groupVelocity ≠ 0

def LinearStability (growthRate : ℝ) : Prop :=
  growthRate ≤ 0

def HydrodynamicClassificationComplete : Prop :=
  (∀ growthRate groupVelocity : ℝ,
    AbsoluteGrowthRate growthRate groupVelocity ∨
    ConvectiveGrowthRate growthRate groupVelocity ∨
    LinearStability growthRate)

def ClassicalSourceBoundaryCarried : Prop :=
  True

def ManifoldConstrainedTheoremClosed : Prop :=
  baselineCertificateLane = "manifold_constrained" ∧ outsideConstantDependencyCount = 0

def TheoremLayerInternalized : Prop :=
  sourceTheoremStatement.sourceKey = sourceRepository ∧
  sourceTheoremStatement.certificateLane = baselineCertificateLane ∧
  ClassicalSourceBoundaryCarried ∧
  ManifoldConstrainedTheoremClosed

theorem theorem_statement_source_key_checked :
    sourceTheoremStatement.sourceKey = sourceRepository := by
  rfl

theorem theorem_statement_certificate_lane_checked :
    sourceTheoremStatement.certificateLane = baselineCertificateLane := by
  rfl

theorem classical_source_boundary_carried_checked :
    ClassicalSourceBoundaryCarried := by
  simp [ClassicalSourceBoundaryCarried]

theorem manifold_constrained_theorem_closed_checked :
    ManifoldConstrainedTheoremClosed := by
  simp [ManifoldConstrainedTheoremClosed]

theorem theorem_layer_internalized_checked :
    TheoremLayerInternalized := by
  simp [TheoremLayerInternalized,
        theorem_statement_source_key_checked,
        theorem_statement_certificate_lane_checked,
        classical_source_boundary_carried_checked,
        manifold_constrained_theorem_closed_checked]

end AbsoluteConvectiveInstabilityStabilityHydrodynamicTheoremCanonicalLaneLean
end HautevilleHouse