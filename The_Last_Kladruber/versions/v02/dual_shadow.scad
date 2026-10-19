// THE LAST KLADRUBER — v02: two orthogonal silhouettes from one printable volume.
// Render with: openscad -o dual_shadow.stl dual_shadow.scad
// Place source SVG files under ../../assets.
$fn=32;
scale([0.90,0.90,0.90])
intersection(){
  // Light from the front/back along Y produces horse silhouette on XZ screen.
  rotate([90,0,0])
  linear_extrude(height=500,center=true,convexity=10)
  import("../../assets/kladruber_horse.svg",center=false);
  // Light from left/right along X produces carriage silhouette on YZ screen.
  rotate([0,0,90]) rotate([90,0,0])
  linear_extrude(height=500,center=true,convexity=10)
  import("../../assets/royal_carriage.svg",center=false);
}
