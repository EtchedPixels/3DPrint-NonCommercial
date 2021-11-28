//	4mm outer dia for the standard bogie type mounts
//	3mm top dia for the Ultima locator
// 2mm outer dia for the Ultima small type bogies
// 1.8mm top dia for small bogies (uses the pin as
// the locator)
//
// p set if you want a locating pin
module bogie_mount(p, mini) {
	difference() {
		union() {
			translate([0,-0.5,0]) {
				rotate([90,0,0])
					// Form the main block
					difference() {
						cylinder(h=1.5, r=4.5, center=true, $fn=30);
						translate([0,0,0.51])
							cylinder(h=0.5, r=3.5, center=true, $fn=30);
					}
			}
			// Punch through the mount
			if (mini == 0)
				rotate([90,0,0])
					translate([0,0,-1])
						cylinder(h=2.5, r=1.9, center=true, $fn=30);
		}
		// Subtract the pinhole
		rotate([90,0,0])
			cylinder(h=6, r=0.9, center=true, $fn=30);
	}
	if (p == 1) {
	rotate([90,0,0]) {
		translate([0,0,1.5])
			difference() {
				cylinder(h=1, r=1.5, center=true, $fn=30);
				cylinder(h=1, r=0.5, center=true, $fn=30);
			}
	}
	}
}


module bogie_pin(mini) {
	if (mini == 1) {
		cylinder(h=4.5, r = 0.8, center=true, $fn=30);
		translate([0,0,2])
			cylinder(h=0.8, r = 1.9, center=true, $fn=30);
	} else {
		cylinder(h=4.5, r = 0.8, center=true, $fn=30);
		translate([0,0,2])
			cylinder(h=0.8, r = 3, center=true, $fn=30);
	}
}

module bogie_conversion(p, mini) {
	bogie_mount(p, mini);
	translate([0,5,0])
		bogie_pin(mini);
}


module bogie_mount_pack(n, p, mini) {
	for (i = [0:n-1]) {
		translate([10 * i, 0, 0])
			bogie_mount(p, mini);
	}
	rotate([0,90,0])
		translate([3.3,-0.25,0])
			cylinder(r=0.5,h= 10 * (n - 1), $fn=32);
}

module bogie_pin_pack_normal(n) {
	for (i = [0:n-1]) {
		translate([7 * i, 0, 0])
			bogie_pin(0);
	}
	rotate([0,90,0])
		translate([-2.4,-0.5,0])
			cube([1,1,7 * (n-1)]);
}

module bogie_pin_pack_mini(n) {
	for (i = [0:n-1]) {
		translate([5 * i, 0, 0])
			bogie_pin(1);
	}
	rotate([0,90,0])
		translate([-2.4,-0.5,0])
			cube([1,1, 5 * (n-1)]);
}

module bogie_pack(n, p, mini) {
	translate([0,-5.5 + (2 * mini),0])
		bogie_mount_pack(n, p, mini);
	translate([-2.5,4,1])
		if (mini == 1)
			bogie_pin_pack_mini(n);
		else
			bogie_pin_pack_normal(n);
}

module bogie_block(n, m, p, mini) {
	for (i=[0:m-1])
		translate([0,0,11*i])
			bogie_pack(n, p, mini);
}



// Number of pairs to do, 1 if need locator (only relevant to
// large pin type), then 1 if need small pin type
bogie_block(10, 10, 0, 0);
