// TODO
// Boiler feeds
// Later cab profile
// Later GER cab
// Springs
// Smaller westinghouse pump on tank front option
// Cab and front steps
// Whistle and pipe holes
// Optional moulded on rails and pipes
// Toolboxes (maybe as add on printed with it ?


module pipe(rad,thick, len) {
	difference() {
		cylinder(r = rad, h = len, $fn = smooth, center=true);
		if (rad - thick > 0)
			cylinder(r = rad - thick, h = len + 0.1, $fn = smooth, center=true);
	}
}

module dome(rad, rad2, height) {
	sphere(r=rad, $fn=smooth, center=true);
	// the 0.1 is a fudge factor we seem to need for
	// a clean edge
	translate([0, 0, rad-0.05])
		cylinder(r1 = rad, r2=rad2, h = height, $fn=smooth,
				center = true);
}

module flange(r1, r2) {
	intersection() {
		pipe(r1, 0.1, 8);
		translate([0, r1, 0])
			rotate([90,0,0])
				pipe(r2, 0.1, 8);
	}
}


module flanged_dome() {
	translate([0,7.75,0])
   	rotate([90,0,0])
			dome(2, 2.25, 3.5);

	difference() {
		union() {
		hull() {
				translate([0, 4.4,0])
					rotate([90,0,0])
						pipe(2.25, 0.1, 0.1);
				translate([0,-3.7,0])
					flange(8, 2.4);
			}
	
			hull() {
				translate([0,-3.7,0])
					flange(8, 2.4);
				translate([0,-1.9,0])
					flange(6, 2.7);
			}
	
			hull() {
				translate([0,-1.9,0])
					flange(6, 2.7);
				translate([0,-1,0])
					flange(5, 3.1);
			}
		}
		translate([0,-0.7,0])
			cylinder(r=4.5, h=10, center=true, $fn=smooth);
	}
	translate([0,7.25,0])
	rotate([90,0,0])
		cylinder(r=0.15,h=4.2, center=true, $fn=smooth/2);
}

module flanged_stovepipe() {
	translate([0,7.75,0])
   	rotate([90,0,0]) {
			difference() {
				cylinder(r1=1.33, r2=1.25, h=4.5, center=true, $fn=smooth);
				if (brass == 1)
					translate([0,0,-2.3])
						cylinder(r1=0.85, r2=0.8, h=1, center=true, $fn=smooth);
				else
					cylinder(r1=0.85, r2=0.8, h=4.5, center=true, $fn=smooth);
			}
		}

	difference() {
		union() {
		hull() {
				translate([0, 5.5,0])
					rotate([90,0,0])
						pipe(1.25, 0.1, 0.1);
				translate([0,-2.7,0])
					flange(8, 1.5);
			}
	
			hull() {
				translate([0,-2.7,0])
					flange(8, 1.5);
				translate([0,-0.9,0])
					flange(6, 2.1);
			}
		}

		translate([0,0.1,0])
			cylinder(r=5, h=10, center=true, $fn=smooth);
	}
}

module flanged_f4_stovepipe() {
	translate([0,7.9,0])
   	rotate([90,0,0]) {
			difference() {
				union() {
					cylinder(r1=1.33, r2=1.21, h=5, center=true, $fn=smooth);
					translate([0,0,-2.6])
					cylinder(r=1.5, h=0.3, center=true, $fn=32);
					translate([0,0,2.55])
						cylinder(r=1.25, h = 0.2, center=true, $fn=smooth);
				}
				if (brass == 1)
					translate([0,0,-3.8])
						cylinder(r1=0.9, r2=0.8, h=3, center=true, $fn=smooth);
				else
					cylinder(r1=0.9, r2=0.8, h=5.6, center=true, $fn=smooth);
			}
		}

	difference() {
		union() {
		hull() {
				translate([0, 5.26,0])
					rotate([90,0,0])
						pipe(1.25, 0.1, 0.1);
				translate([0,-2.7,0])
					flange(8, 1.3);
			}
			hull() {
				translate([0,-2.7,0])
					flange(8, 1.3);
				translate([0,-0.85,0])
					flange(6, 1.6);
			}
	
			hull() {
				translate([0,-0.85,0])
					flange(6, 1.6);
				translate([0,-0.9,0])
					flange(6, 2.1);
			}
		}

		translate([0,0,0])
			cylinder(r=5, h=10, center=true, $fn=smooth);
	}
}


