module bulb() {
	cylinder(r=0.2, h=0.8, center=true, $fn=16);
	translate([0,0,0.2])
		sphere(r=0.3, center=true, $fn=16);
}

module lamp_head() {
	difference() {
		cylinder(r1=0.5, r2=1.3, h=2, $fn=16, center=true);
		translate([0,0,0.2])
			cylinder(r1=0.3, r2=1.1, h=1.61, $fn=16, center=true);
	}

	translate([0,0,-1])
		cylinder(r=0.3, h=0.5, $fn=16, center=true);

	translate([0,0,-1.2])
		rotate([0,90,0])
			cylinder(r=0.2, h=0.6, $fn=16, center=true);

	translate([0,0,-0.3])
		bulb();
}

module lamp_assembly() {
	cylinder(r=0.25, h=4, $fn=16, center=true);
	translate([0,1.85,1.85])
		rotate([90,0,0])
			cylinder(r=0.25, h=4, $fn=16, center=true);
	translate([0,-0.1,1.9])
		rotate([90,0,90])
			cylinder(r=0.2, h=0.7, $fn=16, center=true);
	translate([0,1.1,-2.0])
		rotate([0,110,90])
			lamp_head();
}

module lamp_base() {
	cylinder(r=2, h=0.4, $fn=16, center=true);
	translate([0,0,-0.25])
		cylinder(r1=0.5,r2=2,h=0.2, $fn=16, center=true);
	translate([0,0,-0.5])
		cylinder(r=0.3,h=1.0,$fn=16, center=true);
	translate([0,0,-0.7])
		rotate([90,0,90])
			cylinder(r=0.3,h=0.8,$fn=16, center=true);
}

module desk_lamp() {
	lamp_assembly();
	translate([0,4,2.5])
		rotate([-45,0,0])
			lamp_base();
}

for (j=[0:2]) {
	translate([j * 5, 0, 0]) {
		for (i = [0:4]) {
			translate([0, 7*i,0])
				rotate([45,0,0])
					desk_lamp();
		}
	}
	for(i=[0:4]) {
		translate([-4.5,7 * i,4.55])
			cube([19,0.5,0.5]);
	}
	translate([5,0,4.55])
		cube([0.5, 28, 0.5]);
}