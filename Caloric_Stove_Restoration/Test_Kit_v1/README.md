# Vintage Caloric stove — photo-based 3D print test kit V1

This is an **unverified photo-based fitting kit** for a vintage Caloric gas range, provisionally identified as model 3615 UK or 3618 UK. It is not a dimensionally verified OEM replacement kit.

The linked original downloadable test ZIP was created on October 25, 2026. The repository rebuild renders the same 12 individual procedural test part variants, plus a combined first-print layout, directly from the editable OpenSCAD source.

## Print first
Load `STL/00_PRINT_FIRST_GAUGES_AND_3_PROFILES_256mm_BED.stl` into Bambu Studio. It contains small, medium and large handle-end outline candidates, sleeve-hole gauges, chrome handle width gauges and keyhole bulb test plugs, arranged on a 256 × 256 mm plate. All loose parts, not an assembly.

Suggested dry-fit-only printing: Bambu P2S, 0.4 mm nozzle, 0.20 mm layer height, PLA, three walls, 15% infill, no supports. Do not auto-scale.

## Files
- `00` — combined first-print plate
- `01` / `02` / `03` — three size profiles: 85×41, 95×46, 105×51 mm
- `04` — 95×46 flat ivory test plate, 18 mm hole
- `05` / `06` — two ivory raised-edge cosmetic shell mockups, 18 mm and 20 mm openings
- `07` — metal sleeve outer diameter holes, 14–22 mm
- `08` — chrome handle width U slots, 18–30 mm
- `09` — four decorative washer blank tests
- `10` — keyhole round opening measurement plugs, 7–13 mm
- `11` — 100 mm *appearance-only* backsplash trim sample, **not a vent cover**
- `12` — round gas-valve shaft sizing gauge, **not an operating knob**

## Create / adjust the STLs
Open `SOURCE/Caloric_handle_fit_kit.scad` in OpenSCAD. Adjust `L`, `W`, `CENTER_HOLE`, `RIM` and `LIP_HEIGHT` based on measurements of the original component.

On Linux with OpenSCAD installed, run `bash render_all.sh`. The GitHub Actions build also generates and commits the STLs and a ZIP to this repository.

## Safety and limitations
**These are non-load-bearing, non-functional fitting models only.** Do not mount plastic prototype parts on a working or hot stove, replace structural oven-door handle clips with plastic, create burner or gas-path parts, alter valves, or cover a stove vent. Try them only when the stove is disconnected, off and completely cold. The original handle relies on metal clips / fasteners that must remain metallic and properly rated. All dimensions here are **estimates based on photographs**, not measurements. A gas appliance technician should inspect the restored range before operation.

To finalize any replacement, measure the original ivory insert's length, width and height, boss outside diameter, distance from upper tip to screw center, metal handle width and mounting hole center distance; photographs of both sides with a ruler are also helpful.
