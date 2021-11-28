
module ArcRoofFitter(w,h,l) {
	r = (h*h + (w/2) * (w/2))/(2 * h);
	intersection() {
		translate([0,r,0])
			cylinder(r = r, h = l, $fn=64);
		translate([-w/2, 0,0])
			cube([w,h,l]);
	}
}

module LowRoofArc() {
	intersection() {
		cylinder(r=26,h=63.2, $fn=64);
		translate([-8.1,-26,0])
			cube([16.2,1.5,63.2]);
	}
}

module HighRoofArc() {
	translate([0,0,11]) {
		intersection() {
			cylinder(r=14.5,h=41.2, $fn=64);
			translate([-8.1,-15,0])
				cube([16.2,3.2,41.2]);
		}
	}
}

function roofheight(d,w) = 0.03495 * pow(1.1,d);


module RoofEnd(w) {
	hull() {
		for(i=[1:23]) {
			translate([0,roofheight(i,w),i/2-0.1])
				ArcRoofFitter(16.2-2*w,2.6-w-roofheight(i,w),0.1);
		}
		translate([0,0,0])
			ArcRoofFitter(16.2-2*w,2.6-w,0.1);
	}
}

module RoofEnd2(w) {
	hull() {
		for(i=[1:23]) {
			translate([0,roofheight(i,w),(23-i)/2])
				ArcRoofFitter(16.2-2*w,2.6-w-roofheight(i,w),0.1);
		}
		translate([0,0,23/2])
			ArcRoofFitter(16.2-2*w,2.6-w,0.1);
	}
}

module Roof(w, l) {
	translate([0,0,11.5])
		ArcRoofFitter(16.2-2*w,2.6-w,l);
	translate([0,0,11.5+l])
			RoofEnd(w);
	RoofEnd2(w);
}


module RoofUnit(wt, wb, l) {
	difference() {
		Roof(0, l);
		translate([0,wt+0.01,wb])
			Roof(wt, l-2*wb);
	}
}

module ShellClipper() {
//	translate([0,-2.59,0])
//		Roof(0,60.08);
	// Clip against panelling depth not top
	translate([-7.9,0,0])
		cube([16.2-0.4,12.98, 60.08]);
}

module ShapewaysHack() {
	translate([-7.5,11.9,29.5])
		cube([15,0.8,0.8]);
}

module MainBlock() {
	translate([0,-2.59,0]) {
		RoofUnit(1, 1, 37.08);
//		translate([0,0,-0.3])
//			RoofUnit(0.3, 0, 37.68);
	}
	difference() {
		translate([-8.1,0,0])
			cube([16.2,12.98, 60.08]);
		translate([-7.1,0,1])
			cube([16.2-2,12.99,60.08-2]);
	}
	ShapewaysHack();
}

module PanelCuttingBlock(d) {
	difference() {
		translate([-8.1,-10,0])
			cube([16.2,22.98, 60.08]);
		translate([-8.1+d,-10,d])
			cube([16.2-2*d,22.99,60.08-2*d]);
	}
//	translate([0,0,-0.1])
//		ArcRoofFitter(16.2,1.5,0.3);	
//	translate([0,0,60.08-0.2])
//		ArcRoofFitter(16.2,1.5,0.3);
}


module RoundedBox(h, w, d, r) {
	translate([0, r, -d/2])
		cube([w, h-2*r, d]);
	translate([r, 0, -d/2])
		cube([w-2*r, h, d]);
	translate([r,r,-d/2])
		cylinder(r=r, h=d, $fn=32);
	translate([r,h-r,-d/2])
		cylinder(r=r, h=d, $fn=32);
	translate([w-r,r,-d/2])
		cylinder(r=r, h=d, $fn=32);
	translate([w-r,h-r,-d/2])
		cylinder(r=r, h=d, $fn=32);
}

module Panel(x,y,h,w) {
	translate([0,y,x])
		rotate([0,270,0])
			RoundedBox(h,w,20,0.5);
}

