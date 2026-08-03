import AbsoluteConvectiveInstabilityStabilityHydrodynamicTheoremCanonicalLaneLean.SourcePackage

/-!
# Source dependency model for `absolute-convective-instability-stability-hydrodynamic-theorem-canonical-lane`

This module records the import and data-route surface used by the source
package/scripts before translation into Lean data.

It makes the source runtime dependency boundary explicit. The dependency boundary is internal to the Lean package as structural data.
It also bridges the dependency surface to the admissible-class decomposition of
absolute versus convective instability in hydrodynamic stability theory.
-/

namespace HautevilleHouse
namespace AbsoluteConvectiveInstabilityStabilityHydrodynamicTheoremCanonicalLaneLean

/-- The admissible classification of a hydrodynamic instability. -/
inductive InstabilityKind where
  | absolute
  | convective
deriving Repr, DecidableEq

/-- A bridge record linking a source artifact to one side of the absolute/convective distinction. -/
structure StabilityBridge where
  artifact : String
  kind : InstabilityKind
  role : String
  admissible : Bool
deriving Repr, DecidableEq

structure SourceImportDependency where
  file : String
  kind : String
  module : String
  name : String
  alias : String
  level : Nat
deriving Repr, DecidableEq

structure SourcePathDependency where
  file : String
  name : String
  path : String
  role : String
  line : Nat
deriving Repr, DecidableEq

def sourceImportDependencies : List SourceImportDependency := [
  { file := "scripts/extract_theorem.py", kind := "from_import", module := "__future__", name := "annotations", alias := "", level := 0 },
  { file := "scripts/extract_theorem.py", kind := "import", module := "argparse", name := "", alias := "", level := 0 },
  { file := "scripts/extract_theorem.py", kind := "import", module := "datetime", name := "", alias := "dt", level := 0 },
  { file := "scripts/extract_theorem.py", kind := "import", module := "json", name := "", alias := "", level := 0 },
  { file := "scripts/extract_theorem.py", kind := "import", module := "math", name := "", alias := "", level := 0 },
  { file := "scripts/extract_theorem.py", kind := "from_import", module := "pathlib", name := "Path", alias := "", level := 0 },
  { file := "scripts/extract_theorem.py", kind := "from_import", module := "typing", name := "Any", alias := "", level := 0 },
  { file := "scripts/extract_theorem.py", kind := "import", module := "numpy", name := "", alias := "np", level := 0 },
  { file := "scripts/extract_theorem.py", kind := "from_import", module := "scipy", name := "linalg", alias := "spl", level := 0 },
  { file := "scripts/abs_conv_guard.py", kind := "from_import", module := "__future__", name := "annotations", alias := "", level := 0 },
  { file := "scripts/abs_conv_guard.py", kind := "import", module := "argparse", name := "", alias := "", level := 0 },
  { file := "scripts/abs_conv_guard.py", kind := "import", module := "datetime", name := "", alias := "dt", level := 0 },
  { file := "scripts/abs_conv_guard.py", kind := "import", module := "json", name := "", alias := "", level := 0 },
  { file := "scripts/abs_conv_guard.py", kind := "import", module := "math", name := "", alias := "", level := 0 },
  { file := "scripts/abs_conv_guard.py", kind := "from_import", module := "pathlib", name := "Path", alias := "", level := 0 },
  { file := "scripts/abs_conv_guard.py", kind := "from_import", module := "typing", name := "Any", alias := "", level := 0 },
  { file := "scripts/promote_stability.py", kind := "from_import", module := "__future__", name := "annotations", alias := "", level := 0 },
  { file := "scripts/promote_stability.py", kind := "import", module := "argparse", name := "", alias := "", level := 0 },
  { file := "scripts/promote_stability.py", kind := "import", module := "datetime", name := "", alias := "dt", level := 0 },
  { file := "scripts/promote_stability.py", kind := "import", module := "json", name := "", alias := "", level := 0 },
  { file := "scripts/promote_stability.py", kind := "import", module := "math", name := "", alias := "", level := 0 },
  { file := "scripts/promote_stability.py", kind := "from_import", module := "pathlib", name := "Path", alias := "", level := 0 },
  { file := "scripts/promote_stability.py", kind := "from_import", module := "typing", name := "Any", alias := "", level := 0 },
  { file := "scripts/release_gate.py", kind := "from_import", module := "__future__", name := "annotations", alias := "", level := 0 },
  { file := "scripts/release_gate.py", kind := "import", module := "argparse", name := "", alias := "", level := 0 },
  { file := "scripts/release_gate.py", kind := "import", module := "datetime", name := "", alias := "dt", level := 0 },
  { file := "scripts/release_gate.py", kind := "import", module := "hashlib", name := "", alias := "", level := 0 },
  { file := "scripts/release_gate.py", kind := "import", module := "json", name := "", alias := "", level := 0 },
  { file := "scripts/release_gate.py", kind := "import", module := "math", name := "", alias := "", level := 0 },
  { file := "scripts/release_gate.py", kind := "from_import", module := "pathlib", name := "Path", alias := "", level := 0 },
  { file := "scripts/release_gate.py", kind := "from_import", module := "typing", name := "Any", alias := "", level := 0 },
  { file := "scripts/update_manifest.py", kind := "from_import", module := "__future__", name := "annotations", alias := "", level := 0 },
  { file := "scripts/update_manifest.py", kind := "import", module := "argparse", name := "", alias := "", level := 0 },
  { file := "scripts/update_manifest.py", kind := "import", module := "datetime", name := "", alias := "dt", level := 0 },
  { file := "scripts/update_manifest.py", kind := "import", module := "hashlib", name := "", alias := "", level := 0 },
  { file := "scripts/update_manifest.py", kind := "import", module := "json", name := "", alias := "", level := 0 },
  { file := "scripts/update_manifest.py", kind := "import", module := "math", name := "", alias := "", level := 0 },
  { file := "scripts/update_manifest.py", kind := "from_import", module := "pathlib", name := "Path", alias := "", level := 0 },
  { file := "scripts/update_manifest.py", kind := "from_import", module := "typing", name := "Any", alias := "", level := 0 }
]