//
//	Main locomotive components
//
module type34_boiler() {
	rotate([0,270,0])
		union() {
			cylinder(r=4.5, h=36, center=true, $fn=smooth*2);
			translate([0,0,-15.874])
				cylinder(r=5, h=4.77, center=true, $fn=smooth);
			translate([0, 0, -13.5])
				cylinder(r=4.751, h=0.22, center=true, $fn=smooth);
	}
	if (rivets == 1) {
		for (i = [0:59]) {
			translate([18, 4.9 * sin(i * 6), 4.9 * cos(i * 6)])
				sphere(0.2);
		}
		for (i = [0:59]) {
			translate([13.8, 4.9 * sin(i * 6), 4.9 * cos(i * 6)])
				sphere(0.2);
		}
	}
}

module type34_boiler_cutout() {
	rotate([0,270,0])
		union() {
			translate([0,0,0.5])
			cylinder(r=4, h=35.51, center=true, $fn=smooth);
			cylinder(r=0.4, h=36.7, center=true, $fn=smooth/2);
		}
}

module filler_cap() {
	if (filler_cap == 1) {
		rotate([0,90,90]) {
			cylinder(h=0.5,r=1.25, $fn=smooth*2, center=true);
			translate([0,0,0.05])
				cube([0.5,3.5,0.55], center=true);
			translate([0,1.75,-0.1])
			rotate([0,90,0])
				cylinder(r=0.2,h=1, center=true, $fn=smooth);
		}
	}
}

module cabplate() {
	intersection() {
	translate([0,9.74,0])
	difference() {
		union() {
			cube([0.5, 10, 15.25]);
			translate([0,4,3])
				rotate([0,90,0])
					cylinder(r=1.75, h=0.2, $fn=smooth, center=true);
			translate([0,4,12.25])
				rotate([0,90,0])
					cylinder(r=1.75, h=0.2, $fn=smooth, center=true);
		}
		translate([0,4,3])
			rotate([0,90,0])
				cylinder(r=1.5, h=2, $fn=smooth, center=true);
		translate([0,4,12.25])
			rotate([0,90,0])
				cylinder(r=1.5, h=2, $fn=smooth, center=true);
		
	}
	translate([0, -30.1 + 17, 15.25/2])
		rotate([0,90,0])
			cylinder(r=30.1, h=1, center=true, $fn = smooth*2);
	}
}

module cab_window_ger() {
	// Undo the centering effect
	translate([4.5,2.5,10]) {
		cube([7, 5, 20], center=true);
		cube([9, 3, 20], center=true);
		translate([-3.5,-1.5,0])
			cylinder(r=1, h=20, center=true, $fn=smooth/2);
		translate([-3.5,1.5,0])
			cylinder(r=1, h=20, center=true, $fn=smooth/2);
		translate([3.5,-1.5,0])
			cylinder(r=1, h=20, center=true, $fn=smooth/2);
		translate([3.5,1.5,0])
			cylinder(r=1, h=20, center=true, $fn=smooth/2);
	}
}

// Produce the curves that flow the cab onto the
// tanks
module cab_flow_l() {
	// Make them easy to position
	translate([0,0,0])
		difference() {
			cube([2,2,0.5]);
			translate([2,2,-0.1])
				cylinder(r=2, h=0.7, $fn=smooth);
		}
}

module cab_flow_r() {
	translate([0,0,0])
		difference() {
			cube([2,2,0.5]);
			translate([0,2,-0.1])
				cylinder(r=2, h=0.7, $fn=smooth);
		}
}

module cab_sides() {
	difference() {
		union() {
			translate([10,9.74, 0.875])
				cube([17, 6, 0.5]);
			translate([10,9.74, 17-0.875-0.5])
				cube([17, 6, 0.5]);
		}
		translate([11.5,9.739, 0])
			cab_window_ger();
	}
	translate([10-2, 9.74, 0.875])
		cab_flow_r();
	translate([10 + 17, 9.74, 0.875])
		cab_flow_l();
	translate([10-2, 9.74, 17 - 0.5 - 0.875])
		cab_flow_r();
	translate([10 + 17, 9.74, 17 - 0.5 - 0.875])
		cab_flow_l();
}

// Intersect with the cube to keep a thickness on
// the roof edges
module ger_roof_band() {
	intersection() {
		difference() {
			cylinder(r=30.2, h=0.5, center=true, $fn=smooth*2);
			cylinder(r=29.6, h=0.6, center=true, $fn=smooth*2);
			translate([0,-1.75,0])
				cube([64,60.4,1], center=true);
		}
		translate([0,30.2 - 0.75,0])
			cube([17,2,0.6], center=true);
	}
}

