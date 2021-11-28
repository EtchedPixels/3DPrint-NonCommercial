use <Shell.scad>;
use <EndProfile.scad>;
use <EndProfileLW.scad>;
use <EndProfileRW.scad>;
use <EndRails.scad>;
use <EndRails2.scad>;
use <RoofArc.scad>;
use <Footboard.scad>;
use <RadiatorBase.scad>;
use <RadiatorPillarL.scad>;
use <RadiatorPillarTL.scad>;
use <RadiatorPillarR.scad>;
use <RadiatorPillarTR.scad>;
use <RadiatorGrille.scad>;
use <RadiatorGrille2.scad>;
use <torpedo-ventilator.scad>;
use <SupportBar.scad>;

// TODO
// Rainstrip
// Interior ?
// Chassis mount

module Body() {
	translate([0,0,-0.4])
		linear_extrude(height=0.41)
		scale(25.4/1200)
			RoofArc();
	translate([0,0,-0.3])
		linear_extrude(height=0.11)
		scale(25.4/1200)
			EndRails2();
	translate([0,0,-0.2])
		linear_extrude(height=0.21)
		scale(25.4/1200)
			EndRails();
	linear_extrude(height=0.21)
		scale(25.4/1200)
			EndProfile();
	translate([0,0,0.2])
		linear_extrude(height=0.71)
		scale(25.4/1200)
			EndProfileLW();
	translate([0,0,0.9])
		linear_extrude(height=64.91)
		scale(25.4/1200)
			Shell();
	translate([0,0,65.8])
		linear_extrude(height=0.71)
		scale(25.4/1200)
			EndProfileRW();
	translate([0,0,66.5])
		linear_extrude(height=0.21)
		scale(25.4/1200)
			EndProfile();
	translate([0,0,66.7])
		linear_extrude(height=0.21)
		scale(25.4/1200)
			EndRails();
	translate([0,0,66.9])
		linear_extrude(height=0.11)
		scale(25.4/1200)
			EndRails2();
	translate([0,0,66.7])
		linear_extrude(height=0.4)
		scale(25.4/1200)
			RoofArc();

	// Radiator

	translate([0,0,66.7])
		linear_extrude(height=1.1)
			scale(25.4/1200)
				RadiatorBase();
	translate([0,0,66.7])
		linear_extrude(height=1.3)
			scale(25.4/1200)
				RadiatorGrille();
	translate([0,0,67.9])
		linear_extrude(height=0.3)
			scale(25.4/1200)
				RadiatorGrille2();

	hull() {
		translate([0,0,66.7])
			linear_extrude(height=1.1)
				scale(25.4/1200)
					RadiatorPillarTL();
		translate([0,0,66.7])
			linear_extrude(height=0.1)
				scale(25.4/1200)
					RadiatorPillarL();
	}
	hull() {
		translate([0,0,66.7])
			linear_extrude(height=1.1)
				scale(25.4/1200)
					RadiatorPillarTR();
		translate([0,0,66.7])
			linear_extrude(height=0.1)
				scale(25.4/1200)
					RadiatorPillarR();
	}

	translate([0,7.3,67.4])
		rotate([270,0,0])
			cylinder(r=0.4,h=4);

	// Footboards

	translate([0,0,11.6])
		linear_extrude(height=10.0)
		scale(25.4/1200)
			Footboard();
	translate([0,0,27.1])
		linear_extrude(height=5.2)
		scale(25.4/1200)
			Footboard();
	translate([0,0,60.2])
		linear_extrude(height=6.0)
		scale(25.4/1200)
			Footboard();
}

module RoofCutter(wall) {
	translate([0,-0.2,-0.2])
		linear_extrude(height=67.1)
			scale(25.4/1200)
				RoofArc();
}

// wall is the wall thickness shift +ve
// for inwards -ve for outwards
module BodyInside(wall) {
	scale([(18 - 2 *wall)/18,1,1])
		translate([0,0,-0.2])
			linear_extrude(height=67.1)
				scale(25.4/1200)
					Shell();
}

module BodyCut(depth) {
	BodyInside(-0.8+depth);
}

