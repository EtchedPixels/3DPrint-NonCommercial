include <BUTprofile.scad>;
include <BUTprofileSkirtless.scad>;
include <BUTprofileEnd.scad>;
include <BUTprofileSkirt.scad>;
include <BUTprofileSkirtL.scad>;
include <BUTprofileSkirtR.scad>;
include <BUTprofileInside.scad>;
include <BUTprofileInsideSkirtless.scad>;
include <BUTprofileInsideEnd.scad>;
include <BUTprofile.scad>;
include <BUTprofileRoof.scad>;
include <BUTprofileRoofLine.scad>;
include <BUTprofileBar.scad>;

//	TODO
// Window type choices
// Rivets on buffer beam
// No recess for guards doors
// Choice of ventilators/skirts ?
//
module BodyShellInside() {
	hull() {
		linear_extrude(height=0.1)
			scale(25.4/1200)
				BUTprofileInsideEnd();
		translate([0,0,2.4])
			linear_extrude(height=0.11)
				scale(25.4/1200)
					BUTprofileInsideSkirtless();
	}
	translate([0,0,2.5])
		linear_extrude(height=72)
			scale(25.4/1200)
					BUTprofileInside();
	hull() {
		translate([0,0,74.4])
			linear_extrude(height=0.11)
				scale(25.4/1200)
					BUTprofileInsideSkirtless();
		translate([0,0,76.9])
			linear_extrude(height=0.1)
				scale(25.4/1200)
					BUTprofileInsideEnd();
	}
}

module CornerClipper() {
	rotate([0,45,0])
		cube([5,2.5,5]);
}

module BodyShellOutside() {
	hull() {
		linear_extrude(height=0.1)
			scale(25.4/1200)
				BUTprofileEnd();
		translate([0,0,2.4])
			linear_extrude(height=0.11)
				scale(25.4/1200)
					BUTprofileSkirtless();
	}
	translate([0,0,2.5])
		linear_extrude(height=72)
			scale(25.4/1200)
					BUTprofile();
	hull() {
		translate([0,0,74.4])
			linear_extrude(height=0.11)
				scale(25.4/1200)
					BUTprofileSkirtless();
		translate([0,0,76.9])
			linear_extrude(height=0.1)
				scale(25.4/1200)
					BUTprofileEnd();
	}
	difference() {
		union() {
			linear_extrude(height=2.5)
				scale(25.4/1200)
					BUTprofileRoof();
			translate([0,0,74.5])
				linear_extrude(height=2.5)
					scale(25.4/1200)
						BUTprofileRoof();
		}
		union() {
			translate([6.9,0,-0.01])
				CornerClipper();
			translate([-6.9-3.53-3.53,0,-0.01])
				CornerClipper();
			translate([6.9,0,77.01])
				CornerClipper();
			translate([-6.9-3.53-3.53,0,77.01])
				CornerClipper();
		}
	}
}


module Buffer(t) {
	if (detail == t) {
			cylinder(r1=0.6, r2=0.5, h=1.75, $fn=32);
			translate([0,0,1.46])
				cylinder(r=0.4, h=1.3, $fn=16);
			translate([0,0,2.6])
				cylinder(r=1.03,h=0.35, $fn=32);
	}
}

module BufferBeams() {
	translate([-6.9,14.5,-0.3]) {
			cube([13.8,1.5,1.5]);
			translate([1.15, 0.75, 0.01])
				mirror([0,0,1])
					Buffer(1);
			translate([11.5+1.15,0.75,0.01])
				mirror([0,0,1])
					Buffer(1);
	}
	translate([-6.9,14.5,75.8]) {
		cube([13.8,1.5,1.5]);
			translate([1.15, 0.75, 1.45])
					Buffer(1);
			translate([1.15+11.5,0.75,1.45])
					Buffer(1);
	}
}

module BufferHoles() {
	translate([-6.9,14.5,-0.3]) {
			translate([1.15, 0.75, 0.01])
				mirror([0,0,1])
					Buffer(2);
			translate([11.5+1.15,0.75,0.01])
				mirror([0,0,1])
					Buffer(2);
	}
	translate([-6.9,14.5,75.8]) {
			translate([1.15, 0.75, 1.45])
					Buffer(2);
			translate([1.15+11.5,0.75,1.45])
					Buffer(2);
	}
}

module SkirtEndBlock() {
	intersection() {
		union() {
			hull() {
				translate([0,0,2.5])
					linear_extrude(height=0.01)
						scale(25.4/1200)
							BUTprofileSkirtL();
				translate([-7.0,14.5,0.3])
					cube([0.8, 4.9, 0.1]);
			}
			hull() {
				translate([0,0,2.5])
					linear_extrude(height=0.01)
						scale(25.4/1200)
							BUTprofileSkirtR();
				translate([6.1,14.5,0.3])
					cube([0.8, 4.9, 0.1]);
			}
		}
		hull() {
			translate([-15,14.4, 0.3])
				cube([30, 1.6, 4]); 
			translate([0,17.5,2.38])
				rotate([0,90,0])
					cylinder(r=1.695, h=30, $fn=32, center=true);
		}
	}
}

