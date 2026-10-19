# 3D-print release checklist
## A. Visual / reference gate
- [ ] Is the model visually recognizable and attractive, not merely mathematically valid?
- [ ] Does it match the user's reference/geometry from all important angles?
- [ ] Are inscriptions spelled correctly, oriented correctly and sized to print?
- [ ] Are close-up and scale-comparison renders available?
- [ ] Has Brad approved the appearance (or explicitly waived approval for a quick utility part)?

## B. Geometry / functional gate
- [ ] Model has correct units (mm), scale and physical dimensions.
- [ ] Fits Bambu P2S build volume *in intended orientation* **including supports/brim**.
- [ ] Mesh QA passed: watertight, consistent winding, positive volume, intended number of components.
- [ ] Walls, embossed features, threads and holes make sense for chosen nozzle/material.
- [ ] Assemblies have stated fit/tolerance, fastening method and load path.
- [ ] Functional areas have stress rounding; movable parts are not fused.
- [ ] Any simulated light, movement or mechanical function visually matches intended result.
- [ ] Chemical, heat, fuel, food-contact, child and safety risks reviewed where relevant.

## C. Printing / physical gate
- [ ] Opened STL/3MF in Bambu Studio and actually inspected slice layers.
- [ ] Identified support placement and **how supports can be removed without breaking details**.
- [ ] Material, nozzle, walls, infill, layer height and orientation chosen.
- [ ] Slicer-reported filament mass and print time recorded, if available.
- [ ] Test coupon or prototype printed and fit/shadow tested where needed.
- [ ] If no physical test was done, this is marked **NOT PHYSICALLY TESTED**.

## D. Release and GitHub gate
- [ ] All versions preserved including what failed and why.
- [ ] Editable source, STL(s), previews, dimensions, validation report and README included.
- [ ] `STATUS.md` lists verified status honestly; only fully checked models say `PRINT READY`.
- [ ] Files are confirmed on GitHub (if upload requested); direct repo link supplied.
- [ ] Recommended print file and version are explicitly identified.

### Status meanings
- **ART APPROVAL:** concept illustration; not a printable promise.
- **EXPERIMENT:** useful exploration; may be structurally or visually incorrect.
- **PROTOTYPE:** digital geometry exists; more checks/physical trials needed.
- **PRINT READY:** passes review and intended slice checks; actual physical test status must still be declared.
- **FAILED - RETAINED:** preserved for lessons; DO NOT PRINT without correction.

**Lesson from Kladruber:** a beautiful, accurate shadow—not just a watertight mesh—is the real success criterion.