module Panelling() {
	intersection() {
		PanelCuttingBlock(0.2);
		union() {
			Panel(0.5, 8.7, 4 , 6.4);
			Panel(0.5, 6.9, 1.5, 6.4);
			Panel(0.5, 1.5, 5, 6.4);
			Panel(0.5, 0.3, 1.0, 6.4);

			Panel(12, 8.7, 4 , 31.5);
			Panel(12, 6.9, 1.5, 31.5);
			Panel(12, 1.5, 5, 31.5);
			Panel(12, 0.3, 1.0, 31.5);

			Panel(51, 8.7, 4 , 8.5);
			Panel(51, 6.9, 1.5, 8.5);

			// Four part arrangement
			Panel(51, 1.5, 5, 0.8);
			Panel(52.1, 1.5, 5, 3);
			Panel(55.4, 1.5, 5, 3);
			Panel(58.7, 1.5, 5, 0.8);


			Panel(51, 0.3, 1.0, 8.5);

			// Door
			Panel(7.5, 8.7, 3.5 , 4);
			Panel(7.5, 6.9, 1.5, 4);
//			Panel(7.5, 1.5, 5, 4);
			Panel(7.5, 0.3, 1.0, 4);

			translate([-10,0,7.1])
				cube([20,12.5,0.2]);
			translate([-10,0,11.6])
				cube([20,12.5,0.2]);
			translate([-10,12.3,7.1])
				cube([20,0.2,4.5]);
		}
	}
	// Driving End (offsets to 0)
	translate([-7.9,5.7,-0.01]) 
		cube([3.0,6.8,0.21]);
	translate([-7.9,-10,-0.01]) 
		cube([3.0,15.4,0.21]);
	// Second panel set with left window area
	translate([-4.6,5.7,-0.01]) 
		cube([2.5,6.8,0.21]);
	translate([-4.2,1.2,-0.01]) 
		cube([1.7,2.3,2]);
	translate([-4.6,3.9,-0.01]) 
		cube([2.5,1.5,0.21]);
	translate([-4.6,-10,-0.01]) 
		cube([2.5,10.5,0.21]);
	// Central(ish) panels
	translate([-1.7,5.7,-0.01]) 
		cube([2.6,6.8,0.21]);
	translate([-1.7,-10,-0.01]) 
		cube([2.6,15.4,0.21]);
	// Top panel over rest
	translate([1.2,-10,-0.01]) 
		cube([6.7,10.5,0.21]);
	// Right of right window
	translate([4.6,0.8,-0.01]) 
		cube([3.3,3.4,0.21]);
	// Door outline
	translate([1.2,4.4,-0.01]) {
		difference() {
			cube([6.7,8.0,0.21]);
			translate([0.2,0.1,-0.001])
				cube([6.3,7.8,0.212]);
		}
		translate([3.3,0,0])
			cube([0.1,8.0,0.21]);
	}
	// Window framing
	translate([-4.4,1.0,-0.01]) 
		cube([2.1,2.7,0.11]);
	translate([1.4,1.0,-0.01]) 
		cube([2.85,2.9,0.11]);
	// Trailer end - offsets 59.88
	translate([-7.8,5.8,59.88])
		cube([3.3,6.7,0.21]);
	translate([4.5,5.8,59.88])
		cube([3.3,6.7,0.21]);
	translate([-4.2,5.8,59.88])
		cube([2.6,6.7,0.21]);
	translate([-1.3,5.8,59.88])
		cube([2.6,6.7,0.21]);
	translate([1.6,5.8,59.88])
		cube([2.6,6.7,0.21]);
	// Trailer end window area (note they don't
	// 	line up with the lower panels in the
	// middle).
	translate([-7.8,0.3,59.88])
		cube([3.3,5.2,0.21]);
	translate([4.5,0.3,59.88])
		cube([3.3,5.2,0.21]);
	translate([-4.2,0.5,59.88])
		cube([2.3,5,0.21]);
	translate([-1.65,0.3,59.88])
		cube([3.3,5.2,0.21]);
	translate([1.9,0.5,59.88])
		cube([2.3,5,0.21]);
	// Top line - also not level
	translate([-7.9,-10,59.88])
		cube([15.8,10.0,0.21]);
}

