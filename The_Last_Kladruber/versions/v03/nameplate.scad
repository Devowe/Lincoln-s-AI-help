// THE LAST KLADRUBER / ONE-OF-ONE NAMEPLATE
// Separate print, 159 x 32 x 4 mm, recessed lettering.
$fn=32;
length=159; width=32; thick=4;
module rounded_box(l,w,r){
    hull(){for(x=[r,l-r],y=[r,w-r]) translate([x,y,0]) cylinder(h=thick,r=r);}
}
difference(){
    rounded_box(length,width,3);
    translate([length/2,22,thick-0.8])
      linear_extrude(1.4) text("THE LAST KLADRUBER",size=9.3,halign="center",valign="center",font="Liberation Sans:style=Bold");
    translate([length/2,9,thick-0.8])
      linear_extrude(1.4) text("No. 001  |  CREATED FOR BART",size=5.7,halign="center",valign="center",font="Liberation Sans:style=Bold");
}
