# THE LAST KLADRUBER — No. 001 · Created for Bart

**A two-shadow, one-object 3D-printable optical sculpture.** When a bright *small-source* light strikes the sculpture from the **Y direction**, its shadow resembles a high-stepping Kladruber horse. Turn the sculpture or move the light **90 degrees** to illuminate from the **X direction**, and the same object casts a silhouette of a horse pulling a royal carriage.

This is an original artistic interpretation of the Old Kladruber breed and its history, not a reproduction of a specific animal or a historical carriage.

## Build versions (all preserved)

| Version | File | Size approx. | Purpose |
|---|---|---:|---|
| V01 | `versions/v01/kladruber_flat_test.stl` | 139 × 13 × 87 mm | Single-shadow horse silhouette, quick proof of design |
| V02 | `versions/v02/dual_shadow.stl` | 119 × 120 × 70 mm | Smaller **dual-shadow** calibration prototype — **print first** |
| V03 | `versions/v03/dual_shadow.stl` | 197 × 197 × 112 mm | Full-scale dual-shadow original with integral square stage |
| V03 | `versions/v03/nameplate.stl` | 159 × 32 × 4 mm | Standalone engraved dedication plaque |

**STLs contain actual printable meshes, not empty placeholders.** The mathematically generated meshes were checked with `trimesh`: each is watertight, positive volume, and a single connected mesh. The curved surface is derived from a voxel/isosurface process, so edges have a gentle voxel-rounded appearance rather than perfectly smooth vector curves.

## What was tested, and what wasn't

- ✅ Two **orthographic** projections were computed against the original drawing masks. V03 covers about **99.23%** of horse pixels and **100%** of carriage pixels within the drawing grid. Separate images of *the computed shadows* are in `previews/`.
- ✅ STL files validated for connectedness, water-tightness, and printer-bed bounding box.
- ✅ A separate engraved nameplate STL was rendered and tested.
- ⚠️ The exact 3D objects have **not been printed or physically light-tested**. Real LEDs are divergent light sources, so shadows may differ from the parallel-ray simulations. Light distance and precision matter.
- ⚠️ This model has large overhangs and some unsupported passages. Slicer supports are required. Mesh validity does **not** guarantee an easy print.

## Recommended first physical test — Bambu P2S

1. Load `versions/v02/dual_shadow.stl` into Bambu Studio, **keep flat base downward**. Do not tilt: the printed footprint is the intended stage.
2. Try a 0.4 mm nozzle, PLA, 0.20–0.24 mm layer height, 3 walls, 8–12% gyroid infill, tree/organic supports with appropriate contact clearance, and a 5–8 mm brim. Review underside and support access in the slicer's layer preview **before printing**.
3. Print V02 in **matte black PLA**. A lighter filament may allow light through the walls and weaken the shadow.
4. Place a **small, bright LED source** approximately **1–2 m from the center of the sculpture**, with a white wall/paper/screen on the opposite side. Switch off room lights. A focused small source creates crisper edges than a big flashlight diffuser.
5. Aim horizontally along the **Y axis** for the horse; rotate the sculpture 90 degrees for the **carriage**. Adjust height so the lamp is level with the mid-height of the sculpture.
6. If both views look right, graduate to V03. Print the engraved plaque separately. A contrasting paint fill makes the recessed lettering easier to read.

### Full-size print notes

V03 is **196.65 × 196.65 × 111.55 mm**: inside the Bambu P2S's 256 mm nominal XY bed size, leaving generous clearance. Its bounding-box footprint fits; **slicer supports and brim must also fit**. The model encloses substantial material (about 1.05 liters at 100% solid fill), so expect a long print with supports. Use sparse infill, and check the actual gram estimate in Bambu Studio before committing.

Do not use an incandescent bulb against PLA, or place a hot lamp directly next to it. Keep the LED lighting cool. PC-GF is unnecessary for this room-temperature decoration and would make the print more demanding.

## Reproduce every version

`python -m pip install numpy pillow cairosvg scipy scikit-image trimesh matplotlib`

`python build.py`

The builder regenerates all STLs, two-axis digital-shadow images, and `validation_summary.json` from the **original source SVGs** in `assets/`. It runs on Python 3.10+ on most machines with Cairo available. OpenSCAD source for the nameplate is in `versions/v03/nameplate.scad` (OpenSCAD and its fonts are required to rebuild that nameplate STL). An alternate raw Boolean intersection method is preserved as `versions/v02/dual_shadow.scad`; it was rejected as the print master because it produced a non-manifold mesh.

## Versions and lessons learned

- **V01**: Confirmed horse silhouette scale and single-axis shadow.
- **V02 / first CAD approach**: Intersecting two SVG extrusions in OpenSCAD generated disconnected/non-manifold fragments. Kept `.scad` as the failed experiment for transparency.
- **V02 / repaired**: Connected voxel reconstruction with an integral stage yielded a verified watertight prototype.
- **V03**: Higher-resolution final-scale reconstruction and engraved dedication plate.

### GitHub build automation

`.github/workflows/last-kladruber-build.yml` regenerates the binary STL meshes on pushes affecting the project and attempts to commit them back to the project folder. Until a workflow completes successfully, source files in GitHub are sufficient to regenerate the meshes locally; the ZIP attached in the ChatGPT conversation contains the already-generated binaries.

### Gift inscription

**THE LAST KLADRUBER**  
**No. 001 | CREATED FOR BART**  
*Some things can only be seen in the right light.*

Created 19 October 2026.
