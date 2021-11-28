// TODO
//		cab side windows/door - alt style
//		window rounding
// 	alternate buffer beams
// 	side steps
//		rivets
//		dummy axle boxes
//		mount point for chassis ?
//		lamp
//		rainstrips
//		nose grille
//		nose side details
//		caps behind angle bracing
//
use <RoofProfile.scad>;
use <NoseProfile.scad>;


module buffer() {
	rotate([0,90,0]) {
		cylinder(r=0.65, h=2.3, $fn=16, center=true);
		translate([0,0, 0.35])
			cylinder(r=0.75, h=1.6, $fn=16, center=true);
		translate([0,0,-0.95])
			cylinder(r=1.5,  h=0.4, $fn=32, center=true);
	}
}
	
module buffer_beam() {
	translate([0,0.5,0])
		cube([0.5, 4.5, 12.9]);
	translate([0,0, 0.5])
		cube([0.5, 5, 11.9]);
	translate([0,0.5,0.5])
		rotate([0,90,0])
			cylinder(r=0.5, h=0.5, $fn=32);
	translate([0,0.5,12.4])
		rotate([0,90,0])
			cylinder(r=0.5, h=0.5, $fn=32);
}

module buffer_bracing_front()
{
	difference() {
		cube([2, 1.3, 0.4]);
		translate([0,0,-0.1])
			rotate([0,0,45])
				cube([2,2,0.6]);
	}
}
	

module cab_windows() {
	translate([-0.5, 11+4.3, 0.86])
		cube([11, 1.8, 3.3]);
	translate([-0.5, 11+4.3, 12.7-0.86-3.3])
		cube([11, 1.8, 3.3]);
}

module cab_roof() {
	translate([10,15.4+4.3,6.3])
	rotate([0,90,180])
	linear_extrude(height=10) {
		scale(25.4/600)
			RoofProfile();
	}
}

module roof_full() {
	translate([11,15.4+4.3,6.3])

	difference() {
		rotate([0,90,180])
			linear_extrude(height=12) {
				scale(25.4/600)
					RoofProfile();
			}
		translate([0.5,-0.5,0])
			rotate([0,90,180])
				linear_extrude(height=13) {
					scale(25.4/600)
						RoofProfile();
				}
	}
}

module mesh(h, w)
{
	translate([-0.2,0,0])
		cube([0.5,h-0.25,w-0.25]);
	for (i = [0:(h * 2)-1]) {
		translate([0, 0.5 * i, 0])
			cube([0.5,0.2, w-0.25]);
	}
	for (i = [0:(w * 2)-1]) {
		translate([0, 0, 0.5 * i])
			cube([0.5, h-0.25, 0.2]);
	}
}

module nose_shape() {
	rotate([0,270,180])
	linear_extrude(height=22.1) {
		scale(25.4/600)
			NoseProfile();
	}
}

module front_grille_hole()
{
		l = 22;
		translate([0,0,0.5])
			cube([l, 3.75, 3.5]);
		translate([0,0.5,0])
			cube([l, 2.75, 4.5]);
		translate([0,0.5,0.5])
			rotate([0,90,0])
				cylinder(r=0.5,h=l, $fn=16);
		translate([0,3.25,0.5])
			rotate([0,90,0])
				cylinder(r=0.5,h=l, $fn=16);
		translate([0,3.25,4])
			rotate([0,90,0])
				cylinder(r=0.5,h=l, $fn=16);
		translate([0,0.5,4])
			rotate([0,90,0])
				cylinder(r=0.5,h=l, $fn=16);
}

module body_48ds() {
	difference() {
		union() {
			// Underframe
			translate([0,0,0.25])
				cube([22.142, 3, 12.2]);
			// Underframe base wider bit
			translate([0,0,0.05])
				cube([22.142, 0.6, 12.6]);
			// Nose
			translate([0,2.99,2.9])
				cube([22.1, 5.5, 6.9]);
			translate([0, 9.7, 6.35])
				nose_shape();
			// Front cap
			translate([20.1, 14.3, 6.35])
				rotate([90,0,0])
					cylinder(r=0.3,h=1.2, $fn=16);
			// Cab
			translate([0,2.99,0])
				cube([10, 14.3, 12.7]);
			// Exhaust
			translate([10.2, 18.8, 8])
				rotate([90,0,0])
					cylinder(r=0.3,h=10, $fn=16);
			translate([-0.2,-0.6,-0.1])
				buffer_beam();
			translate([23.3,3.4,1])
				rotate([0,0,180])
					buffer();
			translate([23.3,3.4,11.7])
				rotate([0,0,180])
					buffer();
			translate([22.042,-0.8,-0.1])
				buffer_beam();
			translate([-0.9,3.4,1])
				buffer();
			translate([-0.9,3.4,11.7])
				buffer();
			translate([20.042,2.9,0.25])
				buffer_bracing_front();
			translate([20.042,2.9,12.05])
				buffer_bracing_front();
			cab_roof();
			// Now fit the sand fillers
			translate([21, 4.5, 1.6])
				rotate([90,0,0])
					cylinder(r=0.4, h=1.8, $fn=16);
			translate([21,4.5, 11.1])
				rotate([90,0,0])
					cylinder(r=0.4, h=1.8, $fn=16);
			// Lights
			translate([-1,11.14,6.35])
				rotate([0,90,0])
					cylinder(r=0.25, h=12, $fn=16, center=true);
			
		}
		// Cut out the cab space for the motor
		// This slices out the roof core too.
		// We'll restore that when we do the roof
		// proper later on.
		translate([0.5, -0.01, 0.75])
			cube([9, 20.3, 11.2]);
		// Cut out nose
		translate([0.5, -0.01, 3.5])
			cube([20.9, 7.5, 5.7]);
		// And the front grille space
		// Cut this down the nose to open out the
		// nose top area
		translate([1, 4.35, 4.1])
			front_grille_hole();

		// Cut out chassis space for wheels
		translate([0.5, -0.01, 0.75])
			cube([21.142, 2.5, 11.2]);
		// Cut out cab front/rear windows
		cab_windows();
		// Door grooves
		translate([8.4, 3, 0])
			cube([0.2, 14.3, 0.1]);
		translate([5.65, 3, 0])
			cube([0.2, 14.3, 0.1]);
		translate([8.4,3, 12.6])
			cube([0.2, 14.3, 0.1]);
		translate([5.65,3,12.6])
			cube([0.2, 14.3, 0.1]);
		translate([1.15, 9.3+4.3, -0.05]) 
			cube([3.5, 3.5, 12.8]);
		translate([6.12, 9.3+4.3, -0.05]) 
			cube([2, 3.5, 12.8]);
	}
	// Now add the full roof element
	roof_full();
	// Grille mesh
	translate([21.5, 3.1, 4.0])
		mesh(5.5,5.5);
}

body_48ds();
