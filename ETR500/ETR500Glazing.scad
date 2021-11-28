use <ETR500WindowGlazing.scad>;
use <ETR500DoorGlazing.scad>;
use <ETR500DiningGlazing1.scad>;
use <ETR500DiningGlazing2.scad>;


module GlazingUnit(n, ys) {
	yv = ys/2 * 0.1;
	for (i=[0:n-1]) {
		translate([0, i*(ys+yv+2), 0]) {
			linear_extrude(height=1)
			  scale(25.4/1200)
			    child(0);
			translate([0,-yv,0.99])
				scale([1.1,1.1,1])
					linear_extrude(height=1)
					  scale(25.4/1200)
		   				 child(0);
		}
	}
}

module VSprue(x) {
	translate([x-0.5,-2,1])
		cube([1,46,1]);
}

module HSprue(y) {
	translate([-0.5,y,1])
		cube([31.5,1,1]);
}

GlazingUnit(4, 4.8)
	ETR500DoorGlazing();

for(i=[0:2]) {
	translate([8+11*i,0,0])
		GlazingUnit(6, 4.89)
			ETR500WindowGlazing();
	VSprue(8.5+11*i);
}

translate([-1.5, 30, 0])
	GlazingUnit(1, 3.58)
		ETR500DiningGlazing1();

translate([-1.5, 37, 0])
	GlazingUnit(1, 3.07)
		ETR500DiningGlazing2();

VSprue(0);

HSprue(-3);
HSprue(43);