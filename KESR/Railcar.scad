
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
			translate([0,roofheight(i,w),i/2])
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
		translate([0,0.81,wt])
			Roof(0.8, l-2*wb);
	}
}

module MainBlock() {
	translate([0,-2.59,0]) {
		RoofUnit(0.8, 0.8, 37.08);
		translate([0,0,-0.3])
			RoofUnit(0.2, 0, 37.68);
	}
	difference() {
		translate([-8.1,0,0])
			cube([16.2,12.98, 60.08]);
		translate([-7.3,0,0.8])
			cube([16.2-1.6,12.99,60.08-1.6]);
	}
}

module PanelCuttingBlock() {
	difference() {
		translate([-8.1,0,0])
			cube([16.2,12.98, 60.08]);
		translate([-7.9,0,0.2])
			cube([16.2-0.4,12.99,60.08-0.4]);
	}
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
		PanelCuttingBlock();
		union() {
			Panel(0.5, 8.7, 4 , 6.5);
			Panel(0.5, 6.9, 1.5, 6.5);
			Panel(0.5, 1.5, 5, 6.5);
			Panel(0.5, 0.3, 1.0, 6.5);

			Panel(12, 8.7, 4 , 31.5);
			Panel(12, 6.9, 1.5, 31.5);
			Panel(12, 1.5, 5, 31.5);
			Panel(12, 0.3, 1.0, 31.5);

			Panel(51, 8.7, 4 , 8.5);
			Panel(51, 6.9, 1.5, 8.5);
			Panel(51, 1.5, 5, 8.5);
			Panel(51, 0.3, 1.0, 8.5);

			// Door
			Panel(7.5, 8.7, 4 , 4);
			Panel(7.5, 6.9, 1.5, 4);
//			Panel(7.5, 1.5, 5, 4);
			Panel(7.5, 0.3, 1.0, 4);

			
		}
	}
}

// TODO - window details
module SideWindowCut(x,l) {
	translate([-10,1.7,x])
		cube([20,4.7,l]);
}

module DoorWindowCut(x) {
	translate([-10,1.5,x])
		cube([20,5,4]);
}

module EntranceCut(x,) {
	translate([-10,0,x])
		cube([20,12.2,6]);
}

module SideWindowCuts() {
	SideWindowCut(13.2, 9.7);
	SideWindowCut(24.1, 8.7);
	SideWindowCut(33.9, 8.7);
	DoorWindowCut(7.5);
	EntranceCut(44);
}

difference() {
	MainBlock();
	Panelling();
	SideWindowCuts();
}