module SkirtEnds() {
	SkirtEndBlock();
	translate([0,0,77])
		mirror([0,0,1])
			SkirtEndBlock();
}


//
//		Support bars to help Shapeways FUD
//		process not warp the shell
//
module ShapewaysHack() {
	translate([0,0,22])
		linear_extrude(height=1)
			scale(25.4/1200)
				BUTprofileBar();

	translate([0,0,48])
		linear_extrude(height=1)
			scale(25.4/1200)
				BUTprofileBar();
}

module Body() {
	difference() {
		BodyShellOutside();
		union() {
			translate([0,0.672,0.9625])
				scale([0.93,0.93,0.975])
					BodyShellInside();
			if (detail == 2)
				BufferHoles();
		}
	}
	translate([0,0,2.5])
		linear_extrude(height=72)
			scale(25.4/1200)
					BUTprofileSkirt();
	BufferBeams();
	SkirtEnds();
	ShapewaysHack();
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


module HalfRoundedWindow(h, w, d, r) {
	intersection() {
		translate([0, 0, -d/2])
			cube([w, h, d]);
		union() {
			translate([0, r, -d/2])
				cube([w, h-r, d]);
			translate([r, 0, -d/2])
				cube([w-2*r, h, d]);
			translate([r,r,-d/2])
				cylinder(r=r, h=d, $fn=32);
			translate([w-r,r,-d/2])
				cylinder(r=r, h=d, $fn=32);
		}
	}
}


module MainWindowPunch(x) {
	translate([0,4.45,x])
		rotate([0,270,0])
			RoundedWindow(4.75, 8, 20, 0.4);
}

module DriversWindowPunch(x) {
	translate([0,4.45,x])
		rotate([0,270,0])
			RoundedWindow(4.75, 5, 20, 0.4);
}

module DoorWindowPunch(x) {
	translate([0,4.45,x])
		rotate([0,270,0])
			RoundedWindow(3.5, 5, 20, 0.4);
}

module CabWindowPunch() {
	RoundedWindow(5, 4.1, 100, 0.4);
}

module CabDoorPunch() {
	RoundedWindow(5, 3, 100, 0.4);
}

module AngledWindowPunch() {
	translate([0,4.2,0])
		rotate([0,45,0])
			RoundedWindow(5, 1.75, 15, 0.4);
}

module AngledWindowPunchR() {
	translate([0,4.2,0])
		rotate([0,-45,0])
			RoundedWindow(5, 1.75, 15, 0.4);
}

module LiningPlanes() {
	translate([-15, 9.2, -1.5])
		cube([30, 0.2, 80]);
	translate([-15, 9.2 + 1.2, -1.5])
		cube([30, 0.2, 80]);
	translate([-15, 2.5, -1.5])
		cube([30, 0.2, 80]);
	translate([-15, 2.5 + 1.5, -1.5])
		cube([30, 0.2, 80]);
}

module DoorLining() {
	translate([-2, 2.8, -1])
	difference() {
		cube([4, 11.6, 80]);
		translate([0.2,0.2,-1])
			cube([3.6, 11.1, 82]);
	}
}

module LightFeatures() {
	translate([0,1.8,-1.5])
		cylinder(r=0.5, h=80, $fn=32);
	translate([5.9, 12.65 ,-1.5])
		cylinder(r=0.5, h=80, $fn=32);
	translate([-5.9,12.65,-1.5])
		cylinder(r=0.5, h=80, $fn=32);
	translate([0,12.65,0.2])
		sphere(r=0.5, $fn=16);
	translate([0,12.65,76.8])
		sphere(r=0.5, $fn=16);
}

module RoofLine() {
	translate([0,0,-1.5])
	linear_extrude(height=80)
		scale(25.4/1200)
			BUTprofileRoofLine();
}

module BUTDoor(x,y) {
	translate([y, 2.5, x-1])
	// Allow 1 each side for wall merge
	difference() {
		cube([1,13.4, 7]);
		translate([-4, 4.45-2.5, 1.625])
			rotate([0,270,0])
				RoundedWindow(4.75, 3.75, 20, 0.4);
	}
}

module BUTDoorStep() {
	translate([10,0,0])
		rotate([0,270,0])
			HalfRoundedWindow(1,3,20,1);
}

module BUTDoorPunch(x,y) {
	translate([y,2.5,x])
		cube([20,12.5,5]);
	translate([y,16,x+1])
		BUTDoorStep();
	translate([y,17.5,x+1])
		BUTDoorStep();
}

module BUTDoubleDoor(y) {
	translate([-15, 2.5, y]) {
		// Allow line thickness
		difference() {
			cube([30,12.5, 7.8]);
			translate([-1, 0.15,0.15])
				cube([32,12.2, 7.5]);
		}
		translate([0,0,3.75])
			cube([30,12.5,0.3]);
	}
}

module BUTDoubleDoorPunch(x,y) {
	translate([y+10, 2.5, x]) {
			translate([-4, 4.45-2.5, 0.625])
			rotate([0,270,0])
				RoundedWindow(4.75, 2.25, 20, 0.4);
		translate([-4, 4.45-2.5, 4.625])
			rotate([0,270,0])
				RoundedWindow(4.75, 2.25, 20, 0.4);
	}
}

module BodyCutter() {	
	difference() {
		Body();
		scale([0.98,1.001,1.001])
			Body();
	}
}

module RoofVentilator() {
	cube([2,1,1.5], center=true);
	cube([1.5,1,2], center=true);
}

module BUTDrivingUnit() {
	difference() {
		union() {
			Body();
			translate([-4.75,0.3,21])
				rotate([0,0,-5])
					RoofVentilator();
			translate([4.75,0.3,21])
				rotate([0,0,5])
					RoofVentilator();
			translate([-4.75,0.3,77-21])
				rotate([0,0,-5])
					RoofVentilator();
			translate([4.75,0.3,77-21])
				rotate([0,0,5])
					RoofVentilator();
		}
		BufferHoles();
		MainWindowPunch(10.04);
		MainWindowPunch(20.34);
		MainWindowPunch(30.64);
		MainWindowPunch(48.81);
		MainWindowPunch(58.71);
		DriversWindowPunch(3);
		DriversWindowPunch(69);
		translate([-6.5,4.2, 50])
			CabWindowPunch();
		translate([-1.5,4.2, 50])
			CabDoorPunch();
		translate([2.4,4.2, 50])
			CabWindowPunch();
		translate([-10.5,0,0.3])
			AngledWindowPunch();
		translate([7.75,0,0.3])
			AngledWindowPunchR();
		translate([-10.5,0,76.7])
			AngledWindowPunchR();
		translate([7.75,0,76.7])
			AngledWindowPunch();
		BUTDoorPunch(41.2,-10);
		BUTDoorPunch(41.2, 0);
	}
	BUTDoor(41.2, -8.5);
	BUTDoor(41.2, 7.5);
}

module BUTDrivingBrakeUnit() {
	difference() {
		union() {
			Body();
			translate([-4.75,0.3,21])
				rotate([0,0,-5])
					RoofVentilator();
			translate([4.75,0.3,21])
				rotate([0,0,5])
					RoofVentilator();
			translate([-4.75,0.3,77-21])
				rotate([0,0,-5])
					RoofVentilator();
			translate([4.75,0.3,77-21])
				rotate([0,0,5])
					RoofVentilator();
		}
		MainWindowPunch(10.04);
		MainWindowPunch(20.34);
		MainWindowPunch(38.11);
		MainWindowPunch(47.89);
		DriversWindowPunch(3);
		DriversWindowPunch(69);
		translate([-6.5,4.2, 50])
			CabWindowPunch();
		translate([-1.5,4.2, 50])
			CabDoorPunch();
		translate([2.4,4.2, 50])
			CabWindowPunch();
		translate([-10.5,0,0.3])
			AngledWindowPunch();
		translate([7.75,0,0.3])
			AngledWindowPunchR();
		translate([-10.5,0,76.7])
			AngledWindowPunchR();
		translate([7.75,0,76.7])
			AngledWindowPunch();
		BUTDoorPunch(30.64,-10);
		BUTDoorPunch(30.64, 0);
		BUTDoubleDoorPunch(58.71,-10);
		BUTDoubleDoorPunch(58.71, 0);
		intersection() {
			BodyCutter();
			BUTDoubleDoor(58.71);
		}
		BufferHoles();
	}
	BUTDoor(30.64, -8.5);
	BUTDoor(30.64, 7.5);
}


module LiningDetail(type) {
	intersection() {
		union() {
			LiningPlanes();
			DoorLining();
			RoofLine();
			// No lights on the trailer
			if (type !=0)
				LightFeatures();
		}
		union() {
			difference() {
				translate([0,0,-0.231])
					scale([1.025,1,1.006])
						Body();
				if (type < 2) {
					BUTDoorPunch(41.2,-10);
					BUTDoorPunch(41.2, 0);
				} else {
					BUTDoorPunch(30.64,-10);
					BUTDoorPunch(30.64, 0);
					BUTDoubleDoor(58.71);
				}
			}
			if (type < 2) {
				BUTDoor(41.2, -8.7);
				BUTDoor(41.2, 7.7);
			} else {
				BUTDoor(30.64, -8.7);
				BUTDoor(30.64, 7.7);

			}
		}
	}
}


module BUTDMS() {
	BUTDrivingUnit();
	LiningDetail(1);
}

module BUTTS() {
	BUTDrivingUnit();
	LiningDetail(0);
}

module BUTDMBS() {
	BUTDrivingBrakeUnit();
	LiningDetail(2);
}

//0 = no buffers
//1 = FUD
//2 = buffer holes (for OO)
detail=2;

// do 146.5/76 for OO so it scrapes polisher
// do 148/100 for 3mm
// do 148/120 for TT
// no scale for N (1/148)
// scale(148/100) {
	rotate([90,180,-15]) {
		BUTDMBS();
		translate([20,0,0])
			BUTDMS();
		translate([40,0,0])
			BUTTS();
	}
//}