module CabEndWindows() {
	translate([-4.2,1.2,-0.01]) 
		cube([1.7,2.3,2]);
	translate([1.6,1.2,-0.01]) 
		cube([2.45,2.5,2]);

	translate([-7.4,0.5,59])
		cube([2.5,4.8,2]);
	translate([4.9,0.5,59])
		cube([2.5,4.8,2]);
	translate([-1.25,0.5,59])
		cube([2.5,4.8,2]);
}


// TODO - window details
module SideWindowCut(x,l) {
	translate([-10,2.0,x+0.3])
		cube([20,1.2,l-0.6]);
	translate([-10,3.8,x+0.3])
		cube([20,2.3,l-0.6]);
}

module DoorWindowCut(x) {
	translate([-10,1.5,x])
		cube([20,5,4]);
}

module EntranceCut(x) {
	translate([-10,0,x])
		cube([20,12.2,6.1]);
}

module SideWindowCuts() {
	SideWindowCut(13.2, 9.7);
	SideWindowCut(24.1, 8.7);
	SideWindowCut(33.9, 8.7);
	DoorWindowCut(7.5);
	EntranceCut(44.1);
//	Panel(51.2, 1.5, 5, 7.8);
}

module SimplePartition(x,h) {
	translate([-10,-3,x])
		cube([20,h,0.8]);
}

module Partition(h) {
	difference() {
		translate([-10,-3,0])
			cube([20,10,0.8]);
		translate([-7.8,-10,0])
			cube([5.5,11.2,0.1]);
		translate([2.3,-10,0])
			cube([5.5,11.2,0.1]);
		translate([-7.8,1.5,0])
			cube([5.5,5.0,0.1]);
		translate([2.3,1.5,0])
			cube([5.5,5.0,0.1]);
		translate([-7.8,6.9,0])
			cube([5.5,1.5,0.1]);
		translate([2.3,6.9,0])
			cube([5.5,1.5,0.1]);
		translate([-7.8,8.7,0])
			cube([5.5,4.0,0.1]);
		translate([2.3,8.7,0])
			cube([5.5,4.0,0.1]);

		translate([-2.1,-10,0])
			cube([4.2,8.9,0.1]);
		translate([-1.8,0,-0.01])
			cube([3.6,6.5,1.2]);
		translate([-1.8,7.9,0])
			cube([3.6,4.3,0.1]);

		translate([4.1,1.7,-0.01])
			cube([3.0,4.6,1.2]);
		translate([-7.1,1.7,-0.01])
			cube([3.0,4.6,1.2]);
	}
	if (h > 14) {
		translate([1.5,7.4,-0.2])
			cylinder(r=0.2,h=0.4,$fn=16);
	}
}

module CompartmentDivision(x,h) {
	translate([0,0,x]) {
		Partition(h);
		translate([0,0,1])
			mirror([0,0,1])
				Partition(h);
	}
}

module Partitions(h,h2) {
	intersection() {
		ShellClipper();
		union() {
			CompartmentDivision(43.1, h2);
			CompartmentDivision(43.1 + 7.1, h2);
			SimplePartition(12, h);
			CompartmentDivision(23.1, h);
		}
	}
}

module SideWindowDetail(x,l) {
	translate([-10,1.7-0.01,x-0.01])
		cube([20.02,4.72,l]);
}

module SideWindows() {
	intersection() {
		PanelCuttingBlock(0.3);
		union() {
			SideWindowDetail(13.2, 9.7);
			SideWindowDetail(24.1, 8.7);
			SideWindowDetail(33.9, 8.7);
		}
	}
}

module Flap() {
	translate([0,-0.2,0.5])
		cube([0.2,0.3,0.8]);
	translate([0,-0.2,3.5])
		cube([0.2,0.3,0.8]);
	cube([0.3,4.8,4.8]);
	for(i=[1:22]) {
		translate([0,0.2,0.05 + 0.2*i])
			cube([0.4,4.4,0.1]);
	}
}

