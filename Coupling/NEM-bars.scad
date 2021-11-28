
module coupling_bar(thick, l) {
	translate([-l-1.7,0,0])
		cube([3.4, 1.15, 2.4], center=true);
	translate([l+1.7,0,0])
		cube([3.4, 1.15, 2.4], center=true);
	cube([(l + 3.4) * 2, thick, thick], center=true);
	translate([-l-1.7,0,0])
		cylinder(r=0.42,h=3.8, $fn=16, center=true);
	translate([l+1.7,0,0])
		cylinder(r=0.42,h=3.8, $fn=16, center=true);
}


module bar_pack(thick, n, s, m , l) {

	for (i = [0:(n-1)]) {
		translate([0,3*i,0])
			coupling_bar(thick, s);
		translate([0, -3, -1.15/2])
			cube([1.0, 3 * (n+1),1.0]);
	}


	for (i = [0:(n-1)]) {
		translate([0,3*i,5])
			coupling_bar(thick, m);
		translate([0, -3, 5-1.15/2])
			cube([1.0, 3 * (n+1),1.0]);
	}

	for (i = [0:(n-1)]) {
		translate([0,3*i,10])
			coupling_bar(thick, l);
		translate([0, -3, 10 - 1.15/2])
			cube([1.0,3 * (n + 1),1.0]);
	}

	translate([0,-3, 0])
		cube([1.0,1.0,10]);

	translate([0, (3 * n) - 1, 0])
		cube([1.0,1.0,10]);
}

// 4,5,6 usual range
//
//bar_pack(1.5, 20, 5, 5, 5);
bar_pack(1.5,20,6,6,6);


