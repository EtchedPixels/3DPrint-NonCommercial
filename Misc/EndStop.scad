module FiddleEndStop() {
	difference() {
		translate([-7.5,0,0])
			cube([15,20,5]);
		difference() {
			translate([-5.5,15,-1])
				cube([11,6,7]);
			translate([-3,15,-2])
				cube([6,3,9]);
		}
		translate([-6.5,-1,1])
			cube([13,14,5]);
		translate([0,22,3])
			rotate([90,0,0])
				cylinder(r=1,h=15, $fn=32);
	}
}

for(i=[0:9])
	translate([0,0,6 * i])
		FiddleEndStop();




