use <Railcar2.scad>;

module Pulley(r) {
	translate([0,0,-1.75/2]) {
		cylinder(r=r,h=1.75, $fn=32);
		cylinder(r1=r+0.5,r2=r, h=1.75/2, $fn=32);
		translate([0,0,1.75/2])
			cylinder(r1=r, r2=r+0.5, h=1.75/2, $fn=32);
	}
}

module NigelLawtonMotor() {
	translate([0,0,-6]) {
		cylinder(r=3, h=10, $fn=32);
		cylinder(r=0.4, h=12, $fn=32);
		translate([0,0,11])
			Pulley(1.1/2);
	}
}

// Really 0.75 but cut to 0.8 to run smoothly
// when subtracted
module LayShaft() {
	cylinder(r=0.8, h=14, $fn=32, center=true);
}

module Wheel() {
	cylinder(r=3.1, h=2, $fn=32);
	cylinder(r=3.4, h=0.2, $fn=32);
}

module Axle() {
	cylinder(r=0.75, h=15.7, $fn=32, center=true);
	translate([0,0,3.8])
		Wheel();
	translate([0,0,-3.8])
		mirror([0,0,1])
			Wheel();
}


module MotorCarrier() {
	difference() {
		cylinder(r=3.8, h=7, $fn=32, center=true);
		cylinder(r=3, h=6, $fn=32, center=true);
	}
}


//MotorCarrier();


module Mechanism() {
	translate([-1,0,0])
	NigelLawtonMotor();
	translate([6.3,0,0]) {
		LayShaft();
		// Can fit a 3.5 if this is on the +ve side
		// for two stages
		translate([0,0,-5])
			Pulley(2.5);
		Pulley(1.7/2);
	}
	translate([6.3,7.6,0]) {
			Axle();
			Pulley(2.5);
	}
	// Try extra stage
	translate([0,-7,0]) {
		LayShaft();
		translate([0,0,-5])
			Pulley(1.7/2);
		translate([0,0,5])
			Pulley(2.5);
	}
}

module DriveMountingMain() {
	difference() {
		translate([-1,0,0])
			MotorCarrier();
		translate([0,-3,-1.5])
			cube([7,5,3]);
	}
	translate([4.25,-2,-3])
		cube([4,11.5,1.5]);
	translate([4.25,-2,1.5])
		cube([4,11.5,1.5]);
	translate([0,-2,-3])
		cube([8,3,1]);
	translate([0,-2,2])
		cube([8,3,1]);
	// and extra stage
	translate([-1.75,-9,-3.5])
		cube([4,7.5,1.5]);
	translate([-1.75,-9,2])
		cube([4,7.5,1.5]);
}

module DriveMounting() {
	difference() {
		DriveMountingMain();
		Mechanism();
	}
}

//rotate([0,90,0])
//	KESRRailcar();

translate([5.8,13-2.8,0]) {
	DriveMounting();
%	Mechanism();
}



//% translate([-4,-3,-7])
//	cube([10.5,7.5,14]);

