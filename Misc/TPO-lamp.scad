module tpo_lamp() {
	cylinder(r=0.5,h=4, $fn=32, center=true);
	translate([0,0,2])
		cylinder(r=1.2, h=0.2, $fn=32, center=true);
	translate([0,0,1.8])
		cylinder(r=1.6, h=0.3, $fn=32, center=true);

	translate([0,0,1.3])
		difference() {
			sphere(r=1.3, $fn=64, center=true);
			translate([0,0,-0.8])
				cube([3.1,3.1,2.6], center=true);
		}
}

module tpo_lamp_sprue() {
	for (i = [0:9]) {
		translate([0, i * 3.7, 0])
			tpo_lamp();
	}
	translate([0,33.3/2,-2])
		cube([0.5, 34.3, 0.5], center=true);
}

module tpo_lamp_pack() {
	for (i = [0:9]) {
		translate([i * 3.7, 0, 0])
			tpo_lamp_sprue();
	}
	translate([33.3/2, 33.3/2, -2])
		cube([34.3, 0.5, 0.5], center=true);
}

tpo_lamp_pack();
