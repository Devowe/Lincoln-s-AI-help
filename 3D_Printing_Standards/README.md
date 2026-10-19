# Brad + Lincoln — 3D Print Design Standard
**Version 1.0 | Adopted 2026-10-19**

This is the default process for all future 3D-printing projects made together. It applies to detailed artwork, functional parts, models, miniatures, replacements, optical illusions, enclosures and mechanical assemblies. Use it as a reusable instruction/checklist, not a claim that a machine has run any particular test.

## The golden rule

**A watertight STL is NOT proof of a good design.** A project is *print-ready* only after visual quality, functional/engineering quality, and slicer/physical quality have been considered independently. An unattractive but technically valid mesh stays a prototype.

## Stages and gates

| Step | Deliverable | Passing evidence | Stop condition |
|---|---|---|---|
| 01 Brief | Dimensions, purpose, references, printer/material/nozzle, risks, success criteria | Written specification; unknowns explicitly listed | Missing critical fit or material information |
| 02 Art first | 2–3 orthographic view(s), closeups or photorealistic preview where useful | **User approves the look**; for simple utilitarian revisions approval may be waived explicitly | Looks wrong, is mis-proportioned, or doesn't match reference |
| 03 Engineering | Parameterized CAD/mesh with fit allowances, assembly and printing orientation | Model dimensions, clearance, structural and serviceability checks | Physically impossible, unprintable features, critical functional gaps |
| 04 Simulate | Orthographic/silhouette tests, realistic light render for shadow art, movement/interference tests for moving parts, scale reference | Compare to approved artistic goal, not just pixel overlap | Projection/fit/motion not convincing |
| 05 Validate | Mesh QA report, slicing/overhang review, print orientation, wall/nozzle guidance, support plan | Machine checks **plus human review** of Bambu Studio slice screenshots | Bad edges, mesh errors, inaccessible supports, excessive weak features |
| 06 Prototype | Small fit/optical test or critical-part test where uncertainty remains | Photos + measured notes; revise as needed | Physical failure unresolved |
| 07 Release | STL/3MF, editable source, preview, verification results, assembly/print notes, CHANGELOG | Status tagged **PRINT READY** only for checked version | Anything is unverified but labeled final |

**Never claim a print was physically tested unless it actually was.** Digital watertightness, nominal XY fit, shadow projection and appearance are *different* tests.

## Version policy — every version preserved

- Folder: `3D_Projects/PROJECT_SLUG/versions/v01/`, `v02/`, etc. Use ISO dated notes where relevant.
- Preserve *all* prior STLs, native/editable source, renders and test reports, including experiments that failed. Explain failure and improvement in `CHANGELOG.md`.
- No silent overwrites. For a corrected geometry, make `vNN+1`; keep previous versions untouched.
- Each version should have `STATUS.md` showing one of: `IDEA`, `ART APPROVAL`, `EXPERIMENT`, `PROTOTYPE`, `PRINT READY`, `FAILED - RETAINED`.
- The most recent is **not automatically the best**. A downloadable file is **not automatically print-ready**.
- Link each version's STL, preview and constraints in the project's top-level `README.md`.
- A GitHub push is required when requested by Brad; do not represent a file as uploaded unless the repository confirms it exists.

## Machine and design defaults (always confirm for a new build)

- Primary printer: **Bambu P2S**; available nozzles: **0.2 mm, 0.4 mm HF, 0.6 mm**. Do not presume a particular nozzle installed.
- Use the 0.4 mm nozzle as a default for ordinary parts; 0.2 mm for fine features where time/strength allow; 0.6 mm for thick, robust parts.
- Filament: PLA unless conditions warrant PETG/ABS/PC-GF or others; choose by service temperature, fuel/chemical compatibility, UV exposure, strength, and food/contact safety.
- Match real measurements and mounting hardware. State dimensional tolerance and the *purpose* of clearance (moving fit, friction fit, press fit, snap).
- For HO scale: verify scale is **1:87.1** (or explicitly state 1:87 nominal), show dimensions and a comparison reference.
- Functional prints should have fillets at stressed roots, minimum walls compatible with nozzle, support-removal access, and sensible print orientation.
- Distinguish measured dimensions from inferred/estimated dimensions.
- Slicer decides real print time, support amount and grams; do not infer them from solid STL volume alone.
- Fuel, heat, pressure, automotive safety and food-contact applications require separate material risk checks; never assume a printable polymer is safe for service.

## Specialty gate: shadow sculptures (learned from The Last Kladruber v01–v03)

1. Draw genuinely detailed, anatomically convincing silhouettes and show them at full resolution **before** building volume.
2. Render shadow views from intended real lamp position, including finite-size source/distance; orthographic masks are only the mathematical baseline.
3. Add a scene with the actual sculpture and screen: verify visual aesthetics at *both* angles.
4. Check structural interconnections, overhangs, print support removal and thickness of fine details.
5. Present projected shadows with images side-by-side and ask whether they are genuinely gift-quality.
6. Do not release as `PRINT READY` without the visual check and (when needed) a physical light-and-shadow prototype.

## Where to find the working documents

- [PROJECT_TEMPLATE.md](./PROJECT_TEMPLATE.md): copy into a new project.
- [RELEASE_CHECKLIST.md](./RELEASE_CHECKLIST.md): mandatory release review.
- [../scripts/3d_mesh_qa.py](../scripts/3d_mesh_qa.py): actual STL automated validation.
- [The Last Kladruber versions](../The_Last_Kladruber/): original experiment and failure lessons.

**Default operating behavior:** Create viewable previews early; don't start a large expensive print design without a visual checkpoint. For routine measured replacement parts, use a dimension/fit checkpoint instead. Ship the editable source, test data and clear limitations along with the STL.
