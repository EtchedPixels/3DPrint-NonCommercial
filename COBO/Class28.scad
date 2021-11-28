use <EndProfile.scad>;
use <EndProfileNoBB.scad>;
use <EndProfilePreCab.scad>;
use <CabEnd.scad>;
use <NoseArc.scad>;
use <CabWindows.scad>;

// TODO
// IP Buffer beam
// Bodyside detail bits if FUD
// Nose Doors
// Nose lights
// Narrow cab windows - fix wall thickness
// Roof detail and raised areas if FUD
// Underframe unit
// FUD 'detail pack'
// Scale to Farish chassis hack
// Cut in for etched sides/roof overlays
// And tweak wall thickness
// Thinner wall for FUD
// Footsteps in body side (allow for FUD
// and etched cases)
// FUD roof cooler units
// FUD - embossed handrails
// FUD - rainstrips end curve
// FUD - removable supports
// FUD - small grilles less bars and square
// Cab windows
// - Wraparound type
// - Modern type need to round top of
//   side ones more

module BodyExtrude() {
	translate([0,0,0])
		linear_extrude(height=89.32)
			scale(25.4/1200)
				EndProfile();
}


// FIXME: rescaling nosecutter is wrong
// need a revised nosecutter with earlier
// inward curves
module BufferBeamBlock() {
	difference() {
		translate([-16.8/2,-1,0])
			cube([16.8,5.5,9.5]);
		translate([-13.5/2,-2,1.6])
			cube([13.5,7.5,9.5]);
		translate([0,-2,0.9])
			scale([0.96,1,1])
				NoseCutter();
		translate([-1.25,1-0.25,-1])
			cube([2.5,0.5,5]);
		translate([-8.7,-1,-0.1])
			rotate([0,-4.5,0])
				cube([1,10,15]);
		translate([7.7,-1,-0.1])
			rotate([0,4.5,0])
				cube([1,10,15]);
	}
}

module BufferBeamCut() {
	translate([-10,-1,0]) {
		difference() {
			cube([20,5.5,9.5]);
			translate([-0.5,-0.01,5])
				cube([21,3.51,4.51]);
			translate([-0.5,0,5])
				rotate([0,90,0])
					cylinder(r=3.5,h=21,$fn=32);	
			if (FUD == 0) {
				translate([4.5,2,-2.5])
					cylinder(r=0.6,h=6,$fn=32);
				translate([15.5,2,-2.5])
					cylinder(r=0.6,h=6,$fn=32);
			}
		}
	}
}

module BufferBeam() {
	rotate([0,0,180]) {
		intersection() {
			BufferBeamBlock();
			BufferBeamCut();
		}
		if (FUD == 1) {
			translate([-5.5,1,-2.5])
				cylinder(r=0.72,h=4,$fn=32);
			translate([5.5,1,-2.5])
				cylinder(r=0.72,h=4,$fn=32);
			translate([-5.5,1,-3.75])
				cylinder(r=0.65,h=5,$fn=32);
			translate([5.5,1,-3.75])
				cylinder(r=0.65,h=5,$fn=32);
			translate([-5.5,1,-2.5])
				cylinder(r=0.9,h=0.2,$fn=32);
			translate([5.5,1,-2.5])
				cylinder(r=0.9,h=0.2,$fn=32);
			translate([-5.5,1,-3.75])
				scale([1.7,1,1])
					cylinder(r=1.1,h=0.5,$fn=32);
			translate([5.5,1,-3.75])
				scale([1.7,1,1])
					cylinder(r=1.1,h=0.5,$fn=32);
			translate([-5.5-1.75/2,1-1.75/2,-0.8])
				difference() {
					cube([1.75,1.75,2]);
					translate([0.1,0.1,-0.2])
						cube([1.55,1.55,0.3]);
				}
			translate([5.5-1.75/2,1-1.75/2,-0.8])
				difference() {
					cube([1.75,1.75,2]);
					translate([0.1,0.1,-0.2])
						cube([1.55,1.55,0.3]);
				}
		}
	}
}