// Intersect with the cube to keep a thickness on
// the roof edges
module ger_roof() {
 	translate([8.5 + 10, -30.1 + 17, 8.5]) {
		rotate([0,90,0]) {
			intersection() {
				difference() {
					cylinder(r=30.1, h=17.5, center=true, $fn=smooth*2);
					cylinder(r=29.6, h=17.6, center=true, $fn=smooth*2);
					translate([0,-1.75,0])
						cube([64,60.2,18], center=true);
				}
				translate([0,30.1 - 0.75,0])
					cube([17,2,18], center=true);
			}
			translate([0,0,8.25])
				ger_roof_band();
			translate([0,0,-8.25])
				ger_roof_band();
			translate([0,0,2.5])
				ger_roof_band();
			translate([0,0,-3])
				ger_roof_band();
		}
	}
}

module steam_dome() {
	rotate([90,0,0])
	difference() {
		union() {
			cylinder(r=0.2,h=4.2, center=true, $fn=smooth);
			sphere(r=2, $fn=smooth);
			translate([0,0,1.9])	
				cylinder(r1=2, r2=2.125, h=3.5, center=true, $fn=32);
		}
		sphere(r=1.5, $fn=smooth);
		translate([0,0,1.9])
			cylinder(r1=1.5, r2=1.625, h=3.51, center=true, $fn=smooth);
	}
}

// Do GER for now
module buffer() {
	rotate([0,90,0]) {
		translate([0,0,-0.95])
			cylinder(r=1,h=0.1, $fn=smooth/2, center=true);
		cylinder(r=0.75, h=2, $fn=smooth/2, center=true);
		translate([0,0,1.24])
			cylinder(r=0.5, h=1, $fn=smooth/2, center=true);
		translate([0,0,1.735])
			cylinder(r=1.25,h=0.4, $fn=smooth, center=true);
	}
}

// Do GER for now
module buffer_hole() {
	rotate([0,90,0])
			cylinder(r=0.4,h=1, $fn=smooth/2, center=true);
}

module front_buffer_beam() {
	cube([0.5, 3, 17]);
	if (ger_buffers == 1) {
		translate([1.5, 1.5, 2.5])
			buffer();
		translate([1.5, 1.5, 17 - 2.5])
			buffer();
	}
}

module front_buffer_beam_cut() {
	if (buffer_holes == 1) {
		translate([0, 1.5, 2.5])
			buffer_hole();
		translate([0, 1.5, 17 - 2.5])
			buffer_hole();
	}
	translate([0, 1.5, 8.25])
		cube([1.5, 1.5, 0.5], center=true);
}

module back_buffer_beam() {
	translate([0.5,0,17]) {
		rotate([0,180,0]) {
			cube([0.5, 3, 17]);
			if (ger_buffers == 1) {
				translate([1.5, 1.5, 2.5])
					buffer();
				translate([1.5, 1.5, 17 - 2.5])
					buffer();
			}
		}
	}
}

module back_buffer_beam_cut() {
	if (buffer_holes == 1) {
		translate([0,0,17])
			rotate([0,180,0]) {
				translate([0, 1.5, 2.5])
					buffer_hole();
				translate([0, 1.5, 17 - 2.5])
					buffer_hole();
			}
	}
	translate([-0.1, 1.5, 8.25])
		cube([1.5, 1.5, 0.5], center=true);
}

module solebar_end_l() {
	difference() {
		cube([5, 1.75, 0.5]);
		translate([0,0,-0.05])
		scale([2.86,1,1])
			cylinder(r=1.75, h=0.6, $fn=smooth/2);
	}
}

module solebar_end_r() {
	difference() {
		cube([5, 1.75, 0.5]);
		translate([5,0,-0.05])
		scale([2.86,1,1])
			cylinder(r=1.75, h=0.6, $fn=smooth/2);
	}
}

module solebar_ends() {
	translate([0,-1.75,0.15])
		solebar_end_r();
	translate([0,-1.75,16.35])
		solebar_end_r();
	translate([59.5,-1.75,0.15])
		solebar_end_l();
	translate([59.5,-1.75,16.35])
		solebar_end_l();

}


// F5
module under_boiler_f5() {
	difference() {
		union() {
			cube([13, 0.6, 8.5]);
			translate([6.5,0,0])
				cube([6.5, 1.0, 8.5]);
		}
		translate([13,1,-0.05])
			cylinder(r=1, h=8.6, $fn=smooth/2);
		translate([6.5,1.1, -0.05])
			cylinder(r=0.5, h=8.6, $fn=smooth/2);
	}
	if (rivets == 1) {
		for(i=[0:5]) {
			translate([7.5 + i/1.25, 0.35 + i/30, 0.2])
				sphere(r=0.3, center=true);
			translate([7.5 + i/1.25, 0.35 + i/30, 8.3])
				sphere(r=0.3, center=true);
		}
	}
}

