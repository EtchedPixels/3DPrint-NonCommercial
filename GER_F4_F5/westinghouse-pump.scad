
module westinghouse_pump_8()
{
	rotate([90,0,0]) {
		translate([0,-0.4,-0.8])
			cube([0.8, 0.8, 0.8]);
		translate([0,0,2.625/2])
			cylinder(r=0.9, h=2.625, center=true, $fn=32);
		translate([0,0,2.6])
			cylinder(r=0.3, h=6.8, center=true, $fn=32);
		translate([0,0, 6 - 1.125])
			cylinder(r=0.85, h=2.25, center=true, $fn=32);

		translate([0.4,0.0,-1.5])
			cylinder(r=0.25, h=0.9, $fn=16);
		translate([-0.3,0, 5.6])
			cylinder(r=0.25, h=0.9,$fn=16);
		translate([0.3,-0, 5.6])
			cylinder(r=0.25, h=0.9,$fn=16);
	
		translate([0,-0.7,1.4])
			rotate([0,90,0])
				cylinder(r=0.3, h=4, $fn=16, center=true);
		translate([1, 0, 5])
			rotate([0,90,0])
				cylinder(r=0.3, h=0.5, $fn=16, center=true);
		translate([-0.8,-1,0])
			cube([0.9, 0.4, 4.2]);
		translate([-0.8,-1,0])
			cube([0.4, 0.9, 4.2]);
	}
}

module westinghouse_pump_row()
{
	for(i=[0:4]) {
		translate([i * 4, 0 , 0])
			westinghouse_pump_8();
	}
}



for (j=[0:4]) {
	translate([0, 0, j * 3.5])
		westinghouse_pump_row();
}
translate([-2.3,-1.4,6.4])
	rotate([0,0,90])
		cylinder(r=0.5, h = 1 + 4 * 3.5, center=true);
translate([18.0,-1.4,6.4])
	rotate([0,0,90])
		cylinder(r=0.5, h = 1 + 4 * 3.5, center=true);