module PreCab() {
	hull() {
		linear_extrude(height=0.01)
			scale(25.4/1200)
				EndProfileNoBB();
		translate([0,0,7.72])
			linear_extrude(height=0.01)
				scale(25.4/1200)
					EndProfilePreCab();
	}
}

module MainBlock() {
	translate([0,0,89.31])
		PreCab();
	BodyExtrude();
	translate([0,0,0.01])
		mirror([0,0,1])
			PreCab();
}

// Stick together the main blocks of the
// shell ready to have cabs attached then
// holes and details added
module MainShell() {
	translate([0,0,7.72]) {
		difference() {
			MainBlock();
			if (FUD == 0)
				translate([0,1.1,-0.01])
					scale([0.90,0.95,1.01])
						MainBlock();
			else // FIXME - over thick
				translate([0,1.1,-0.01])
					scale([0.90,0.95,1.01])
						MainBlock();
		}
	}
}


function curvestep(i) = (1-sin(5.5*i))*0.8;
function scaleto(a,b) = (a-b)/a;

module NoseCutter() {
	scale([1.03,1,1])
		rotate([270,0,0])
			linear_extrude(height=40)
				scale(25.4/1200)
					NoseArc();
}

module CabWindowBlock() {
	linear_extrude(height=20)
		scale(25.4/1200)
			CabWindows();
}

// Build a cab front piece
// TODO
// - Intersect with curve of front

module CabFrontBlock() {
	hull() {
		for (i=[0:16]) {
			translate([0,curvestep(i),0.1*i])
				scale([scaleto(17.0,2*curvestep(i)),
						scaleto(15.5,curvestep(i)),1])
					linear_extrude(height=0.001)
						scale(25.4/1200)
							EndProfilePreCab();
		}
	}
}

module CabFront() {
	difference() {
		CabFrontBlock();
		translate([0,-10,0.8])
			NoseCutter();
		translate([0,0.3,-10])
			CabWindowBlock();
	}
	translate([0,19.75,0])
		BufferBeam();
}

module ShellAssembly() {
	CabFront();
	translate([0,0,1.6])
		MainShell();
	translate([0,0,89.31+2*7.72+3.2])
		mirror([0,0,1])
			CabFront();
}

module ClippingAssembly() {
	translate([0,0,1.6]) {
		difference() {
			scale([1.001,1.001,1.0])
				MainShell();
			translate([0,0.4,-0.01])
				scale([scaleto(17.0,2 * 0.2),
					scaleto(15.5,0.3),1.01])
				MainShell();
		}
	}
}

