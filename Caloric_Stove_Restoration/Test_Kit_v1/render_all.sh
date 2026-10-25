#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p STL
SCADFILE=SOURCE/Caloric_handle_fit_kit.scad
make(){
  local name="$1"; shift
  echo "Rendering $name"
  openscad -q -o "STL/$name.stl" "$@" "$SCADFILE"
}
make 00_PRINT_FIRST_GAUGES_AND_3_PROFILES_256mm_BED -D 'PART="first_print_layout"'
make 01_photo_profile_SMALL_85x41 -D 'PART="profile"' -D 'L=85' -D 'W=41'
make 02_photo_profile_MEDIUM_95x46 -D 'PART="profile"' -D 'L=95' -D 'W=46'
make 03_photo_profile_LARGE_105x51 -D 'PART="profile"' -D 'L=105' -D 'W=51'
make 04_ivory_endplate_95x46_hole18 -D 'PART="plate"' -D 'L=95' -D 'W=46' -D 'CENTER_HOLE=18' -D 'THICKNESS=2.4'
make 05_ivory_shell_95x46_hole18 -D 'PART="shell"' -D 'L=95' -D 'W=46' -D 'CENTER_HOLE=18' -D 'THICKNESS=2.4'
make 06_ivory_shell_95x46_hole20 -D 'PART="shell"' -D 'L=95' -D 'W=46' -D 'CENTER_HOLE=20' -D 'THICKNESS=2.4'
make 07_boss_hole_gauge_14-22 -D 'PART="boss_gauge"'
make 08_chrome_handle_width_gauge_18-30 -D 'PART="chrome_gauge"'
make 09_decorative_washers_5-10 -D 'PART="screw_washers"'
make 10_door_keyhole_bulb_gauge_7-13 -D 'PART="keyhole_gauge"'
make 11_back_trim_100mm_STYLE_SAMPLE -D 'PART="decorative_trim_sample"'
make 12_gas_knob_shaft_hole_gauge_5-7 -D 'PART="knob_shaft_gauge"'
