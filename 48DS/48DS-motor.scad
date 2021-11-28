// TODO
//		cab side windows/door - alt style
//		window rounding
// 	alternate buffer beams
// 	side steps
//		rivets
//		mount point for chassis ?
//		rainstrips
use <RoofProfile.scad>;
use <NoseProfile.scad>;


module NoseProfileFixed() {
	scale([7.9/6.9,1,1])
		NoseProfile();
}

module RoofProfileFixed() {
	scale([13.7/12.7,1,1])
		RoofProfile();
}

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
		cube([0.5, 4.5, 13.9]);
	translate([0,0, 0.5])
		cube([0.5, 5, 12.9]);
	translate([0,0.5,0.5])
		rotate([0,90,0])
			cylinder(r=0.5, h=0.5, $fn=32);
	translate([0,0.5,13.4])
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
	translate([-0.5, 12.0, 0.86])
		cube([11, 1.8, 3.3]);
	translate([-0.5, 12.0, 13.7-0.86-3.3])
		cube([11, 1.8, 3.3]);
}

module cab_roof() {
	translate([10,16.7,6.8])
	rotate([0,90,180])
	linear_extrude(height=10) {
		scale(25.4/600)
			RoofProfileFixed();
	}
}

module roof_full() {
	translate([11,16.7,6.8])

