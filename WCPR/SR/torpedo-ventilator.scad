module torpedo_ventilator() {

$fn=100;
scale(0.5) {

	translate([0,0,1.0])
		cylinder(h=2,r1=0.85,r2=0, center=true);
	translate([0,0,-1.0])
		cylinder(h=2,r1=0,r2=0.85, center=true);

	difference() {
		translate([0,0,-0.25])
			cylinder(h=0.5,r1=1,r2=1.05, center=true);
		translate([0,0,-0.25])
		cylinder(h=1.0,r1=0.8,r2=0.85, center=true);
	}

	difference() {
		translate([0,0,0.25])
			cylinder(h=0.5,r1=1.05,r2=1.0, center=true);
		translate([0,0,0.25])
			cylinder(h=1.0,r1=0.85,r2=0.8, center=true);
	}

	difference() {
		cylinder(h=0.2,r=1.1, center=true);
		cylinder(h=0.1,r=0.9, center=true);
	}

	translate([0.98,0,0]) {
		rotate([0,90,0]) {
			cylinder(h=0.1, r1=0.6, r2=0.7, center=true);
			translate([0,0,0.10])
				cylinder(h=0.1, r=0.7, center=true);
			translate([0,0,0.15])
				cylinder(h=0.1,r1=0.7, r2=0.95, center=true);
		}
	}

	rotate([0,90,0])
		translate([0,0,2.7])
			cylinder(h=1, r=0.7, center=true);
};

};