def sourcePathDependencies : List SourcePathDependency := [
  { file := "scripts/extract_theorem.py", name := "theorem_parameters", path := "etc/theorem_parameters.json", role := "input_config", line := 41 },
  { file := "scripts/abs_conv_guard.py", name := "abs_conv_classifier", path := "src/admissible_class.py", role := "classification_guard", line := 87 },
  { file := "scripts/promote_stability.py", name := "stability_bridge", path := "bridge/abs_conv_bridge.json", role := "bridge_output", line := 28 },
  { file := "scripts/release_gate.py", name := "release_cert", path := "cert/release.sig", role := "release_signature", line := 64 },
  { file := "scripts/update_manifest.py", name := "manifest", path := "manifest.json", role := "manifest", line := 15 }
]

/-- The admissible bridge list for the absolute/convective theorem. -/
def stabilityBridges : List StabilityBridge := [
  { artifact := "scripts/abs_conv_guard.py", kind := .absolute, role := "residue_check", admissible := true },
  { artifact := "scripts/abs_conv_guard.py", kind := .convective, role := "group_velocity_check", admissible := true },
  { artifact := "scripts/promote_stability.py", kind := .absolute, role := "spectral_certify", admissible := true },
  { artifact := "scripts/promote_stability.py", kind := .convective, role := "spectral_certify", admissible := false }
]

/-- Every admissible bridge in the dependency set references a real script artifact. -/
theorem admissibleBridge_has_artifact :
  ∀ b ∈ stabilityBridges, b.admissible → b.artifact ≠ "" := by
  decide

end AbsoluteConvectiveInstabilityStabilityHydrodynamicTheoremCanonicalLaneLean
end HautevilleHouse