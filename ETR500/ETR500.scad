use <ETR500Cut.scad>;
use <ETR500CutBar.scad>;
use <ETR500CutBogie.scad>;
use <ETR500CutCorridor.scad>;
use <ETR500CutJoin.scad>;
use <ETR500DoorCut.scad>;
use <ETR500End.scad>;
use <ETR500Mid.scad>;
use <ETR500FirstSide.scad>;
use <ETR500FirstSideB.scad>;
use <ETR500DiningSide.scad>;
use <ETR500DiningSideB.scad>;
use <ETR500DiningSide2.scad>;
use <ETR500DiningSide2B.scad>;


// 4 1 7 formation (4 1st, coffee bar, 7 2nd)



// Or we could just use Japanese bogie mounts
//
module BogieMount(x) {
	translate([0, 19, x]) {
		rotate([90,0,0]) {
			difference() {
				cylinder(r=1.9,h = 4, $fn=16, center=true);
				cylinder(r=0.9, h = 6, $fn=16, center=true);
			}
		}
	}
}

module ETR500Shell() {
	difference() {
		union() {
			linear_extrude(height=163.1)
				scale(25.4/1200)
					ETR500Mid();
			linear_extrude(height=10)
				scale(25.4/1200)
					ETR500End();
			translate([0,0,153])
				linear_extrude(height=10.01)
					scale(25.4/1200)
						ETR500End();
		}
		translate([0,0,-0.05])
			linear_extrude(height=1.6+1.6)
				scale(25.4/1200)
					ETR500CutCorridor();
		translate([-1,20.3,-0.05])
			cube([2,2,5]);
		translate([0,0,1.5])
			linear_extrude(height=1.6)
				scale(25.4/1200)
					ETR500CutJoin();
		translate([0,0,3])
			linear_extrude(height=4.1)
				scale(25.4/1200)
					ETR500Cut();
		translate([0,0,7])
			linear_extrude(height=4.1)
				scale(25.4/1200)
					ETR500CutJoin();
		translate([0,0,11.0])
			linear_extrude(height=7.1)
				scale(25.4/1200)
					ETR500Cut();
		translate([0,0,18.0])
			linear_extrude(height=8.1)
				scale(25.4/1200)
					ETR500CutBogie();
		translate([0,0,26.0])
			linear_extrude(height=7.1)
				scale(25.4/1200)
					ETR500Cut();
		translate([0,0,33])
			linear_extrude(height=4.1)
				scale(25.4/1200)
					ETR500CutJoin();
		translate([0,0,37.0])
			linear_extrude(height=40.1)
				scale(25.4/1200)
					ETR500Cut();
		translate([0,0,77.0])
			linear_extrude(height=10)
				scale(25.4/1200)
					ETR500CutBar();

		translate([0,0,163.1-1.55-1.6])
			linear_extrude(height=1.6+1.6)
				scale(25.4/1200)
					ETR500CutCorridor();
		translate([-1,20.3,163.1-4.05])
			cube([2,2,5]);
		translate([0,0,163.1-3.05])
			linear_extrude(height=1.6)
				scale(25.4/1200)
					ETR500CutJoin();
		translate([0,0,163.1-7])
			linear_extrude(height=4.1)
				scale(25.4/1200)
					ETR500Cut();
		translate([0,0,163.1-11])
			linear_extrude(height=4.1)
				scale(25.4/1200)
					ETR500CutJoin();
		translate([0,0,163.1-18.0])
			linear_extrude(height=7.1)
				scale(25.4/1200)
					ETR500Cut();
		translate([0,0,163.1-26.0])
			linear_extrude(height=8.1)
				scale(25.4/1200)
					ETR500CutBogie();
		translate([0,0,163.1-33.0])
			linear_extrude(height=7.1)
				scale(25.4/1200)
					ETR500Cut();
		translate([0,0,163.1-37])
			linear_extrude(height=4.1)
				scale(25.4/1200)
					ETR500CutJoin();
		translate([0,0,163.1-77.0])
			linear_extrude(height=40)
				scale(25.4/1200)
					ETR500Cut();
	}
}

module ETR500FirstDoorCutter() {
	difference() {
		linear_extrude(height=163.1)
			scale(25.45/1200)
				ETR500DoorCut();
		translate([-15,0,163.1/2])
			rotate([0,90,0])
				linear_extrude(height=30)
					scale(25.4/1200)
						ETR500FirstSide();
	}
}

module ETR500FirstSideCut() {
	translate([-15,0,163.1/2])
	rotate([0,90,0])
		linear_extrude(height=30)
			scale(25.4/1200)
				ETR500FirstSideB();
}

module ETR500FirstBody() {
	difference() {
		union() {
			intersection() {
				ETR500FirstSideCut();
				ETR500Shell();
			}
			BogieMount(21.6);
			BogieMount(163.1-21.6);
		}
		ETR500FirstDoorCutter();
	}
}

module ETR500SecondBody(){
	ETR500FirstBody();
}

module ETR500DiningDoorCutter() {
	difference() {
		linear_extrude(height=163.1)
			scale(25.45/1200)
				ETR500DoorCut();
		translate([-15,0,163.1/2])
			rotate([0,90,0])
				linear_extrude(height=15)
					scale(25.4/1200)
						ETR500DiningSide();
		translate([0,0,163.1/2])
			rotate([0,90,0])
				linear_extrude(height=15)
					scale(25.4/1200)
						ETR500DiningSide2();
	}
}

module ETR500DiningSideCut() {
	translate([-15,0,163.1/2])
	rotate([0,90,0])
		linear_extrude(height=15)
			scale(25.4/1200)
				ETR500DiningSideB();
	translate([0,0,163.1/2])
	rotate([0,90,0])
		linear_extrude(height=15)
			scale(25.4/1200)
				ETR500DiningSide2B();
}

module ETR500DiningBody() {
	difference() {
		union() {
			intersection() {
				ETR500DiningSideCut();
				ETR500Shell();
			}
			BogieMount(21.6);
			BogieMount(163.1-21.6);
		}
		ETR500DiningDoorCutter();
	}
}


module ETR500Slab() {
for (i=[1:4])
	translate([-22*i,0,0])
		ETR500FirstBody();
ETR500DiningBody();
for (i=[1:7])
	translate([22*i,0,0])
		ETR500SecondBody();
}

module ETR500Block() {
	for(i=[0:3])
		translate([21*i,0,0])
			ETR500FirstBody();
	for(i=[0:3])
		translate([21*i,24,0])
			ETR500SecondBody();
	for(i=[0:2])
		translate([21*i,48,0])
			ETR500SecondBody();
	translate([21*3,48,0])
			ETR500DiningBody();
}

module CheckPlate() {
	translate([-10,-5,-10])
	cube([150,1,150]);
}

ETR500Block();