// First 30 locomotives, as built
module under_boiler_f4_cyls() {
	cube([12, 0.6, 8.5]);
	translate([6.5,0,0])
		cube([5.5, 1.0, 8.5]);
	translate([11.9,0,0]) {
		intersection() {
			cube([1,1,8.5]);
			union() {
				translate([0,-0.5,4.25+1.5])
					rotate([0,90,0])
						cylinder(r=1.5,h=0.2,$fn=smooth);
				translate([0,-0.5,4.25-1.5])
					rotate([0,90,0])
						cylinder(r=1.5,h=0.2,$fn=smooth);
			}
		}
	}
	if (rivets == 1) {
		for(i=[0:5]) {
			translate([7.5 + i/1.25, 0.35 + i/30, 0.2])
				sphere(r=0.3, center=true);
			translate([7.5 + i/1.25, 0.35 + i/30, 8.3])
				sphere(r=0.3, center=true);
		}
	}
}

// First 30 locomotives with different covers
module under_boiler_f4_early() {
	under_boiler_f5();
	hull() {
		translate([12.0,0.5,1])
				cylinder(h=6.5,r=0.5,$fn=smooth);
//			cube([5.0, 1.0, 6.5]);
		translate([7.5,0,1])
			cube([5.52, 0.1, 6.5]);
	}
	difference() {
		translate([7.5,0,1])
			cube([5.8, 0.3, 6.5]);
		translate([13.3,0.5,0.95])
			cylinder(h=6.6,r=0.5,$fn=smooth);
	}
}

module under_boiler() {
	if (boiler == 3 || early_loco != 1)
		under_boiler_f5();
	else if (cylinder_covers == 1)
		under_boiler_f4_cyls();
	else
		under_boiler_f4_early();
}


module coal_lip() {
	difference() {
		cube([1, 2.5, 15.25]);
		translate([-2.5,0,-0.05])
			cylinder(r=3.5, h=15.35, $fn=smooth/2);
	}
}

module coal_lip_clip() {
	difference() {
		cube([1, 2.5, 14.25]);
		translate([-2.5,0,-0.05])
			cylinder(r=3.5, h=14.35, $fn=smooth/2);
	}
}

module coal_rail_block() {
	if (coal_rails == 1 || coal_rails == 2) {
		difference() {
			union() {
				translate([0.2,0,0.2])
					cube([9.3,2.5,14.85]);
				for(i=[0:3]) {
					translate([0,i * 0.7, 0])
						cube([9.5,0.4, 15.25]);
				}
			}
			translate([0.7, 0, 0.7])
				cube([8.9,2.6,13.85]);
		}
	}
}

module westinghouse_pump_8()
{
	rotate([90,0,0]) {
		translate([0,-0.4,-0.8])
			cube([0.8, 0.8, 0.8]);
		translate([0,0,2.625/2])
			cylinder(r=0.9, h=2.625, center=true, $fn=smooth);
		translate([0,0,2.6])
			cylinder(r=0.3, h=6.8, center=true, $fn=smooth);
		translate([0,0, 6 - 1.125])
			cylinder(r=0.85, h=2.25, center=true, $fn=smooth);

		translate([0.4,0.0,-1.5])
			cylinder(r=0.25, h=0.9, $fn=smooth/2);
		translate([-0.3,0, 5.6])
			cylinder(r=0.25, h=0.9,$fn=smooth/2);
		translate([0.3,-0, 5.6])
			cylinder(r=0.25, h=0.9,$fn=smooth/2);
	
		translate([0,-0.7,1.4])
			rotate([0,90,0])
				cylinder(r=0.3, h=3, $fn=smooth/2, center=true);
		translate([1, 0, 5])
			rotate([0,90,0])
				cylinder(r=0.3, h=0.5, $fn=smooth/2, center=true);
		translate([-0.8,-1,0])
			cube([0.9, 0.4, 4.2]);
		translate([-0.8,-1,0])
			cube([0.4, 0.9, 4.2]);
	}
}

module pipetop() {
	rotate([90,0,0]) {
		cylinder(r=0.5, h=0.6, $fn=smooth/2, center=true);
		translate([0,0,-0.2])
			cylinder(r=0.6, h=0.2, $fn=smooth/2, center=true);
		translate([0,0,-0.1])
			cylinder(r=0.2, h=0.8, $fn=smooth/2, center=true);
	}
}

