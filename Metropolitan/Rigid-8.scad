use <bogie-mount.scad>;

// Draw a window based at 0:0
module std_window() {
	cube([2.5,0.9,0.5]);
	translate([0,1.25,0])
	cube([2.5,4.25,0.5]);
}

module std_door() {
	translate([0,1.25,0])
		cube([2.5,4.25,0.5]);
	translate([-0.5,1.25,0])
		cube([0.2,11.0, 0.1]);
	translate([2.8,1.25,0])
		cube([0.2,11.0, 0.1]);
	translate([-0.5+1.75,1.25,0])
	difference() {
		cylinder(r=1.75,h=0.1, $fn=32);
		cylinder(r=1.55,h=0.1, $fn=32);
		translate([-0.1,0.95,0])
			cube([4,1.85,0.2], center=true);
	}
}

module std_compartment() {
	translate([0,0,0])
		std_window();
	translate([3.45,0,0])
		std_door();
	translate([6.9,0,0])
		std_window();
}

module std_end() {
// We need to trim off 20mm at the ends for the roof // arc
	intersection() {
		union() {
			cube([16.2,14.9,0.4]);
			for(i=[1:6])
				translate([2.3 * i, 0, -0.1])
					cube([0.3,14.9,0.5]);
				translate([0,14.4,-0.1])
					cube([16.2,0.5,0.5]);
		}
		translate([8.1,39.3/2,0])
			cylinder(r=39.3/2,h=1, $fn=128, center=true);
	}
	translate([7.5,7.25,-0.4])
		cube([1.2,2,0.5]);
}

module brake_end() {
	std_end();
}

module std_droplight() {
	translate([0,1.25,0.2])
		difference() {
			cube([2.5,4.25,0.3]);
			translate([0.25,0.25,0])
				cube([2.0,3.6,0.4]);
		}
}

module gas_lamp() {
	cylinder(r1=0.25,r2=0.27,h=1, center=true, $fn=32);
	translate([0,0,0.6])
		cylinder(r=0.35,h=0.4, center=true, $fn=32);
	translate([0,0,0.6])
		cylinder(r1=0.75/2,r2=0.75, h=0.2, center=true, $fn=32);
	translate([0,0,0.9])
		cylinder(r=0.75,h=0.4, center=true, $fn=32);
}

module roof(lamp) {
	intersection() {
		difference() {
			cylinder(r=39.3/2,h=80.75,center=true, $fn=128);
			union() {
				cylinder(r=39.3/2-0.5, h=80.75, center=true, $fn=128);
				translate([0,-1.25,0])
					cube([80,39.3 - 2.5, 81], center=true);
			}
		}
		translate([0,18.5,0])
			cube([17.5,2.5,81], center=true);
	}
	if (lamp == 1) {
		for(i = [0:7]) 
			translate([0, 20.5, -80.75/2 + 0.5 + i * 9.8+3.45 + 1.25 + 0.925])
				rotate([90,0,0])
					gas_lamp();
	}
}

// type
// 0 - normal compartment 3rd
// 1 - brake side 1
// 2 - brake side 2
module panel_compartment(type) {
	// left side
	translate([-0.2,6.5,0])
		cube([2.7,0.2,0.5]);
	translate([2.3,6.5,0])
		cube([0.2,6,0.5]);
	translate([-0.2, 6.5 + 2.9, 0])
		cube([2.7,0.2,0.5]);
	// right side
	translate([6.9,6.5,0])
		cube([2.7,0.2,0.5]);
	translate([6.9,6.5,0])
		cube([0.2,6,0.5]);
	translate([6.9, 6.5 + 2.9, 0])
		cube([2.7,0.2,0.5]);
	// door
	translate([3.25,6.5,0])
		cube([2.9,0.2,0.5]);
	translate([3.25,6.5,0])
		cube([0.2,6,0.5]);
	translate([3.25 + 2.7, 6.5, 0])
		cube([0.2,6,0.5]);
	translate([3.25, 6.5 + 2.9, 0])
		cube([2.9,0.2,0.5]);
}

// Panelling for "long brake" double doors
module panel_doors() {
}

// We make the ventilator by rotating a circle to
// create a doughnut
module door_ventilator() {
	translate([1.25,1.1,0.2])
	difference() {
		union() {
			rotate_extrude($fn=16)
				translate([0.9,0,0])
				circle(r=0.3, $fn=16);
			cylinder(r=0.9, h=0.61, center=true, $fn=16);
		}
		translate([0,0.9,0])
			cube([4,1.8,1], center=true);
	}
}

