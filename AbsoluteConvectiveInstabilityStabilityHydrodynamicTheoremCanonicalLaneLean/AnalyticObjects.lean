import Mathlib.Data.Real.Basic
import Mathlib.Data.Complex.Basic
import Mathlib.Tactic.Linarith

/-!
# Absolute and Convective Instability Analytic Objects

This module provides a local analytic vocabulary for the hydrodynamic
stability theorem lane: wave numbers, complex frequencies, dispersion
relations, growth rates, and the bridge definitions that separate stable,
convectively unstable, and absolutely unstable regimes.
-/

namespace HautevilleHouse
namespace AbsoluteConvectiveInstabilityStabilityHydrodynamicTheoremCanonicalLaneLean

abbrev WaveNumber := ℂ
abbrev Frequency := ℂ

/-- A normal mode is a spatial wavenumber paired with a complex frequency. -/
structure Mode where
  waveNumber : WaveNumber
  frequency : Frequency

/-- A hydrodynamic system is specified by its dispersion relation and a
notion of group velocity. This is the minimal analytic object on which
absolute versus convective instability is defined. -/
structure HydrodynamicSystem where
  dispersion : WaveNumber → Frequency → Prop
  groupVelocity : WaveNumber → Frequency → ℂ

/-- A mode is admissible for a system if it satisfies the dispersion relation. -/
def IsMode (H : HydrodynamicSystem) (m : Mode) : Prop :=
  H.dispersion m.waveNumber m.frequency

/-- The temporal growth rate is the imaginary part of the complex frequency. -/
def GrowthRate (ω : Frequency) : ℝ := ω.im

/-- An unstable mode has positive growth rate. -/
def IsUnstableMode (H : HydrodynamicSystem) (m : Mode) : Prop :=
  IsMode H m ∧ 0 < GrowthRate m.frequency

/-- A mode is absolutely unstable when it is unstable and has zero group
velocity: the disturbance grows in place. -/
def IsAbsolutelyUnstableMode (H : HydrodynamicSystem) (m : Mode) : Prop :=
  IsUnstableMode H m ∧ H.groupVelocity m.waveNumber m.frequency = 0

/-- A mode is convectively unstable when it is unstable and has nonzero
group velocity: the disturbance grows while being swept away. -/
def IsConvectivelyUnstableMode (H : HydrodynamicSystem) (m : Mode) : Prop :=
  IsUnstableMode H m ∧ H.groupVelocity m.waveNumber m.frequency ≠ 0

/-- The system exhibits absolute instability if some admissible mode is
absolutely unstable. -/
def IsAbsolutelyUnstable (H : HydrodynamicSystem) : Prop :=
  ∃ m : Mode, IsAbsolutelyUnstableMode H m

/-- The system exhibits convective instability if some admissible mode is
convectively unstable. -/
def IsConvectivelyUnstable (H : HydrodynamicSystem) : Prop :=
  ∃ m : Mode, IsConvectivelyUnstableMode H m

/-- The system is unstable if some admissible mode has positive growth rate. -/
def IsUnstable (H : HydrodynamicSystem) : Prop :=
  ∃ m : Mode, IsUnstableMode H m

/-- The system is stable if every admissible mode decays. -/
def IsStable (H : HydrodynamicSystem) : Prop :=
  ∀ m : Mode, IsMode H m → GrowthRate m.frequency < 0

-- Bridge statements connecting the stability classes

theorem absolutely_unstable_implies_unstable (H : HydrodynamicSystem) :
    IsAbsolutelyUnstable H → IsUnstable H := by
  intro h
  rcases h with ⟨m, hAbs⟩
  rcases hAbs with ⟨hUnst, hg⟩
  exact ⟨m, hUnst⟩

theorem convectively_unstable_implies_unstable (H : HydrodynamicSystem) :
    IsConvectivelyUnstable H → IsUnstable H := by
  intro h
  rcases h with ⟨m, hConv⟩
  rcases hConv with ⟨hUnst, hg⟩
  exact ⟨m, hUnst⟩

theorem unstable_iff_abs_or_conv (H : HydrodynamicSystem) :
    IsUnstable H ↔ IsAbsolutelyUnstable H ∨ IsConvectivelyUnstable H := by
  constructor
  · intro hunst
    rcases hunst with ⟨m, hUnst⟩
    rcases hUnst with ⟨hIsMode, hgt⟩
    by_cases hg : H.groupVelocity m.waveNumber m.frequency = 0
    · left
      exact ⟨m, ⟨⟨hIsMode, hgt⟩, hg⟩⟩
    · right
      exact ⟨m, ⟨⟨hIsMode, hgt⟩, hg⟩⟩
  · intro h
    rcases h with h | h
    · exact absolutely_unstable_implies_unstable H h
    · exact convectively_unstable_implies_unstable H h

theorem stable_not_unstable (H : HydrodynamicSystem) :
    IsStable H → ¬ IsUnstable H := by
  intro hstable hunst
  rcases hunst with ⟨m, hUnst⟩
  rcases hUnst with ⟨hIsMode, hgt⟩
  have hlt : GrowthRate m.frequency < 0 := hstable m hIsMode
  linarith

theorem stable_not_absolutely_unstable (H : HydrodynamicSystem) :
    IsStable H → ¬ IsAbsolutelyUnstable H := by
  intro hstable habs
  exact stable_not_unstable H hstable (absolutely_unstable_implies_unstable H habs)

theorem stable_not_convectively_unstable (H : HydrodynamicSystem) :
    IsStable H → ¬ IsConvectivelyUnstable H := by
  intro hstable hconv
  exact stable_not_unstable H hstable (convectively_unstable_implies_unstable H hconv)

-- Canonical system for analytic checks

def canonicalSystem : HydrodynamicSystem where
  dispersion := fun k ω => k = 0 ∧ ω = Complex.I
  groupVelocity := fun k ω => 0

def canonicalMode : Mode where
  waveNumber := 0
  frequency := Complex.I

theorem canonical_mode_is_mode :
    IsMode canonicalSystem canonicalMode := by
  unfold IsMode canonicalSystem canonicalMode
  simp

theorem canonical_mode_growth_positive :
    0 < GrowthRate canonicalMode.frequency := by
  unfold GrowthRate canonicalMode
  norm_num

theorem canonical_mode_group_velocity_zero :
    canonicalSystem.groupVelocity canonicalMode.waveNumber canonicalMode.frequency = 0 := by
  rfl

theorem canonical_mode_absolutely_unstable :
    IsAbsolutelyUnstableMode canonicalSystem canonicalMode := by
  constructor
  · constructor
    · exact canonical_mode_is_mode
    · exact canonical_mode_growth_positive
  · exact canonical_mode_group_velocity_zero

theorem canonical_system_absolutely_unstable :
    IsAbsolutelyUnstable canonicalSystem := by
  exact ⟨canonicalMode, canonical_mode_absolutely_unstable⟩

theorem canonical_system_unstable :
    IsUnstable canonicalSystem :=
  absolutely_unstable_implies_unstable canonicalSystem canonical_system_absolutely_unstable

-- An additional stable system example

def stableSystem : HydrodynamicSystem where
  dispersion := fun k ω => ω = -Complex.I
  groupVelocity := fun k ω => 1

theorem stable_system_is_stable :
    IsStable stableSystem := by
  intro m hm
  unfold IsMode stableSystem at hm
  rw [hm]
  unfold GrowthRate
  norm_num

end AbsoluteConvectiveInstabilityStabilityHydrodynamicTheoremCanonicalLaneLean
end HautevilleHouse