module sand_fillers() {
	translate([48,1.4, 8.5 - 4.75])
		pipetop();
	translate([48,1.4, 8.5 + 4.75])
		pipetop();
}

// Create the space volume to cut the step into
module bodyside_step() {
	if (bunker_step == 1)
		translate([0,0,0])
			cube([2.5, 1.75, 0.51]);
	if (bunker_step == 2)
		translate([0.5,0,0.5])
			cube([1.5, 0.4, 1]);
}

// and cut the step
module bodyside_step_cut() {
	if (bunker_step ==1)
		translate([0.5, 0.5, 0.51])
			cube([1.5,0.75,0.5]);
}

module ramsbottom_block() {
	cube([1.75, 2.5, 1.9], center=true);
	cube([2.75, 2.5, 0.9], center=true);
	translate([-0.875,0,0.45])
		rotate([90,0,0])
			cylinder(r=0.5,h=2.5, $fn=smooth/2, center=true);
	translate([-0.875,0,-0.45])
		rotate([90,0,0])
			cylinder(r=0.5,h=2.5, $fn=smooth/2, center=true);
	translate([0.875,0,0.45])
		rotate([90,0,0])
			cylinder(r=0.5,h=2.5, $fn=smooth/2, center=true);
	translate([0.875,0,-0.45])
		rotate([90,0,0])
			cylinder(r=0.5,h=2.5, $fn=smooth/2, center=true);
	translate([0,-1.99, 0]) {
		cube([2.5, 2, 3.2], center=true);
		cube([4, 2, 1.7], center=true);
		translate([-1.25,0,0.85])
			rotate([90,0,0])
				cylinder(r=0.75,h=2, $fn=smooth/2, center=true);
		translate([-1.25,0,-0.85])
			rotate([90,0,0])
				cylinder(r=0.75,h=2, $fn=smooth/2, center=true);
		translate([1.25,0,0.85])
			rotate([90,0,0])
				cylinder(r=0.75,h=2, $fn=smooth/2, center=true);
		translate([1.25,0,-0.85])
			rotate([90,0,0])
				cylinder(r=0.75,h=2, $fn=smooth/2, center=true);
	}
	translate([0, 1.25, 0]) {
		cube([2, 0.2, 2.15], center=true);
		cube([3, 0.2, 1.55], center=true);
		translate([-1.025,0,0.5875])
			rotate([90,0,0])
				cylinder(r=0.5,h=0.2, $fn=smooth/2, center=true);
		translate([-1.025,0,-0.5875])
			rotate([90,0,0])
				cylinder(r=0.5,h=0.2, $fn=smooth/2, center=true);
		translate([1.025,0,0.5875])
			rotate([90,0,0])
				cylinder(r=0.5,h=0.2, $fn=smooth/2, center=true);
		translate([1.025,0,-0.5875])
			rotate([90,0,0])
				cylinder(r=0.5,h=0.2, $fn=smooth/2, center=true);
	}
	translate([-0.75,1.0,-0.5])
		rotate([90,0,0])
			cylinder(r=0.4, h=1, $fn=smooth/2, center=true);
	translate([0.75,1.0,-0.5])
		rotate([90,0,0])
			cylinder(r=0.4, h=1, $fn=smooth/2, center=true);
	translate([-0.75,1.0,0.5])
		rotate([90,0,0])
			cylinder(r=0.4, h=1, $fn=smooth/2, center=true);
	translate([0.75,1.0,0.5])
		rotate([90,0,0])
			cylinder(r=0.4, h=1, $fn=smooth/2, center=true);

}

module ramsbottom_round() {
//	translate([0,7.75,0])
//		foo();

	difference() {
		union() {
		hull() {
				translate([0, 4.6,0])
					rotate([90,0,0])
						pipe(2, 0.1, 0.3);
				translate([0,-3.7,0])
					flange(8, 2);
			}
	
			hull() {
				translate([0,-3.7,0])
					flange(8, 2);
				translate([0,-1.9,0])
					flange(6, 2.3);
			}
	
			hull() {
				translate([0,-1.9,0])
					flange(6, 2.3);
				translate([0,-1,0])
					flange(5, 2.7);
			}
		}
		translate([0,-0.7,0])
			cylinder(r=4.5, h=10, center=true, $fn=smooth);
	}
	hull() {
		translate([0,7.2,1])
			rotate([90,0,0])
				cylinder(r=0.5,h=2.7,$fn=smooth);
		translate([0,7.2,-1])
			rotate([90,0,0])
				cylinder(r=0.5,h=2.7,$fn=smooth);
	}
}