	difference() {
		rotate([0,90,180])
			linear_extrude(height=12) {
				scale(25.4/600)
					RoofProfileFixed();
			}
		translate([0.5,-0.5,0])
			rotate([0,90,180])
				linear_extrude(height=13) {
					scale(25.4/600)
						RoofProfileFixed();
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
	linear_extrude(height=22.4) {
		scale(25.4/600)
			NoseProfileFixed();
	}
}

module nose_shape_slice(n) {
	rotate([0,270,180])
	linear_extrude(height=n) {
		scale(25.4/600)
			NoseProfileFixed();
	}
}

module nose_segment(n) {
	translate([0,2.99,2.9])
			cube([n, 6.7, 7.9]);
	translate([0, 10.9, 6.85])
			nose_shape_slice(n);
}

module nose_slicer() {
	difference() {
		translate([0,0,0])
			nose_segment(0.1);
		translate([-0.05,0,0.1])
			nose_segment(0.2);
	}
	difference() {
		translate([0,0,0])
			nose_segment(0.1);
		translate([-0.05,0,-0.1])
			nose_segment(0.2);
	}
	difference() {
		translate([0,0,0])
			nose_segment(0.1);
		translate([-0.05,-0.1,0])
			nose_segment(0.2);
	}
}

module front_grille_hole()
{
		l = 22;
		translate([0,0,0.5])
			cube([l, 3.75, 4.5]);
		translate([0,0.5,0])
			cube([l, 2.75, 5.5]);
		translate([0,0.5,0.5])
			rotate([0,90,0])
				cylinder(r=0.5,h=l, $fn=16);
		translate([0,3.25,0.5])
			rotate([0,90,0])
				cylinder(r=0.5,h=l, $fn=16);
		translate([0,3.25,5])
			rotate([0,90,0])
				cylinder(r=0.5,h=l, $fn=16);
		translate([0,0.5,5])
			rotate([0,90,0])
				cylinder(r=0.5,h=l, $fn=16);
}

module lamp(n) {
	difference() {
		sphere(r=0.5, $fn=16);
		translate([-n,-0.5,-0.5])
			cube([1,1,1]);
	}
}

module left_bodyside_step() {
	cube([2,2,0.5]);
	translate([0, 0,-1.1])
		cube([2,0.5,1.2]);
	translate([0, 1.5,-1.1])
		cube([2,0.5,1.2]);
}

module right_bodyside_step() {
	cube([2,2,0.5]);
	translate([0, 0, 0.4])
		cube([2,0.5,1.2]);
	translate([0, 1.5,0.4])
		cube([2,0.5,1.2]);
}

module left_axlebox()
{
	difference() {
		union() {
			translate([0,-0.8,0])
				cube([1.5,1.4,0.7]);
			translate([0.75,-0.35,0])
				scale([1,2,1])
					cylinder(r=0.7, $fn=16, h=0.6);
		}
		translate([0,0.6,-0.2])
			cube([2,2,1]);
	}	
// Ruler
//	translate([-1,-1.7,0])
//		cube([0.5,2.3, 1]);
}

module right_axlebox()
{
	difference() {
		union() {
			translate([0,-0.8,0])
				cube([1.5,1.4,0.7]);
			translate([0.75,-0.35,0.1])
				scale([1,2,1])
					cylinder(r=0.7, $fn=16, h=0.6);
		}
		translate([0,0.6,-0.2])
			cube([2,2,1]);
	}	
// Ruler
//	translate([-1,-1.7,0])
//		cube([0.5,2.3, 1]);
}

module grille_unit() {
	difference() {
		union() {
			cylinder(r=0.2, h=1.2, $fn=8);
			sphere(r=0.2, $fn=8);
			translate([0,0,1.2])
				sphere(r=0.2, $fn=8);
		}
		translate([-0.3,-2, -0.5])
			cube([1, 2, 2]);
	}
}

module grilles() {
	rotate([0,90,0])
		for(i=[0:7])
			translate([0,i * 0.25, 0])
				grille_unit();
}

module body_48ds() {
	difference() {
		union() {
			// Underframe
			translate([0,0,0.25])
				cube([22.442, 3, 13.2]);
			// Underframe base wider bit
			translate([0,0,0.05])
				cube([22.442, 0.6, 13.6]);
			// Nose
			// For the motorised one we need 7.9mm
			// here so that we can get 6.9mm inside
			// allowing 0.1mm for the grooves and
			// 0.4mm min wall thickness. Breathe in...
			translate([0,2.99,2.9])
				cube([22.4, 6.7, 7.9]);
			translate([0, 10.9, 6.85])
				nose_shape();
			// Front cap
			translate([21.8, 11.2, 6.85])
				rotate([90,0,0])
					cylinder(r=0.3,h=1.2, $fn=16);
			// Back cap
			translate([11.5, 11.2, 6.85])
				rotate([90,0,0])
					cylinder(r=0.3,h=1.2, $fn=16);
			// Cab
			translate([0,2.99,0])
				cube([10, 11.3, 13.7]);
			// Exhaust
			translate([10.2, 15.8, 8])
				rotate([90,0,0])
					cylinder(r=0.3,h=12.3, $fn=16);
			translate([-0.2,-0.6,-0.1])
				buffer_beam();
			translate([23.6,3.4,1])
				rotate([0,0,180])
					buffer();
			translate([23.6,3.4,12.7])
				rotate([0,0,180])
					buffer();
			translate([22.342,-0.8,-0.1])
				buffer_beam();
			translate([-0.9,3.4,1])
				buffer();
			translate([-0.9,3.4,12.7])
				buffer();
			translate([20.342,2.9,0.25])
				buffer_bracing_front();
			translate([20.342,2.9,13.05])
				buffer_bracing_front();
			cab_roof();
			// Now fit the sand fillers
			translate([21.3, 4.5, 1.6])
				rotate([90,0,0])
					cylinder(r=0.4, h=1.8, $fn=16);
			translate([21.3,4.5, 12.1])
				rotate([90,0,0])
					cylinder(r=0.4, h=1.8, $fn=16);
			// Lights
			translate([5,14.14,6.85])
				rotate([0,90,0])
					cylinder(r=0.25, h=11, $fn=16, center=true);
			translate([-0.49, 14, 6.85])
				lamp(1);
			translate([10.49, 14, 6.85])
				lamp(0);
			// Door grooves
			if (raised_door == 1) {
				translate([8.4, 3, -0.1])
					cube([0.2, 11.3, 0.1]);
				translate([5.65, 3, -0.1])
					cube([0.2, 11.3, 0.1]);
				translate([8.4,3, 13.7])
					cube([0.2, 11.3, 0.1]);
				translate([5.65,3,13.7])
					cube([0.2, 11.3, 0.1]);
			}
			
		}
		// Cut out the cab space for the motor
		// This slices out the roof core too.
		// We'll restore that when we do the roof
		// proper later on.
		translate([0.6, -0.01, 0.75])
			cube([8.9, 18, 12.2]);
		// Cut out nose
		// We need about 6.8mm for the motor
		translate([0.5, -0.01, 3.41])
			cube([21.2, 7.5, 6.88]);
		// And the front grille space
		// Cut this down the nose to open out the
		// nose top area
		translate([1, 4.75, 4.1])
			front_grille_hole();

		// Cut out chassis space for wheels
		translate([0.5, -0.01, 0.75])
			cube([21.442, 2.5, 12.2]);
		// Cut out cab front/rear windows
		cab_windows();
		// Door grooves
		if (raised_door == 0) {
			translate([8.4, 3, 0])
				cube([0.1, 11.3, 0.1]);
			translate([5.65, 3, 0])
				cube([0.1, 11.3, 0.1]);
			translate([8.4,3, 13.6])
				cube([0.1, 11.3, 0.1]);
			translate([5.65,3,13.6])
				cube([0.1, 11.3, 0.1]);
		}
		translate([5.7, 3.9, -0.001])
			cube([2.65, 0.1,  0.1]);
		translate([5.7, 3.9, 13.601])
			cube([2.65, 0.1,  0.1]);
		// Cab side windows
		translate([1.15, 10.3, -0.05]) 
			cube([3.5, 3.5, 13.8]);
		translate([6.12, 10.3, -0.05]) 
			cube([2, 3.5, 13.8]);
		// Nose grooves
		translate([20.15,0,0])
			nose_slicer();
		translate([12.15,0,0])
			nose_slicer();
		translate([12.15, 5.71, 2.89])
			cube([8,0.1,0.1]);
		translate([12.15, 8.4, 2.89])
			cube([8,0.1,0.1]);
		translate([12.15, 5.71, 10.71])
			cube([8,0.1,0.1]);
		translate([12.15, 8.4, 10.71])
			cube([8,0.1,0.1]);
		translate([16.15, 3, 2.89])
			cube([0.1, 5.4, 0.1]);
		translate([16.15, 3, 10.71])
			cube([0.1, 5.4, 0.1]);
		// coupling slot
		translate([-1, 2.6, 6.7])
			cube([25, 1, 0.3]);
	}
	// Now add the full roof element
	roof_full();
	if (grilles == 1) {
		// Grille mesh
		translate([21.8, 3.5, 4.0])
			mesh(5.5,6.5);
		translate([12.65, 6.1, 3])
			grilles();
		translate([14.55, 6.1, 3])
			grilles();
		translate([16.75, 6.1, 3])
			grilles();
		translate([18.45, 6.1, 3])
			grilles();
		translate([12.65, 6.1, 10.7])
			grilles();
		translate([14.55, 6.1, 10.7])
			grilles();
		translate([16.75, 6.1, 10.7])
			grilles();
		translate([18.45, 6.1, 10.7])
			grilles();
	}
	// Steps
	translate([6.3, -0.2, 13.25])
		right_bodyside_step();
	translate([6.3, -0.2, -0.05])
		left_bodyside_step();
	// Axle boxes
	translate([4.82, 0, -0.2])
		left_axlebox();
	translate([15.30,0, -0.2])
		left_axlebox();
	translate([4.82, 0, 13.15])
		right_axlebox();
	translate([15.30, 0, 13.15])
		right_axlebox();
}

raised_door = 1;
grilles = 1;		// 0 for debug fast render
 
body_48ds();

//left_axlebox();
