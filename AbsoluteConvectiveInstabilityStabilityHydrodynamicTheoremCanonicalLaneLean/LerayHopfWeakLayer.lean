/-!
# Leray-Hopf Weak Layer for Absolute Convective Instability Stability

This module records the admissible-class bridge for the hydrodynamic
stability classification: absolute instability, convective instability,
and stability. The structure `InstabilityStabilityEnvelope` packages a
hydrodynamic state with a certified classification and proof-carrying
bridge statements connecting the classes.
-/

namespace HautevilleHouse
namespace AbsoluteConvectiveInstabilityStabilityHydrodynamicTheoremCanonicalLaneLean

/-- The three hydrodynamic instability/stability classes. -/
inductive InstabilityClass where
  | absolutely_unstable
  | convectively_unstable
  | stable

/-- A hydrodynamic state: base flow plus perturbation, with an associated class. -/
structure HydrodynamicState where
  baseFlow : Type
  perturbation : Type
  classification : InstabilityClass

/-- Predicate: the class is absolute instability. -/
def IsAbsolute (c : InstabilityClass) : Prop := c = InstabilityClass.absolutely_unstable

/-- Predicate: the class is convective instability. -/
def IsConvective (c : InstabilityClass) : Prop := c = InstabilityClass.convectively_unstable

/-- Predicate: the class is stable. -/
def IsStable (c : InstabilityClass) : Prop := c = InstabilityClass.stable

/-- Absolute instability is mutually exclusive with convective instability. -/
lemma absolute_not_convective {c : InstabilityClass} (h : IsAbsolute c) : ¬ IsConvective c := by
  intro hc
  cases c with
  | absolutely_unstable =>
      simp [IsAbsolute, IsConvective] at h hc
      contradiction
  | convectively_unstable =>
      simp [IsAbsolute, IsConvective] at h hc
      contradiction
  | stable =>
      simp [IsAbsolute, IsConvective] at h hc
      contradiction

/-- Absolute instability is incompatible with stability. -/
lemma absolute_not_stable {c : InstabilityClass} (h : IsAbsolute c) : ¬ IsStable c := by
  intro hs
  cases c with
  | absolutely_unstable =>
      simp [IsAbsolute, IsStable] at h hs
      contradiction
  | convectively_unstable =>
      simp [IsAbsolute, IsStable] at h hs
      contradiction
  | stable =>
      simp [IsAbsolute, IsStable] at h hs
      contradiction

/-- Convective instability is incompatible with stability. -/
lemma convective_not_stable {c : InstabilityClass} (h : IsConvective c) : ¬ IsStable c := by
  intro hs
  cases c with
  | absolutely_unstable =>
      simp [IsConvective, IsStable] at h hs
      contradiction
  | convectively_unstable =>
      simp [IsConvective, IsStable] at h hs
      contradiction
  | stable =>
      simp [IsConvective, IsStable] at h hs
      contradiction

/-- Stability excludes absolute instability. -/
lemma stable_not_absolute {c : InstabilityClass} (h : IsStable c) : ¬ IsAbsolute c := by
  intro ha
  cases c with
  | absolutely_unstable =>
      simp [IsStable, IsAbsolute] at h ha
      contradiction
  | convectively_unstable =>
      simp [IsStable, IsAbsolute] at h ha
      contradiction
  | stable =>
      simp [IsStable, IsAbsolute] at h ha
      contradiction

/-- Stability excludes convective instability. -/
lemma stable_not_convective {c : InstabilityClass} (h : IsStable c) : ¬ IsConvective c := by
  intro hc
  cases c with
  | absolutely_unstable =>
      simp [IsStable, IsConvective] at h hc
      contradiction
  | convectively_unstable =>
      simp [IsStable, IsConvective] at h hc
      contradiction
  | stable =>
      simp [IsStable, IsConvective] at h hc
      contradiction

/-- The trichotomy of hydrodynamic instability/stability. -/
lemma instability_stability_trichotomy (c : InstabilityClass) :
    IsAbsolute c ∨ IsConvective c ∨ IsStable c := by
  cases c <;> simp [IsAbsolute, IsConvective, IsStable]

/-- The primitive base flow used for the canonical source certificate. -/
def primitiveBaseFlow : Type := Unit

/-- The primitive perturbation used for the canonical source certificate. -/
def primitivePerturbation : Type := Unit

/-- The primitive hydrodynamic state: certified as absolutely unstable. -/
def primitiveState : HydrodynamicState := {
  baseFlow := primitiveBaseFlow
  perturbation := primitivePerturbation
  classification := InstabilityClass.absolutely_unstable
}

/-- Envelope that packages a hydrodynamic state with its certified class. -/
structure InstabilityStabilityEnvelope where
  state : HydrodynamicState
  certifiedClass : InstabilityClass
  certifiedClass_eq : state.classification = certifiedClass

/-- The source certificate envelope: the primitive state with its own class. -/
def sourceInstabilityStabilityEnvelope : InstabilityStabilityEnvelope := {
  state := primitiveState
  certifiedClass := primitiveState.classification
  certifiedClass_eq := rfl
}

/-- The admissible-class bridge: mutual exclusion and trichotomy. -/
def InstabilityStabilityBridge (E : InstabilityStabilityEnvelope) : Prop :=
  (IsAbsolute E.certifiedClass → ¬ IsStable E.certifiedClass) ∧
  (IsConvective E.certifiedClass → ¬ IsStable E.certifiedClass) ∧
  (IsAbsolute E.certifiedClass → ¬ IsConvective E.certifiedClass) ∧
  (IsStable E.certifiedClass → ¬ IsAbsolute E.certifiedClass) ∧
  (IsStable E.certifiedClass → ¬ IsConvective E.certifiedClass)

/-- The source envelope satisfies the admissible-class bridge. -/
theorem source_instability_stability_bridge :
    InstabilityStabilityBridge sourceInstabilityStabilityEnvelope := by
  unfold InstabilityStabilityBridge sourceInstabilityStabilityEnvelope
  constructor
  · exact absolute_not_stable
  · constructor
    · exact convective_not_stable
    · constructor
      · exact absolute_not_convective
      · constructor
        · exact stable_not_absolute
        · exact stable_not_convective

/-- Hydrodynamic bridge trichotomy: every certified class is in one of the three. -/
theorem hydrodynamic_bridge_trichotomy (E : InstabilityStabilityEnvelope) :
    IsAbsolute E.certifiedClass ∨ IsConvective E.certifiedClass ∨ IsStable E.certifiedClass := by
  exact instability_stability_trichotomy E.certifiedClass

/-- The envelope is closed if it satisfies the bridge and the trichotomy. -/
def InstabilityStabilityEnvelopeClosed (E : InstabilityStabilityEnvelope) : Prop :=
  InstabilityStabilityBridge E ∧
  (IsAbsolute E.certifiedClass ∨ IsConvective E.certifiedClass ∨ IsStable E.certifiedClass)

/-- The source envelope is closed under the full bridge certificate. -/
theorem source_instability_stability_envelope_closed :
    InstabilityStabilityEnvelopeClosed sourceInstabilityStabilityEnvelope := by
  constructor
  · exact source_instability_stability_bridge
  · exact hydrodynamic_bridge_trichotomy sourceInstabilityStabilityEnvelope

end AbsoluteConvectiveInstabilityStabilityHydrodynamicTheoremCanonicalLaneLean
end HautevilleHouse