module ramsbottom() {
	// The F5 has a different arrangement
	if (boiler == 3)
		translate([36.5,13.5, 8.5])
			ramsbottom_block();
	else // F4 - round flanged base, further back
		translate([30,8.1, 8.5])
			rotate([0,90,0])
				ramsbottom_round();
}


module tankfront_step() {
	cube([1.1, 0.4, 1]);
}

module front_frame_core() {
	difference() {
		union() {
			translate([0,-1,0])
				cube([15.5, 6, 4.5]);
		}
		translate([0, -1, 1])
			cube([15.5, 5, 2.5]);
		translate([5, 3, -0.5])
			cylinder(r=0.85, h=5.5, $fn=smooth/2);
		translate([4.15,  3, -0.5])
			cube([1.7, 3, 5]);
		translate([12,  6, -0.5])
			cylinder(r=5, h=5.5, $fn=smooth);
		translate([8.5, 2.5, -0.5])
			cube([7.5, 2.5, 5.5]);
	}
	translate([3.4,0, -0.5])
			cube([0.75, 6, 5]);
	translate([5.85,0, -0.5])
			cube([0.75, 6, 5]);
	translate([6,0,0]) {
		difference() {
			cube([9.5, 2.5, 4.5]);
			translate([0,0,1])
				cube([9.5, 2.5, 2.5]);
		}
	}
}

module front_frames() {
	render() {
		intersection() {
			difference() {
				front_frame_core();
					translate([15, 6, -0.5])
						cylinder(r=5, h=5.5, $fn=smooth);
			}
			cube([15.5, 5, 4.5]);
		}
	}
}

module dome_fitting_f5() {
	// Put the dome on the boiler
	if (steam_dome == 1)
		translate([48.5,15.5,8.5])
			steam_dome();
	if (steam_dome == 2)
		translate([48.5,8.1,8.5]) {
			rotate([0,90,0])
				flanged_dome();
		}
}

module dome_fitting_f4_w() {
	// Put the dome on the boiler
	if (steam_dome == 1)
		translate([44,15.5,8.5])
			steam_dome();
	if (steam_dome == 2)
		translate([44,8.1,8.5]) {
			rotate([0,90,0])
				flanged_dome();
		}
}

module dome_fitting_f4_h() {
	// Put the dome on the boiler
	if (steam_dome == 1)
		translate([48.5,15.5,8.5])
			steam_dome();
	if (steam_dome == 2)
		translate([48.5,8.1,8.5]) {
			rotate([0,90,0])
				flanged_dome();
		}
}

module dome_fitting() {
	if (boiler == 1)
		dome_fitting_f4_w();
	if (boiler == 2)
		dome_fitting_f4_h();
	if (boiler == 3)
		dome_fitting_f5();
}


// 6 inch steam pipes
module condensing_pipe() {
	if (condensing == 1) {
		sphere(r=0.5,$fn=smooth);
		cylinder(r=0.5,h=18,$fn=smooth);
		rotate([30,90,0])
			cylinder(r=0.5,h=4,$fn=smooth);
		translate([0,0,18]) {
				cylinder(r=0.7,h=0.4,$fn=smooth);
				sphere(r=0.5, $fn=smooth);
		}
		translate([0,0,18])
			rotate([0,-17,0])
				cylinder(r=0.5,h=4.3,$fn=smooth);
		translate([-1.21,-2,22]) {
			rotate([0,73,0]) {
				intersection() {
					rotate_extrude($fn=smooth)
						translate([2,0,0])
							circle(r=0.5, $fn=smooth);
					translate([-3,0,-1.5])
						cube([3,3,3]);
				}
			}
		}
	}
}

module smokebox_shape() {
	scale([4.25,4.25,0.5]) 
		sphere(r=1,$fn=smooth);
	if (smokebox_door == 1)
			cylinder(r=4.25,h=1,$fn=smooth);
	else
			cylinder(r=4.3,h=1,$fn=smooth);
}

module smokebox_shape_mask() {
	scale([4.25,4.25,0.5]) 
		sphere(r=1,$fn=smooth);
	cylinder(r=5,h=1,$fn=smooth);
}

