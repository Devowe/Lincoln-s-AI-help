# The Last Kladruber V04 — optical test rig

**Status: ENGINEERING PROTOTYPE. Digitally mesh-checked, NOT PHYSICALLY PRINTED OR LIGHT-TESTED.**

The approved black-and-gold display artwork is a *concept*. Its pictured backlit silhouette panels would be straightforward to create as printed artwork, but they are **not** evidence that the sculpture casts both detailed shadows. This optical rig tests the original one-object/two-real-shadows promise before we make the 320 mm luxury enclosure.

## Parts (all the STLs are generated automatically from OpenSCAD)
| File | Qty | Function |
|---|---:|---|
| `base.stl` | 1 | 200 x 200 mm base plate, X/Y plug sockets |
| `screen_frame.stl` | 2 | 108 x 99 mm opaque mounting frame; tape tracing paper to backside |
| `led_holder.stl` | 2 | Nominal 5.4 mm LED module alignment fixture |
| `stage.stl` | 1 | 58 mm diameter x 28 mm pedestal |
| `pinhole_cap.stl` | 0–2 | Optional 1.4 mm pinhole experiment |
| `reused_v03_shadow_caster_scale28pct.stl` | 1 | Scaled old dual-shadow test volume; **not final art** |
| `v04_optical_bench.scad` | — | Editable parametric source |

## Geometry and physics

- Projector LED X at **(-82,0)** shines toward screen X at **(+82,0)**.
- Projector LED Y at **(0,-82)** shines toward screen Y at **(0,+82)**.
- Both LED bores centre roughly **53 mm above the plate bottom**.
- The shadow caster sits on a 28-mm tall stage. The old v03 test geometry at 28% scale is 55 x 55 x 31 mm.
- At the exact central X/Y plane, point-source magnification is approximately **2x**. A broad LED emitter creates blurry edges; test a small-source 5V LED with an optional pinhole.
- Turn **one LED on at a time** to avoid cross-talk. The full display will need A/B mode switching, unless a better optical isolation method is demonstrated.
- Clip or tape **98 x 85 mm tracing-paper sheets** behind each frame. All components fit nominal Bambu P2S print volume.
- **Use cool-running pre-resistored 5V LED modules**, not unresistored bare LEDs across 5V. Holder bores have not been physically verified against a purchased module.

## Assembly and test

1. Print base, two frames, two LED mounts, stage and (optionally) pinhole caps. Print the old V03 mini caster only as an optical test subject.
2. Insert the two screen frames into sockets at **+X** and **+Y**. Tape the tracing-paper sheets behind the openings.
3. Insert LED stands at **−X** and **−Y** and align two independently controlled low-voltage small-source LEDs toward the opposite screen.
4. Mount the test object at the centre of the 28 mm stage, keeping hoof/base level roughly **34.5 mm from plate bottom**.
5. In a dark room, energize the **−Y** source only and photograph the horse-screen shadow. Switch off and illuminate **−X** only; photograph the carriage-screen shadow.
6. Record source size, distance, focus, apparent sharpness, shadow area, visible missing details and lamp temperature. Run a revised optical test if required.
7. Only after real physical optical proof, engineer the actual curved screens, modular matte-black enclosure, ornament, USB-C 5V power, hidden low-voltage wiring, switch and engraved plaque.

## Validation and limitations

- The mesh generation pipeline checks each resulting STL for watertightness, **one connected component**, positive volume and <= 256 mm nominal size.
- Mesh QA alone does **not** validate the LED fit, printer supports, actual optical contrast, screen durability or the object's beauty.
- Old V03's horse and coach silhouettes were artistically unacceptable; do not confuse them with the approved V04 horse/carriage concept illustrations.
- The downscaled V03 may contain features below a 0.4 mm nozzle's practical limit; inspect in Bambu Studio and use as a bench calibration aid only.
- The concept image's 320 mm-wide base must be split for the P2S; final module joints are not designed yet.

## Regenerate on your computer

Install OpenSCAD. Export each part with:
`openscad -o base.stl -D 'part="base"' v04_optical_bench.scad`

Replace `base` with `screen_frame`, `led_holder`, `stage`, or `pinhole_cap`.
The GitHub Actions workflow generates these STLs and the scaled V03 source object and then publishes them.

**Release gate:** Physical shadow photos must show two recognizable shapes, or we deliberately revise the concept to a *backlit-artwork display*. Never present the latter as a two-shadow illusion.
