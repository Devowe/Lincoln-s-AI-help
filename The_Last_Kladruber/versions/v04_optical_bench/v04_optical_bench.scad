/*
 The Last Kladruber V04 — optical feasibility bench; units in mm.
 Purpose: test two TRUE cast shadows along perpendicular X/Y light paths.
 This is NOT the finished luxury case or approved final shadow sculpture.
 5V-ready current-limited LED modules only; bare LEDs need resistors.
 Use one light at a time to avoid competing shadows.
*/
$fn=64;
part="assembly"; // assembly, base, screen_frame, led_holder, stage, pinhole_cap
plate=200;
plate_z=5;
screen_center=82;
light_center=82;
module rounded_plate(w,h,r,z){
  hull() for(xx=[-w/2+r,w/2-r]) for(yy=[-h/2+r,h/2-r])
    translate([xx,yy,0])cylinder(r=r,h=z);
}
module base(){
  difference(){
    rounded_plate(plate,plate,11,plate_z);
    for(s=[-50,50]){
      translate([screen_center,s,3.25])cube([10,8.0,3.55],center=true);
      translate([s,screen_center,3.25])cube([8.0,10,3.55],center=true);
    }
    translate([-light_center,0,3.25])cube([12,12,3.55],center=true);
    translate([0,-light_center,3.25])cube([12,12,3.55],center=true);
  }
  translate([0,0,plate_z])difference(){
    cylinder(r=32,h=1.5);
    cylinder(r=30,h=1.7);
  }
  translate([0,0,plate_z])cube([2,50,0.8],center=true);
  translate([0,0,plate_z])cube([50,2,0.8],center=true);
}
module screen_frame(){
  difference(){
    linear_extrude(height=4.5)translate([0,48])square([108,96],center=true);
    translate([0,52,-0.3])linear_extrude(height=5.1)square([93,81],center=true);
  }
  for(x=[-50,50]){
    translate([x,-1.55,0.35])cube([6.8,3.1,3.8],center=true);
  }
}
module corrected_led_holder(){
  difference(){
    union(){
      translate([-5.75,-5.75,-3.1])cube([11.5,11.5,3.1]);
      cylinder(r=4.0,h=45);
      translate([0,0,48])cube([20,13,17],center=true);
    }
    translate([0,0,48])rotate([0,90,0])cylinder(d=5.4,h=21,center=true);
  }
}
module pinhole_cap(){
  difference(){
    cube([3.0,14.5,18.5],center=true);
    rotate([0,90,0])cylinder(d=1.4,h=4,center=true);
  }
}
module stage(){
  // 28 mm pedestal lifts the optical test sculpture into the light path.
  cylinder(r=29,h=28);
}
module assembly(){
  color("#303030")base();
  color("#efdfb5",0.65)translate([0,screen_center,plate_z])
    rotate([90,0,0])screen_frame();
  color("#efdfb5",0.65)translate([screen_center,0,plate_z])
    rotate([0,0,90])rotate([90,0,0])screen_frame();
  color("#202020")translate([-light_center,0,plate_z])corrected_led_holder();
  color("#202020")translate([0,-light_center,plate_z])
    rotate([0,0,90])corrected_led_holder();
  color("#846a42")translate([0,0,6.5])stage();
}
if(part=="base")base();
else if(part=="screen_frame")screen_frame();
else if(part=="led_holder")corrected_led_holder();
else if(part=="stage")stage();
else if(part=="pinhole_cap")pinhole_cap();
else assembly();
