/*
Caloric vintage gas range | PHOTO-BASED TEST KIT | v1.0 | Oct 2026
Author: OpenAI for personal restoration prototyping
UNVERIFIED DIMENSIONS: photographs do not establish a scale. Test all fit offline.
Printed parts are NON-STRUCTURAL PROTOTYPES, not oven/gas-rated parts.
DO NOT install prototype as load-bearing handle mount, on running/hot stove,
or use printed parts in a gas path, inside hot cavities, or over a vent.
All measurements in millimeters.
*/
PART = "profile";
L = 95;                // overall tapered ivory end-piece height
W = 46;                // overall tapered ivory end-piece width
THICKNESS = 2.0;
CENTER_HOLE = 18;
HOLE_X = 0;
HOLE_Y_FRAC = -0.17;
RIM = 1.8;
LIP_HEIGHT = 2.0;
FIT_CLEARANCE = 0.25;
$fn = 72;

module end_footprint(){
  scale([W/42,L/98])
  hull(){
    translate([0,36]) circle(r=13);
    translate([0,2]) circle(r=21);
    translate([0,-29]) circle(r=20);
  }
}
module profile(){
  linear_extrude(height=THICKNESS)
    difference(){ end_footprint(); translate([HOLE_X,HOLE_Y_FRAC*L]) circle(d=1.0, $fn=24); }
}
module plate(){
  linear_extrude(height=THICKNESS)
    difference(){
      end_footprint();
      translate([HOLE_X,HOLE_Y_FRAC*L]) circle(d=CENTER_HOLE);
    }
}
module shell(){
  difference(){
    union(){
      linear_extrude(height=THICKNESS) end_footprint();
      translate([0,0,THICKNESS])
      linear_extrude(height=LIP_HEIGHT)
        difference(){ end_footprint(); offset(delta=-RIM) end_footprint(); }
      for (s=[-1,1]){
        translate([s*W*0.19,L*0.07,THICKNESS])
          cube([2.1,13,1.15],center=true);
      }
    }
    translate([HOLE_X,HOLE_Y_FRAC*L,-0.1])
      cylinder(d=CENTER_HOLE,h=THICKNESS+LIP_HEIGHT+0.3);
  }
}
module rounded_box_2d(w,h,r){
  hull(){
    for(x=[-w/2+r,w/2-r], y=[-h/2+r,h/2-r])
      translate([x,y]) circle(r=r);
  }
}
module emboss_label(str,x,y,fontsize=3.6,z=3){
  translate([x,y,z]) linear_extrude(0.55)
    text(str,size=fontsize,halign="center",valign="center",font="Liberation Sans:style=Bold");
}
module boss_gauge(){
  ds = [14,16,18,20,22];
  difference(){
    linear_extrude(3) rounded_box_2d(164,39,4);
    for(i=[0:4]) translate([-64+i*32,4,-0.1]) cylinder(d=ds[i],h=3.2);
  }
  for(i=[0:4]) emboss_label(str(ds[i]),-64+i*32,-14,4.0,3);
}
module chrome_gauge(){
  widths=[18,22,26,30];
  difference(){
    linear_extrude(3) rounded_box_2d(142,38,3);
    for(i=[0:3]) translate([-54+i*36,13,1.5])
      cube([widths[i],18,3.4],center=true);
  }
  for(i=[0:3]) emboss_label(str(widths[i]),-54+i*36,-13,4.5,3);
}
module screw_washers(){
  ds=[5,6,8,10];
  for(i=[0:3]){
    translate([(i-1.5)*32,0,0]) difference(){
      union(){
        cylinder(d=26,h=3);
        translate([0,0,3]) cylinder(d1=26,d2=23,h=1);
      }
      translate([0,0,-.2]) cylinder(d=ds[i],h=4.4);
    }
  }
}
module keyhole_gauge(){
  ds=[7,9,11,13];
  for(i=[0:3]){
    translate([(i-1.5)*31,0,0]){
      union(){
        linear_extrude(3) hull(){
          translate([0,-11]) circle(r=7);
          translate([0,1]) circle(r=5);
        }
        translate([0,3,3]) cylinder(d=ds[i],h=2);
        emboss_label(str(ds[i]),0,-11,4,3);
      }
    }
  }
}
module decorative_trim_sample(){
  union(){
    linear_extrude(2) rounded_box_2d(100,14,2);
    translate([0,0,2])
      linear_extrude(2) rounded_box_2d(98,8,3);
    translate([0,0,4])
      linear_extrude(1.1) rounded_box_2d(96,2,1);
  }
}
module knob_shaft_gauge(){
  ds=[5,5.5,6,6.5,7];
  difference(){
    linear_extrude(3) rounded_box_2d(145,30,3);
    for (i=[0:4]){
      translate([-56+i*28,4,-0.1])
        cylinder(d=ds[i],h=3.2,$fn=80);
    }
  }
  for(i=[0:4]) emboss_label(str(ds[i]),-56+i*28,-9,3.9,3);
}
// First-print combined bed layout: every item is a separate loose gauge.
module first_print_layout(){
  translate([-76,70,0]) let(L=85,W=41) profile();
  translate([-10,70,0]) let(L=95,W=46) profile();
  translate([63,70,0]) let(L=105,W=51) profile();
  translate([0,-8,0]) boss_gauge();
  translate([0,-59,0]) chrome_gauge();
  translate([0,-102,0]) keyhole_gauge();
}
if (PART=="profile") profile();
else if (PART=="plate") plate();
else if (PART=="shell") shell();
else if (PART=="boss_gauge") boss_gauge();
else if (PART=="chrome_gauge") chrome_gauge();
else if (PART=="screw_washers") screw_washers();
else if (PART=="keyhole_gauge") keyhole_gauge();
else if (PART=="decorative_trim_sample") decorative_trim_sample();
else if (PART=="knob_shaft_gauge") knob_shaft_gauge();
else if (PART=="first_print_layout") first_print_layout();
else assert(false,str("Unsupported PART: ", PART));