module EmbossAssembly(e) {
	translate([0,0,1.6]) {
		translate([0,-e,-0.01])
			scale([scaleto(17.0,-2 * e),
					scaleto(15.5,-e),1.01])
				MainShell();
	
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

module SideWindow(n,w) {
	translate([0,4.7,n])
		rotate([0,270,0])
			RoundedBox(4.5,w,20,0.5);
}

module SideWindowL(n,w) {
	translate([-5,4.7,n])
		rotate([0,270,0])
			RoundedBox(4.5,w,10,0.5);
}

module SideWindowR(n,w) {
	translate([5,4.7,n])
		rotate([0,270,0])
			RoundedBox(4.5,w,10,0.5);
}

module GrilleMeshFUD(h,w,d) {
	n = h * 5;
	for (i = [0:n-1]) {
		translate([-d/2,i*0.2,0])
			cube([d,0.1,w]);
	}
}

module GrilleMesh(h,w,d,r) {
	if (FUD == 1)
		GrilleMeshFUD(h,w,d);
}

module Grille(n,h,w) {
	translate([0,4.7,n]) {
		difference() {
			rotate([0,270,0])
				RoundedBox(h,w,20,0.5);
			GrilleMesh(h,w,20,0.5);
			// Centre bar on big grille
			translate([-10,0,w/2-0.15])
				cube([20,h,0.3]);
		}
	}
}

module GrilleL(n,h,w) {
	translate([-5,4.7,n]) {
		difference() {
			rotate([0,270,0])
				RoundedBox(h,w,10,0.5);
			GrilleMesh(h,w,10,0.5);
		}
	}
}

module GrilleR(n,h,w) {
	translate([5,4.7,n]) {
		difference() {
			rotate([0,270,0])
				RoundedBox(h,w,10,0.5);
			GrilleMesh(h,w,10,0.5);
		}
	}
}

module CabDoorL(n) {
	translate([-10,4.5,n])
		difference() {
			cube([10,10,2.75]);
			translate([-1,0.2,0.2])
				cube([12,9.6,2.35]);
		}
}

module CabDoorR(n) {
	translate([0,4.5,n])
		difference() {
			cube([10,10,2.75]);
			translate([-1,0.2,0.2])
				cube([12,9.6,2.35]);
		}
}

module WindowCutter() {
	SideWindowR(2,2.5);
	SideWindowR(5.25,3.6);
	SideWindowR(102.176,3.6);
	SideWindowL(2,3.6);
	SideWindowL(98.684,3.6);
	SideWindowL(98.684+4.6,2.5);

	// Roof main grille hole
	translate([0,0,14.5])
		rotate([270,0,0])
			translate([0,-0.1,0])
				cylinder(r=3.25-0.8,h=3.2,$fn=32);
}

module GrilleCutter() {
	Grille(11,8.25,8);
	GrilleR(25.62,4.5,5);
	GrilleR(25.62+5.5,4.5,5);
	GrilleR(25.62+11,4.5,5.5);
	GrilleR(71.06,4.5,4);
	GrilleR(71.06+4.5,4.5,4);
	GrilleR(71.06+9,4.5,8);
	GrilleR(71.06+17.5,4.5,4);
	GrilleL(20,8.25,4.5);
}

module DoorCutter() {
	CabDoorR(20.745);
	CabDoorR(98.538);
	CabDoorL(6.25);
	CabDoorL(84.1465);
}

module SideCutter() {
	intersection() {
		union() {
			DoorCutter();
			if (FUD == 1)
				GrilleCutter();
		}
		ClippingAssembly();
	}
	if (FUD == 0)
		GrilleCutter();
	WindowCutter();
}

//FIXME - ought to curl at ends
module RainstripBars() {
	translate([0,4.5,1.5])
		cube([10,0.2,22.5]);
	translate([0,4.5,100.038-2])
		cube([10,0.2,8]);

	translate([-10,4.5,83.6435])
		cube([10,0.2,22.5]);
	translate([-10,4.5,1.5])
		cube([10,0.2,8]);
}

module Rainstrips() {
	intersection() {
		EmbossAssembly(0.2);
		RainstripBars();
	}
}

module RoofPanelsBlock() {
	translate([-7,-10,21.5])
		cube([14,30,11]);
	translate([-7,-10,21.5+11.3])
		cube([14,30,16.28]);
	translate([-7,-10,21.5+11.3+16.58])
		cube([14,30,18.55]);
	translate([-7,-10,21.5+11.3+16.58+18.85])
		cube([14,30,18.55]);
}

module RoofPanels() {
	intersection() {
		EmbossAssembly(0.1);
		RoofPanelsBlock();
	}
	translate([0,0,14.5])
		rotate([270,0,0])
			difference() {
				cylinder(r=3.25,h=2, $fn=32);
					translate([0,-0.1,0])
						cylinder(r=3.25-0.8,h=2.2,$fn=32);
			}
}



module BodyShell() {
	difference() {
		ShellAssembly();
		SideCutter();
	}
	// On the WSF polished version
	// these details are not on the print
	if (FUD == 1) {
		Rainstrips();
		RoofPanels();
	}
}

FUD = 1;
BodyShell();
//RoofPanels();

//BufferBeam();