module smokebox() {
	smokebox_shape();
	intersection() {
		union() {
			translate([0,1,-3])
				cube([5,0.3,5]);	
			translate([0,-1,-3])
				cube([5,0.3,5]);
			translate([0,0,-3])
				cylinder(r=0.2,h=3,$fn=smooth);

		}
		translate([0,0,-0.2])
			smokebox_shape_mask();
	}
	intersection() {
		union() {
			translate([0,0,-3])
				cube([0.3,2,5]);	
			translate([0,0,-3])
				rotate([0,0,-30])
					cube([0.3,2,5]);	
			translate([0,0,-3])
				cylinder(r=0.5,h=3,$fn=smooth);

		}
		translate([0,0,-0.4])
			smokebox_shape_mask();
	}
	translate([4.6,-1.625,-0.3])
		rotate([270,0,0])
			cylinder(r=0.2,h=3.25,$fn=smooth);
	translate([4.4,-1,-0.3])
		cube([0.5,2,1]);
}

module moulded_rails() {
	if (handrails == 1) {
		translate([27,9.8,4.6])
			cube([31,0.3,0.6]);
		translate([27,9.8,4.2+7.6])
			cube([31,0.3,0.6]);
	}
	if (handrails == 2) {
		translate([27,9.8,4.6])
			cube([32.71,0.3,0.6]);
		translate([27,9.8,4.2+7.6])
			cube([32.71,0.3,0.6]);
		translate([22.5+32.7,9.8,4])
			cube([5.5,0.3,0.8]);
		translate([22.5+32.7,9.8,4.2+8])
			cube([5.5,0.4,0.8]);
		translate([27+32.7,7.8,8.5]) {
			rotate([0,90,0]) {
				difference() {
					cylinder(r=4.5,h=1,$fn=smooth);
					translate([0,0,-0.01])
						cylinder(r=4.2,h=1.1,$fn=smooth);
					translate([-8.5,-7.8,-1])
						cube([17,9.8,3]);
				}
			}
		}
	}
}

module LeadingSpring() {
	translate([-0.25,0,0])
		cube([0.5,1.5,1.0]);
	translate([3.15,0,0.4])
		cube([0.5,1.5,0.6]);
	translate([-3.65,0,0.4])
		cube([0.5,1.5,0.6]);
	translate([3.65,1.2,0.2])
		cylinder(r=0.55, $fn=smooth,h=0.8);
	translate([-3.65,1.2,0.2])
		cylinder(r=0.55, $fn=smooth,h=0.8);
	for(i=[0:3]) {
		hull() {
			translate([-1-i-0.2,i*0.3+0.3,0.4])
				cube([0.2,0.3,0.6]);
			translate([0,i*0.28+0.24,0.4])
				cube([0.2,0.3,0.6]);
		}
		hull() {
			translate([1+i,i*0.3+0.3,0.4])
				cube([0.2,0.3,0.6]);
			translate([-0.2,i*0.28+0.24,0.4])
				cube([0.2,0.3,0.6]);
		}
	}

	for(i=[0:3]) {
		hull() {
			translate([-1-i-0.2,i*0.3+0.3,0.2])
				cube([0.2,0.15,0.8]);
			translate([0,i*0.28+0.24,0.2])
				cube([0.2,0.15,0.8]);
		}
		hull() {
			translate([1+i,i*0.3+0.3,0.2])
				cube([0.2,0.15,0.8]);
			translate([-0.2,i*0.28+0.24,0.2])
				cube([0.2,0.15,0.8]);
		}
	}
}