module RoundedWindow(h, w, d, r) {
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

module BodyWindow(x) {
	translate([-10,3.6,x])
		cube([20,1.3,4.8]);
	translate([-10,5.6,x])
		cube([20,5.1,4.8]);
}

module SmallWindow(x) {
	translate([-10,5.6,x])
		cube([20,5.1,3.6]);
}

module DropLightBase(x) {
	translate([-10,5.6,x])
		cube([20,5.2,3.6]);
}

module DropLight(x) {
	// Overlap so we join the parts
	difference() {
		translate([-10,5.6,x - 0.6])
			cube([20,5.1,4.8]);
		// FIXME: should be rounded
		translate([0,6.2,x + 0.3])
			rotate([0,270,0])
				RoundedWindow(4.3, 3.0, 21, 0.5);
	}
}

module DropLightL(x) {
	// Overlap so we join the parts
	difference() {
		translate([-10,5.6,x - 0.6])
			cube([10,5.1,4.8]);
		// FIXME: should be rounded
		translate([-5.5,6.2,x + 0.3])
			rotate([0,270,0])
				RoundedWindow(4.3, 3.0, 11, 0.5);
	}
}

module DropLightR(x) {
	// Overlap so we join the parts
	difference() {
		translate([0,5.6,x - 0.6])
			cube([10,5.1,4.8]);
		// FIXME: should be rounded
		translate([5.5,6.2,x + 0.3])
			rotate([0,270,0])
				RoundedWindow(4.3, 3.0, 11, 0.5);
	}
}

module DoorLine(x) {
	translate([-10,3.5,x]) {
		difference() {
			cube([20,13.89,4.3]);
			translate([-0.5,-0.01,0.19])
				cube([21,13.91,3.9]);
		}
	}
}


module DoorLines() {
	DoorLine(12.4);
	DoorLine(16.6);
	DoorLine(27.7);
	DoorLine(61.2);
}

module DoorHingeUnit(x,o, l) {
	translate([o,3.7,x])
		cube([l,0.5,0.2]);
	translate([o,14.7,x])
		cube([l,0.5,0.2]);
}

module DoorHingePairL(x) {
	DoorHingeUnit(x,-10, 20);
}

module DoorHingePairR(x) {
	DoorHingeUnit(x + 4.1, -10, 20);
}

module DoorHinge(x) {
	DoorHingeUnit(x, 0, 10);
	DoorHingeUnit(x + 4.1, -10, 10);
}

module DoorHinges() {
	DoorHingePairL(12.4);
	DoorHingePairR(16.6);
	DoorHinge(27.7);
	DoorHinge(61.2);
}

module DoorHandleUnit(x,p) {
	translate([p, 11.4, x])
		rotate([0,270,0]) {
			RoundedWindow(0.3,1.1,10,0.15);
			translate([0.55,0.15,0])
			cylinder(r=0.3,h=10, $fn=32, center=true);
		}
}

module DoorHandleL(x) {
	DoorHandleUnit(x, -10);
}

module DoorHandleR(x) {
	DoorHandleUnit(x + 3.2, 10);
}


module DoorHandles() {
	DoorHandleR(12.4);
	DoorHandleL(16.6);
	DoorHandleL(27.7);
	DoorHandleR(27.7);
	DoorHandleL(61.2);	
	DoorHandleR(61.2);
}

module HandRail(x,o) {
	translate([o,9,x])
		cube([10,6.2,0.3]);
}

module DoorRail(x,o) {
	translate([o,10.7,x])
		cube([10,2.4,0.3]);
}

module HandRails() {
	HandRail(12.4+4.3,0);
	HandRail(12.4+3.8,-10);
	DoorRail(28+4.3,0);
	DoorRail(28-0.7,-10);
}

module WindowHoles() {
		for (i=[0:4])
			BodyWindow(33.1 + 5.35 * i);
		DropLightBase(1.4);
		DropLightBase(12.8);
		SmallWindow(16.9);
		DropLightBase(28.0);
		DropLightBase(61.3);
}

// Add bars to stop FUD warping
module ShapewaysHack() {
	translate([0,0,20])
		linear_extrude(height=0.8)
			scale(25.4/1200)
				SupportBar();
				
	translate([0,0,45])
		linear_extrude(height=0.8)
			scale(25.4/1200)
				SupportBar();
		
}
module BodyAssembly() {
	difference() {
		Body();
		WindowHoles();
		intersection() {
			BodyCut(0.15);
			DoorLines();
		}
	}
	// Add the droplights, inset slightly
	intersection() {
		BodyInside(0.3);
		union() {
			DropLight(1.4);
			DropLightR(12.8);
			DropLightL(16.9);
			DropLight(28.0);
			DropLight(61.3);
		}
	}
	ShapewaysHack();
}

module RoofVentilatorHole(x) {
	translate([-4.2,0,x])
		rotate([90,-10,-10])
			cylinder(r=0.6, h=20, center=true, $fn=16);
	translate([4.2,0,x])
		rotate([90,10,10])
			cylinder(r=0.6, h=20, center=true, $fn=16);
}

module RoofVentHoles() {
	RoofVentilatorHole(2.9);
	RoofVentilatorHole(9.5);
	RoofVentilatorHole(23.5);
	RoofVentilatorHole(43.6);
	RoofVentilatorHole(54.4);
	RoofVentilatorHole(63.6);
}

module RoofVentilator(x) {
	translate([-4.2,0.3,x])
		rotate([90,0,80])
			torpedo_ventilator();
	translate([4.2,0.3,x])
		rotate([90,0,100])
			torpedo_ventilator();
}

module RoofVentilators() {
	RoofVentilator(2.9);
	RoofVentilator(9.5);
	RoofVentilator(23.5);
	RoofVentilator(43.6);
	RoofVentilator(54.4);
	RoofVentilator(63.6);
}

module RainstripPath() {
	rotate([90,0,0])
		difference() {
			cylinder(r=600, h=10, $fn=150);
			cylinder(r=599.9, h=10, $fn=150);
		}
}


module DrewryRailcar(vent, buffer, detail) {
	difference() {
		BodyAssembly();
		if (vent == 1)
			RoofVentHoles();
	}
	if (vent == 2)
		RoofVentilators();
	if (detail == 1) {
		intersection() {
			BodyInside(-0.15);
			union() {
				DoorHinges();
				DoorHandles();
				HandRails();
			}
		}
		intersection() {
			union() {
				translate([607,5,66.7/2])
					RainstripPath();
				translate([-607,5,66.7/2])
					RainstripPath();
			}
			RoofCutter();
		}
	}
}


rotate([90,180,-15]) {
	DrewryRailcar(1,1,1);
}


