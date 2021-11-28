use <ETR500CPlug1.scad>
use <ETR500CPlug2.scad>
use <ETR500CPlug3.scad>

module PlugIt(l, i, r) {
	translate([0,0,-i-r+0.02])
		linear_extrude(height=r)
			scale(25.4/1200)
				ETR500CPlug3();
	translate([0,0,-i+0.01])
		linear_extrude(height=i)
			scale(25.4/1200)
				ETR500CPlug2();
	linear_extrude(height=l)
		scale(25.4/1200)
			ETR500CPlug1();
	translate([0,0,l-0.01])
		linear_extrude(height=i)
			scale(25.4/1200)
				ETR500CPlug2();
	translate([0,0,l+i-0.02])
		linear_extrude(height=r)
			scale(25.4/1200)
				ETR500CPlug3();
}

module PlugEnd(l, i, r) {
	translate([0,0,-i-r+0.02])
		linear_extrude(height=r)
			scale(25.4/1200)
				ETR500CPlug3();
	translate([0,0,-i+0.01])
		linear_extrude(height=i)
			scale(25.4/1200)
				ETR500CPlug2();
	linear_extrude(height=l)
		scale(25.4/1200)
			ETR500CPlug1();
}

module ETR500Plugs(n) {
	for (i = [0:n-1]) {
		translate([i*12.8,0,0])
			PlugIt(5,5,1);
	}
}

module ETR500EndPlugs(n) {
	for (i = [0:n-1]) {
		translate([i*12.8,0,0])
			PlugEnd(5,5,1);
	}
}

module Stopper() {
	difference() {
		union() {
			cylinder(r=7,h=10,$fn=32);
			cylinder(r=11,h=5,$fn=32);
		}
		translate([0,0,5])
			cylinder(r=4,h=7,$fn=32);
		cylinder(r=7,h=1,$fn=32);
	}
}


ETR500Plugs(4);
translate([0,17,0])
  ETR500EndPlugs(2);
translate([-18,17,0])
	Stopper();