module f5_floor() {
	difference() {
		union() {
			// Floor
			cube([64.5,1.25, 17]);
			// Tank/lower cab block
			// cut out the ridges while we are at it
			// as it is easier to do it here
			difference() {
				translate([1.5,0.75,0.875])
					cube([44.25,9,15.25]);
				// FIXME - align
				translate([27, 9.5, 0.875 + 0.4])
					cube([18.4,0.3, 15.25-0.8]);
			}
			// Filler caps
			translate([43, 9.5, 2.75])
				filler_cap();
			translate([43, 9.5, 17 -2.75])
				filler_cap();
			// boiler support main block
			translate([55.4,1,5.25])
				cube([4.75,3.5,6.5]);
			if (rivets == 1) {
				for (i = [0:3]) {
					translate([55.6,2.5 + 0.32 * i,5.15])
						sphere(r=0.2);
				}
				for (i = [0:3]) {
					translate([59.95,2.5 + 0.32 * i, 5.15])
						sphere(r=0.2);
				}
				for (i = [0:3]) {
					translate([55.6,2.5 + 0.32 * i,17 - 5.15])
						sphere(r=0.2);
				}
				for (i = [0:3]) {
					translate([59.95,2.5 + 0.32 * i,17 - 5.15])
						sphere(r=0.2);
				}
			}
			// boiler support long piece
			translate([48.2, 1.24, 4.25])
				under_boiler();
			// Add the boiler
			translate([42,7.5,8.5])
				type34_boiler();
			// Front and rear cab plates
			translate([10, 0, 0.875])
				cabplate();
			translate([27, 0, 17-0.875])
				rotate([0,180,0])
					cabplate();
			solebar_ends();
			translate([0.51, 4.75 + 2.5, 0.875]) 
				coal_lip();
			translate([0.5, 9.74, 0.875])
				coal_rail_block();
			if (westinghouse_pump == 8)
				translate([53,8.5,17-3.25])
					westinghouse_pump_8();
			sand_fillers();
			translate([64,-1.75,0])
				front_buffer_beam();
			translate([0,-1.75,0])
				back_buffer_beam();

			// We want the bottom of the valves
			// cleaned up by the boiler cut so do
			// it now
			if (ramsbottom_valves == 1)
					ramsbottom();
			translate([58,10.8,4.9])
				rotate([0,270,0])
					condensing_pipe();
			translate([58,10.8,12.3])
				mirror([0,0,1])
					rotate([0,270,0])
						condensing_pipe();
			if (handrails != 0)
				moulded_rails();
		}
		// Cab doors and across
		translate([13.5,1.25,0])
			cube([3.5,8.51,17]);
		// Take middle out of tanks, leave thickness 
		// for ridges on tank edge
		translate([11.25,-0.01,0.875 + 0.5])
			cube([34,9,14.25]);
		// Take the top off the cab space
		translate([10.5,1.25, 0.875 + 0.5])
			cube([16, 9, 14.25]);
		// Trim centre of boiler area
		translate([42,7.5,8.5])
			type34_boiler_cutout();
		// Take centre out of boiler support block
		translate([55.9, -0.5, 5.75])
			cube([3.75, 6.5,5.5]);
		// Solebars
		translate([0.15, -0.01, -0.01])
			cube([64.2, 1.1, 0.11]);
		translate([0.15, -0.01, 16.91])
			cube([64.2, 1.1, 0.11]);
		// Coal under
		translate([2.0,-0.01,0.875 + 0.5])
			cube([10, 10, 14.25]);
		// Coal over
		translate([2.0,9.5,0.875 + 0.5])
			cube([8, 2, 14.25]);
		// Peg for steam dome
		if (steam_dome == 0) {
			translate([48.5,14.5,8.5])
				rotate([90,0,0])
					cylinder(r=0.5,h=8, $fn=smooth/2);
		}
		if (funnel == 0) {
			translate([57.5,14.5,8.5])
				rotate([90,0,0])
					cylinder(r=0.5,h=8, $fn=smooth/2);
		}
		translate([1.0, 4.75 + 2.5, 0.875 + 0.5])
			coal_lip_clip();
		translate([64,-1.75,0])
			front_buffer_beam_cut();
		translate([0,-1.75,0])
			back_buffer_beam_cut();
		translate([7.75, 6, 17-1.875])
			bodyside_step_cut();
		// Wheel clearances
		translate([49,-0.01,0.5])
			cube([8, 0.75, 5.75]);
		translate([49,-0.01,10.75])
			cube([8, 0.75, 5.75]);
		// Lumpy bit on 14xx motor block
		translate([42,-0.1, 6])
			cube([5, 6, 5]);

	}
	// Now start adding the other bits
	// Coal lip/coal join fixup
//	translate([1.5,8.0,0.875 + 0.5])
//		cube([5, 0.5, 14.25]);
	// Cab sides (these depend upon the loco
	// eventually)
	cab_sides();
	ger_roof();
	// Put the dome on the boiler

	dome_fitting();

	if (funnel == 1) {
		translate([57.9,7.3,8.5]) {
			rotate([0,90,0])
				flanged_stovepipe();
		}
	}
	if (funnel == 2) {
		translate([57.9,7.5,8.5]) {
			rotate([0,90,0])
				flanged_f4_stovepipe();
		}
	}

	if (smokebox_door != 0) {
		translate([60.3,7.5,8.5])
			rotate([0,90,180])
				smokebox();
	}

	translate([7.75, 6, 17-1.875])
			bodyside_step();
	translate([45.5, 5.5, 1.825])
		tankfront_step();
	if (right_tank_step == 1) {
		translate([45.5, 5.5, 16-1.825])
			tankfront_step();
	}
	translate([48.51,-0.01, 17-6.25])
		rotate([180,0,0]) {
			difference() {
				cube([15.5, 6, 4.5]);
			difference () {
				cube([15.5, 6, 4.5]);
				front_frames();
			}
		}
	}
	translate([53,1.8,4])
		LeadingSpring();
	translate([53,1.8,13])
		mirror([0,0,1])
			LeadingSpring();
}