// could do with being deeper but then need to deepen
// entire side ?
// 0 - normal 3rd compartment
// 1 - brake side 1 (door conversion)
// 2 - brake side 2 (door conversion)
module detail_compartment(t) {
	// door window
	translate([3.45,0.6,0])
		std_droplight();
	translate([3.45,0.6,0])
		door_ventilator();
	// Doorhandles
	translate([6.1,7.5,0])
		rotate([0,90,0])
			cylinder(r=0.15,h=0.6, $fn=16, center=true);
	// Hinges
	translate([3.05,2.5,0.2])
		rotate([90,90,0])
			cylinder(r=0.2,h=0.5, $fn=16, center=true);
	translate([3.05,7.0,0.2])
		rotate([90,90,0])
			cylinder(r=0.2,h=0.5, $fn=16, center=true);
	translate([3.05,11.5,0.2])
		rotate([90,90,0])
			cylinder(r=0.2,h=0.5, $fn=16, center=true);
}

// Detail for double door section
module detail_doors() {
}

module third_left()
{
	difference() {
		union() {
			// body block
			cube([79,12.9,0.4]);
			for (i = [0:7])
				translate([0.5 + i * 9.8, 0, -0.1])
					panel_compartment();
			// Bottom planking
			translate([0,12.4,-0.1])
				cube([79,0.5,0.5]);
		}
		// Poke out compartment windows
		for (i = [0:7])
			translate([0.5 + i * 9.8, 0.6, 0])
				std_compartment();
	}
	for (i = [0:7])
		translate([0.5 + i * 9.8, 0, -0.1])
			detail_compartment(0);
	// need to draw the end beading bits
	translate([0.3, 6.5,-0.1])
		cube([0.2,6,0.5]);
	translate([78.5, 6.5,-0.1])
		cube([0.2,6,0.5]);
}

// Both sides of the third are the same
module third_right() {
	third_left();
}

module brake_third_unit(long, side)
{
	difference() {
		union() {
			// body block
			cube([79,12.9,0.4]);
			for (i = [0:7])
				translate([0.5 + i * 9.8, 0, -0.1])
					if (i == 1 && long == 1)
						panel_doors();
					else if (i == 0)
						panel_compartment(side);
					else
						panel_compartment(0);
			// Bottom planking
			translate([0,12.4,-0.1])
				cube([79,0.5,0.5]);
		}
		// Poke out compartment windows
		for (i = [0:7])
			if (i !=1 || long != 1)
				translate([0.5 + i * 9.8, 0.6, 0])
					std_compartment();
	}
	for (i = [0:7])
		translate([0.5 + i * 9.8, 0, -0.1])
			if (i == 1 && long == 1)
				detail_doors();
			else if (i == 0 && long == 1)
				detail_compartment(side);
			else
				detail_compartment(0);
	// need to draw the end beading bits
	translate([0.3, 6.5,-0.1])
		cube([0.2,6,0.5]);
	translate([78.5, 6.5,-0.1])
		cube([0.2,6,0.5]);
}

// Door changes for guard
module brake_third_left(long) {
	brake_third_unit(long, 1);
}

module brake_third_right(long) {
	brake_third_unit(long, 2);
}


module third() {
	translate([0,-0.01,0])
		rotate([90,0,0])
			third_left();
	translate([79,-16.99,0])
		rotate([90,0,180])
			third_right();
	translate([0.11,-16.6,-2])
		rotate([90,0,90])
			std_end();
	translate([78.89,-0.4,-2])
		rotate([90,0,270])
			std_end();
	translate([39.5,-8.5,17.4])
		rotate([-90,0,90])
			roof(1);
}

module brake_third() {
	translate([0,-0.01,0])
		rotate([90,0,0])
			brake_third_left(1);
	translate([79,-16.99,0])
		rotate([90,0,180])
			brake_third_right(1);
	translate([0.11,-16.6,-2])
		rotate([90,0,90])
			brake_end();
	translate([78.89,-0.4,-2])
		rotate([90,0,270])
			std_end();
	translate([39.5,-8.5,17.4])
		rotate([-90,0,90])
			roof(1);
}

module chassis_peg() {
	cylinder(r=3.8/2,h=1,$fn=32);
}

module chassis() {
	difference() {
		cube([77, 15.0, 1.5], center=true);
		cube([75, 13.0, 1.5], center=true);
	}
	translate([0,0, -2.6]) {
		difference() {
			cube([78.2, 16.2, 4.0], center=true);
			translate([0,0,-0.5])
				cube([76.2, 14.2, 3.0], center=true);
		}
	}
	for (i = [-3:3]) {
		translate([i * 9.8, 0, -3.6]) {
			translate([0,0,-1.5])
				cube([1,16.2, 3], center = true);
			cube([6,16.2, 1], center = true);
		}
	}
	translate([-37.6, 0, -3.6])
		cube([3,16.2, 1], center = true);
	translate([37.6, 0, -3.6])
		cube([3,16.2, 1], center = true);
	translate([-22,0,0.5])
		chassis_peg();
	translate([22,0,0.5])
		chassis_peg();
}

rotate([180,0,0])
	brake_third();

translate([40,10,-15])
    chassis();



