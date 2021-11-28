module catenary_riser() {
	difference() {
		cube([10,10,5], center=true);
		translate([0,0,-2])
			cube([8,8,2.1], center=true);
		translate([0,0,-1])
			cube([6,6,3.1], center=true);
		cylinder(r=1.65,h=10, center=true, $fn=16);
		rotate([90,0,0])
			translate([-5,2.5,0])
				cylinder(r=2,h=12, center=true, $fn=16);
		rotate([90,0,0])
			translate([5,2.5,0])
				cylinder(r=2,h=12, center=true, $fn=16);
		rotate([90,0,90])
			translate([-5,2.5,0])
				cylinder(r=2,h=12, center=true, $fn=16);
		rotate([90,0,90])
			translate([5,2.5,0])
				cylinder(r=2,h=12, center=true, $fn=16);
	}
}

module catenary_riser_pack() {
	for(i=[0:9]) {
		for(j=[0:9]) {
			translate([12 * i, 12 *j, 0])
				catenary_riser();
		}
		translate([4+12 * i,2,-2])
			cube([1,110, 1]);
	}
	translate([3, 64,-2])
		cube([110,1,1]);
}

catenary_riser();