module DoorHandleUnit(x,p) {
	translate([p, 7.65, x])
		rotate([0,270,0]) {
			RoundedBox(0.3,1.1,0.4,0.15);
	      translate([0.55,0.15,0])
				cylinder(r=0.3,h=0.4, $fn=32, center=true);
		}
}

module BufferBeam() {
	difference() {
		union() {
			translate([-8,0,0]) {
				hull() {
					cube([16,0.75,0.8]);
					translate([0.75,0,0])
						cube([14.5,1.5,0.8]);
				}
			}
			translate([-0.8,0.4,-0.1])
				cube([1.6,0.7,0.2]);
			translate([-7.15,0.15,-0.2])
				cube([2.3,1.2,0.3]);
			translate([4.85,0.15,-0.2])
				cube([2.3,1.2,0.3]);
		}
		translate([-6,0.75,-0.25])
			cylinder(r=0.5,h=2,$fn=16);
		translate([6,0.75,-0.25])
			cylinder(r=0.5,h=2,$fn=16);
		translate([-0.15,0.35,-0.2])
			cube([0.3,0.8,1]);

	}
}

module ShedHinge() {
	rotate([90,0,0])
		cylinder(r=0.2,h=1.2, $fn=16);
	hull() {
		translate([0,-0.85,0])
			cube([0.4,0.5,0.2]);
		translate([2.2,-0.6,0])
			cylinder(r=0.15,h=0.2, $fn=16);
	}
}

module FrontHinges() {
	translate([1.2,6,-0.1])
		ShedHinge();
	translate([1.2,11.5,-0.1])
		ShedHinge();
	translate([8.0,6,-0.1])
		mirror([1,0,0])
			ShedHinge();
	translate([8.0,11.5,-0.1])
		mirror([1,0,0])
			ShedHinge();
}

module Chimney() {
	difference() {
		union() {
			cylinder(r=0.9, h=2, $fn=32);
			cylinder(r=1.0, h=0.2, $fn=32);
		}
		translate([0,0,-0.1])
			cylinder(r=0.3,h=2.1, $fn=32);
	}
}

module VentHoles() {
	translate([0,-5,17.8])
		rotate([270,0,0])
			cylinder(r=0.3,h=10,$fn=16);
	translate([0,-5,33.4])
		rotate([270,0,0])
			cylinder(r=0.3,h=10,$fn=16);
	translate([6.6,-5,2.2])
		rotate([270,0,0])
			cylinder(r=0.3,h=10,$fn=16);
	translate([0,-5,20.4])
		rotate([270,0,0])
			cylinder(r=0.6,h=10,$fn=16);
}

module KESRRailcar() {
	difference() {
		MainBlock();
		Panelling();
		SideWindowCuts();
		CabEndWindows();
		SideWindows();
		VentHoles();
	}
	difference() {
		translate([0,-2.59,-0.3])
			RoofUnit(0.1, 0, 37.28);
		VentHoles();
	}
	// 20,20 for full, 10,20 for half but full
	// around door
	Partitions(10,10);
	translate([7.85,1.6,1.3])
		Flap();
	translate([-7.85,1.6,1.3])
		mirror([1,0,0])
			Flap();
	DoorHandleUnit(11.1, 8.05);
	DoorHandleUnit(6.8, -8.05);
	FrontHinges();
	translate([0,12.97,0.2])
		BufferBeam();
	translate([0,12.97,59.88])
		mirror([0,0,1])
			BufferBeam();
	translate([4,-2.6,4.9])
		rotate([270,0,0])
			Chimney();
}

module RailcarChassis() {
	translate([-7.1,13,1]) {
		difference() {
			cube([14.2, 1.5, 58.08]);
			translate([1,-0.1,1])
				cube([12.2,1.7,10]);
			translate([1,1.01,-0.01])
				cube([12.2, 0.5, 58.10]);
		}
	}
}

scale([152/101,152/101,152/101])
	rotate([90,180,-15]) {
	  KESRRailcar();
		//RailcarChassis();
	};





