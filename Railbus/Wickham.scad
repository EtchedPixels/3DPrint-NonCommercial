use <WickhamBodyA.scad>;
use <WickhamBodyB.scad>;
use <ElliotBodyA.scad>;
use <ElliotBodyB.scad>;
use <WickhamBodyA2.scad>;
use <WickhamBodyB2.scad>;
use <WickhamEnd.scad>;
use <WickhamEndB.scad>;
use <WickhamFloor.scad>;
use <ElliotFloor.scad>;
use <WickhamBodyHole.scad>;
use <ElliotBodyHole.scad>;
use <WickhamEndHole.scad>;
use <WickhamEndHoleB.scad>;
use <WickhamEndHoleC.scad>;
use <WickhamFloorHole.scad>;
use <ElliotFloorHole.scad>;
use <WickhamFloorRB.scad>;
use <ElliotFloorRB.scad>;
use <WickhamRoof1.scad>;
use <WickhamRoof2.scad>;
use <WickhamRoof3.scad>;
use <WickhamRoof4.scad>;
use <WickhamRoof5.scad>;
use <WickhamRoof6.scad>;

//	Type Values
//	0	-	Simply body shell
// 1	-	DO NOT USE
//	2  -  Shell with interior, roof, Tomix chassis
// 3  -  Shell with full interior, roof, no chassis
//
// TODO
// Drivers console
// Battery boxes/vac on Kato end
// Elliot buffer beam ?

module ElliotBodyOuter()
{
	intersection() {
		linear_extrude(height=76)
			scale(25.4/1200)
				WickhamEnd();

		translate([0,20,0])
			rotate([90,0,0])
				linear_extrude(height=25)
					scale(25.4/1200)
						ElliotFloor();
		union() {
			translate([-12.5,8.5,0])
				rotate([90,0,90])
					linear_extrude(height=12.51)
						scale(25.4/1200)
							ElliotBodyA();
			translate([0,8.5,0])
				rotate([90,0,90])
					linear_extrude(height=12.5)
						scale(25.4/1200)
							ElliotBodyB();
		}
	}
}

module ElliotBodyInner()
{
	intersection() {
		union() {
			linear_extrude(height=76)
				scale(25.4/1200)
					WickhamEndHole();//C?
//			translate([0,0,3.5])
//				linear_extrude(height=67)
//					scale(25.4/1200)
//						WickhamEndHoleB();
//			translate([0,0,4])
//				linear_extrude(height=24)
//					scale(25.4/1200)
//						WickhamEndHole();
//			translate([0,0,46])
//				linear_extrude(height=24)
//					scale(25.4/1200)
//						WickhamEndHole();
		}

		translate([0,20,0])
			rotate([90,0,0])
				linear_extrude(height=25)
					scale(25.4/1200)
						ElliotFloorHole();

		translate([-12.5,8.5,0])
			rotate([90,0,90])
				linear_extrude(height=25)
					scale(25.4/1200)
						ElliotBodyHole();
	}
}

module WickhamBodyOuter()
{
	intersection() {
		linear_extrude(height=74)
			scale(25.4/1200)
				WickhamEnd();

		translate([0,20,0])
			rotate([90,0,0])
				linear_extrude(height=25)
					scale(25.4/1200)
						WickhamFloor();
		union() {
			translate([-12.5,8.5,0])
				rotate([90,0,90])
					linear_extrude(height=12.51)
						scale(25.4/1200)
							WickhamBodyA2();
			translate([0,8.5,0])
				rotate([90,0,90])
					linear_extrude(height=12.5)
						scale(25.4/1200)
							WickhamBodyB2();
		}
	}
}

module WickhamBodyOuter2()
{
	intersection() {
		linear_extrude(height=74)
			scale(25.4/1200)
				WickhamEndB();

		translate([0,20,0])
			rotate([90,0,0])
				linear_extrude(height=25)
					scale(25.4/1200)
						WickhamFloor();
		union() {
			translate([-12.5,8.5,0])
				rotate([90,0,90])
					linear_extrude(height=12.51)
						scale(25.4/1200)
							WickhamBodyA();
			translate([0,8.5,0])
				rotate([90,0,90])
					linear_extrude(height=12.5)
						scale(25.4/1200)
							WickhamBodyB();
		}
	}
}

module WickhamBodyInner(roof)
{
	intersection() {
		union() {
			linear_extrude(height=74)
				scale(25.4/1200)
					WickhamEndHoleC();
			// Avoid the ridges when doing the roof
			// so we don't get bits that wont print
//			if (roof == 0) {
				translate([0,0,3.5])
					linear_extrude(height=67)
						scale(25.4/1200)
							WickhamEndHoleB();
				translate([0,0,4])
					linear_extrude(height=24)
						scale(25.4/1200)
							WickhamEndHole();
				translate([0,0,46])
					linear_extrude(height=24)
						scale(25.4/1200)
							WickhamEndHole();
//			} else {
//				translate([0,0,3.5])
//					linear_extrude(height=67)
//						scale(25.4/1200)
//							WickhamEndHole();
//			}
		}

		translate([0,20,0])
			rotate([90,0,0])
				linear_extrude(height=25)
					scale(25.4/1200)
						WickhamFloorHole();

		translate([-12.5,8.5,0])
			rotate([90,0,90])
				linear_extrude(height=25)
					scale(25.4/1200)
						WickhamBodyHole();
	}
}

module BodyInner(unit) {
		if (unit == 999507)
			ElliotBodyInner();
		else
			WickhamBodyInner();
}

module RoofVentilator(z) {
		translate([0,0.6,z]) {
			cube([2.5, 2, 1], center=true);
			cube([1.5, 2, 1.5], center=true);
		}
}

module Exhaust(z) {
		translate([2.5,0.6,z]) {
			rotate([90,0,0])
				cylinder(r=0.4, h=2, $fn=16, center=true);
		}
}

module ElliotVentilator(z) {
		translate([0,0.6,z]) {
			rotate([90,0,0])
				cylinder(r=2.3, h=2, $fn=16, center=true);
		}
}

module ElliotRoofDetail() {
	difference() {
		union() {
			intersection() {
				translate([0,-0.1,0]) {
					linear_extrude(height=76)
						scale(25.8/1200)
							WickhamRoof1();
				}

				union() {
					translate([-10,2,0]) {
						translate([0,-5,3.7])
							cube([20, 10, 0.2]);
						translate([0,-5,12.6])
							cube([20, 10, 0.2]);
						translate([0,-5,23.7])
							cube([20, 10, 0.2]);
						translate([0,-5,33.8])
							cube([20, 10, 0.2]);
						translate([0,-5,42.0])
							cube([20, 10, 0.2]);
						translate([0,-5,52.1])
							cube([20, 10, 0.2]);
						translate([0,-5,63.2])
							cube([20, 10, 0.2]);
						translate([0,-5,72.1])
							cube([20, 10, 0.2]);

					}
				}
			}
			union() {
				ElliotVentilator(20);
				ElliotVentilator(56);
			}
		}
		ElliotBodyInner();
	}
}

module WickhamRoofDetail() {
	difference() {
		union() {
			intersection() {
				translate([0,-0.1,4.5]) {
					linear_extrude(height=74-9)
						scale(25.8/1200)
							WickhamRoof1();
				}

				union() {
					translate([-10,2,0]) {
						translate([0,-5,4.5])
							cube([20, 10, 0.2]);
						translate([0,-5,69.3])
							cube([20, 10, 0.2]);
						for(i = [1:8]) {
							translate([0,-5, 4.5 + 7.2 *i])
								cube([20,10,0.2]);
						}
					}
				}
			}
			union() {
					RoofVentilator(10.5);
					RoofVentilator(19);
					RoofVentilator(27.5);
					RoofVentilator(36);
					RoofVentilator(46);
					RoofVentilator(54.5);
					RoofVentilator(63);
					Exhaust(43);
			}
		}
		WickhamBodyInner();
	}
}

module RoofDetail79965() {
	difference() {
		union() {
			intersection() {
				translate([0,-0.1,4.5]) {
					linear_extrude(height=74-9)
						scale(25.8/1200)
							WickhamRoof1();
				}

				union() {
					translate([-10,2,0]) {
						cube([20, 0.2, 74]);
						translate([0,-5,4.5])
							cube([20, 10, 0.2]);
						translate([0,-5,69.3])
							cube([20, 10, 0.2]);
						translate([0,0,13.4])
							cube([20, 5.1, 0.2]);
						translate([0,0,29.9])
							cube([20, 5.1, 0.2]);
						translate([0,0, 74-13.6])
							cube([20, 5.1, 0.2]);
						translate([0,0, 74-30.1])
							cube([20, 5.1, 0.2]);
						translate([0,-5, 12])
							cube([20, 5.1, 0.2]);
						translate([0,-5, 74-12.2])
							cube([20, 5.1, 0.2]);
						for(i = [1:8]) {
							translate([0, -5, 12 + 5.5 *i])
								cube([20,5.1,0.2]);
						}
					}
				}
			}
			union() {
					RoofVentilator(10.5);
					RoofVentilator(19);
					RoofVentilator(27.5);
					RoofVentilator(36);
					RoofVentilator(46);
					RoofVentilator(54.5);
					RoofVentilator(63);
					Exhaust(43);
			}
		}
		WickhamBodyInner();
	}
}

module RoofDetail(unit) {
	if (unit == 999507)
		ElliotRoofDetail(unit);
	else if (unit == 79965)
		RoofDetail79965(unit);
	else
		WickhamRoofDetail(unit);
}

module WickhamRoof() {
	hull() {
		translate([0,0,3.3])
			linear_extrude(height=74-6.4)
				scale(25.4/1200)
					WickhamRoof1();
		translate([0,0,0.5])
			linear_extrude(height=0.5)
				scale(25.4/1200)
					WickhamRoof6();
		translate([0,0,1])
			linear_extrude(height=0.5)
				scale(25.4/1200)
					WickhamRoof2();
		translate([0,0,1.5])
			linear_extrude(height=0.5)
				scale(25.4/1200)
					WickhamRoof5();
			translate([0,0,2])
				linear_extrude(height=0.5)
					scale(25.4/1200)
						WickhamRoof3();
		translate([0,0,2.7])
			linear_extrude(height=0.5)
				scale(25.4/1200)
					WickhamRoof4();
		intersection() {
			translate([-(17.6/2),4.3,0])
				cube([17.6,0.1, 74]);
			translate([0,20,0])
				rotate([90,0,0])
					linear_extrude(height=25)
						scale(25.4/1200)
							WickhamFloorRB();
		}
	}
	hull() {
		translate([0,0,3.3])
			linear_extrude(height=74-6.4)
				scale(25.4/1200)
					WickhamRoof1();
		translate([0,0,73])
			linear_extrude(height=0.5)
				scale(25.4/1200)
					WickhamRoof6();
		translate([0,0,72.5])
			linear_extrude(height=0.5)
				scale(25.4/1200)
					WickhamRoof2();
		translate([0,0,72])
			linear_extrude(height=0.5)
				scale(25.4/1200)
					WickhamRoof5();
			translate([0,0,71.5])
				linear_extrude(height=0.5)
					scale(25.4/1200)
						WickhamRoof3();
		translate([0,0,70.8])
			linear_extrude(height=0.5)
				scale(25.4/1200)
					WickhamRoof4();
		intersection() {
			translate([-(17.6/2),4.3,0])
				cube([17.6,0.1, 74]);
			translate([0,20,0])
				rotate([90,0,0])
					linear_extrude(height=25)
						scale(25.4/1200)
							WickhamFloorRB();
		}
	}
}

module ElliotRoof() {
	hull() {
		translate([0,0,3.3])
			linear_extrude(height=76-6.4)
				scale(25.4/1200)
					WickhamRoof1();
		translate([0,0,0.5])
			linear_extrude(height=0.5)
				scale(25.4/1200)
					WickhamRoof6();
		translate([0,0,1])
			linear_extrude(height=0.5)
				scale(25.4/1200)
					WickhamRoof2();
		translate([0,0,1.5])
			linear_extrude(height=0.5)
				scale(25.4/1200)
					WickhamRoof5();
			translate([0,0,2])
				linear_extrude(height=0.5)
					scale(25.4/1200)
						WickhamRoof3();
		translate([0,0,2.7])
			linear_extrude(height=0.5)
				scale(25.4/1200)
					WickhamRoof4();
		intersection() {
			translate([-(17.6/2),4.3,0])
				cube([17.6,0.1, 76]);
			translate([0,20,0])
				rotate([90,0,0])
					linear_extrude(height=25)
						scale(25.4/1200)
							ElliotFloorRB();
		}
	}
	hull() {
		translate([0,0,3.3])
			linear_extrude(height=76-6.4)
				scale(25.4/1200)
					WickhamRoof1();
		translate([0,0,75])
			linear_extrude(height=0.5)
				scale(25.4/1200)
					WickhamRoof6();
		translate([0,0,74.5])
			linear_extrude(height=0.5)
				scale(25.4/1200)
					WickhamRoof2();
		translate([0,0,74])
			linear_extrude(height=0.5)
				scale(25.4/1200)
					WickhamRoof5();
			translate([0,0,73.5])
				linear_extrude(height=0.5)
					scale(25.4/1200)
						WickhamRoof3();
		translate([0,0,72.8])
			linear_extrude(height=0.5)
				scale(25.4/1200)
					WickhamRoof4();
		intersection() {
			translate([-(17.6/2),4.3,0])
				cube([17.6,0.1, 76]);
			translate([0,20,0])
				rotate([90,0,0])
					linear_extrude(height=25)
						scale(25.4/1200)
							ElliotFloorRB();
		}
	}
}

module Roof(unit) {
	if (unit == 999507)
		ElliotRoof(unit);
	else
		WickhamRoof(unit);
}

module Lamps(unit) {
	if (unit == 999507) {
		translate([0,14.5,-0.5])
			cylinder(r=0.75, h=77, $fn=16);
		translate([6,14.5,0.5])
			cylinder(r=0.75, h=75, $fn=16);
		translate([-6,14.5,0.5])
			cylinder(r=0.75, h=75, $fn=16);
	} else {
		translate([0,14.5,-0.5])
			cylinder(r=0.75, h=75, $fn=16);
		translate([6,14.5,0.5])
			cylinder(r=0.75, h=73, $fn=16);
		translate([-6,14.5,0.5])
			cylinder(r=0.75, h=73, $fn=16);
	}
}


module RoofLamps(unit) {
	if (unit == 999507) {
		translate([0,1.0,0.5])
			cylinder(r=0.75, h=75, $fn=16);
	} else {
		translate([0,1.0,0.5])
			cylinder(r=0.75, h=73, $fn=16);
	}
}

module RoundedBox(width,height,len) {
	union() {
		translate([0.25,0.25,0])
			cylinder(r=0.25, h=len);
		translate([0.25,height-0.25,0])
			cylinder(r=0.25, h=len);
		translate([width-0.25,0.25,0])
			cylinder(r=0.25, h=len);
		translate([width-0.25,height-0.25,0])
			cylinder(r=0.25, h=len);
		translate([0,0.25,0])
			cube([width,height-0.5,len]);
		translate([0.25,0,0])
			cube([width-0.5, height, len]);
	}
}

module DestinationBox() {
	translate([-2.75, 3, 0]) {
		difference() {
			RoundedBox(5.5,2.5, 74);
			translate([0.25,0.25,-0.1])
				RoundedBox(5,2.0, 74.2);
		}
		translate([0,0,0.2])
			RoundedBox(5.5,2.75,73.6);
	}
}

// End window top strips
module WickhamTopBits() {
	translate([-9.125,5.5,2.7])
		cube([18.25,0.3,5]);
	translate([-9.125,5.5,66.3])
		cube([18.25,0.3,5]);
}

// End window top strips
module ElliotTopBits() {
	translate([-9.125,5.5,3.5])
		cube([18.25,0.3,5]);
	translate([-9.125,5.5,67.5])
		cube([18.25,0.3,5]);
}

module WindowTopBits(unit) {
	if (unit == 999507)
		ElliotTopBits();
	else
		WickhamTopBits();
}

module ChassisBlockTomix() {
	cube([16,12,68]);
}

module WickhamChairUnit(n, d, x)
{
	translate([0, 0 ,x]) {
		cube([2.7 * n, 3, 3.5]);
		translate([0, -3.5, 2.5 * d])
			cube([2.7 * n, 6.5, 1]);
	}
}

module WickhamChair(n, d, d2, x) {
	if (d2 == 1 && n == 2)
		translate([2.7, 0, 0])
			WickhamChairUnit(n,d,x);
	else
		WickhamChairUnit(n,d,x);
}


module WickhamChairs() {
	translate([-8.25,13.95,-0.2]) {
		WickhamChair(2, 1, 0, 6.5);
		WickhamChair(3, 1, 0, 11);
		WickhamChair(3, 1, 0, 16);
		WickhamChair(3, 1, 0, 21);
		WickhamChair(3, 1, 0, 26);
		WickhamChair(2, 0, 0, 45.5);
		WickhamChair(2, 0, 0, 50.5);
		WickhamChair(2, 0, 0, 55.5);
		WickhamChair(2, 0, 0, 60.5);
	}
	translate([0.25,13.95,-0.2]) {
		WickhamChair(2, 1, 1, 9.9);
		WickhamChair(2, 1, 1, 14.7);
		WickhamChair(2, 1, 1, 19.5);
		WickhamChair(2, 1, 1, 24.5);
		WickhamChair(3, 0, 1, 45);
		WickhamChair(3, 0, 1, 50);
		WickhamChair(3, 0, 1, 55);
		WickhamChair(3, 0, 1, 60);
		WickhamChair(2, 0, 1, 65);
	}
	translate([3.75, 13.95, -0.2])
		WickhamChairUnit(1, 1, 4);
	translate([-6.45, 13.95, -0.2])
		WickhamChairUnit(1, 0, 67.5);
}

module WickhamPartition(n) {
	difference() {
		cube([n, 12.45, 0.7]);
		translate([1, 2, -0.1])
			cube([n-2, 6, 0.9]);
	}
}

module SolidPartition(n) {
	difference() {
		cube([n, 12.5, 0.7]);
		translate([1, 2, -0.1])
			cube([n-2, 6, 0.9]);
	}
}

module WickhamVPartition(x, n) {
	translate([0,0,x]) {
		difference() {
			cube([0.7, 12.45, n]);
			translate([-0.1, 2, 1])
				cube([0.9, 6, n-2]);
		}
	}
}

module WickhamCabDoor(x, z, n) {
	translate([x,0,z]) {
		rotate([0,45,0]) {
			difference() {
				cube([0.7, 12.45, n]);
				translate([-0.1, 2, 1])
					cube([0.9, 6, n-2]);
			}
		}
	}
}

module WickhamPartitionA(x, n) {
	translate([16.5 - n, 0, x])
		WickhamPartition(n);
}

module WickhamPartitionB(x, n) {
	translate([0, 0, x])
		WickhamPartition(n);
}

module SolidPartitionA(x, n) {
	translate([16.5 - n, 0, x])
		SolidPartition(n);
}

module SolidPartitionB(x, n) {
	translate([0, 0, x])
		SolidPartition(n);
}

module ElliotDoorUnit(x,z, lr) {
	translate([x,-0.5,z]) {
		difference() {
			union() {
				cube([0.6, 13.25, 9]);
				translate([-0.4 + 0.4*lr, 12.25, 0])
					cube([1, 1, 9]);
			}
			union() {
				translate([-0.1, 2.1, 1.25])
					cube([0.8, 5.7, 2]);
				translate([-0.1, 2.1, 5.75])
					cube([0.8, 5.7, 2]);
				translate([-0.1 + 0.6 * lr, 0.5, 4.4])
					cube([0.2, 11.75, 0.2]);
			}
		}
	}
}
	
module WickhamPartitions() {
	translate([-8.25, 4.5, -0.2]) {
		WickhamPartitionA(7.75, 5.4);
		WickhamPartitionA(28.5, 5.4);
		WickhamPartitionA(37.0, 5.4);
		WickhamPartitionA(44.75, 7.5);
		WickhamPartitionB(29, 7.5);
		WickhamPartitionB(37.0, 5.4);
		WickhamPartitionB(45.25, 5.4);
		WickhamPartitionB(66.1, 5.4);
	}
	translate([-0.3, 4.5, -0.2]) {
		WickhamVPartition(1,4);
		WickhamVPartition(69.5,4);
	}
	translate([-0.3, 4.5, -0.2]) {
		WickhamCabDoor(0,5,4.8);
		WickhamCabDoor(-3.2,66.6,4.8);
	}
}

module WickhamFloorPlate(unit, len) {
	intersection() {
		linear_extrude(height=len)
			scale(25.4/1200)
				WickhamEnd();
		translate([-10, 16.3,0])
			cube([20,0.75, len]);
		translate([0,20,0])
			rotate([90,0,0])
				linear_extrude(height=25)
					scale(25.4/1200)
						if (len == 74)
							WickhamFloor();
						else
							ElliotFloor();
	}
}

module ElliotDoors() {
	translate([-8.25,4.2,-0.2]) {
		SolidPartitionA(28.3,1.3);
		SolidPartitionA(36.8,1.3);
		SolidPartitionB(38.9,1.3);
		SolidPartitionB(47.55,1.3);
		ElliotDoorUnit(15.6, 28.3, 1);
		ElliotDoorUnit(0.3, 39, 0);
	}
	
}

module KatoMotorBlock(len) {
	translate([-8.5, 11.85, (len - 60)/2])
		cube([17, 12.6 - 7.5, 60]);
}

module KatoMotorHole(len) {
	translate([-8.5, 11.85, (len - 60)/2])
		translate([0.5, 0.61, 1])
			cube([16, 12.6 - 7.5, 60]);
}

module TomixMotorBlock(len) {
	translate([-7.5, 12.45, (len - 68)/2])
		cube([15, 12 - 7.5, 68]);
}

module TomixMotorHole(len) {
	translate([-7, 12.45, (len-60)/2])
		translate([0, 0.61, -0.05])
			cube([14, 12 - 7.5, 60]);
}

module WickhamShellBuild(type, unit, len) {
	difference() {
		union() {
			if (unit == 999507)
				ElliotBodyOuter();
			else {
				WickhamBodyOuter();
				WickhamBodyOuter2();
			}
			if (type == 0) {
				Roof(unit);
				RoofLamps(unit);
				RoofDetail(unit);
			}
			Lamps(unit);
			if (unit != 999507)
				DestinationBox();
			WindowTopBits(unit);
		}
		BodyInner(unit,0);
	}
	if (type == 0 && unit == 999507)
		ElliotDoors();
	if (type != 0) {
		difference() {
			union() {
				if (unit != 999507) {
					WickhamChairs();
					WickhamPartitions();
				} else {
					ElliotDoors();
				}
				intersection() {
					union() {
						WickhamFloorPlate(unit, len);
						if (type == 1)
							KatoMotorBlock(len);
						if (type == 2)
							TomixMotorBlock(len);
					}
					BodyInner(unit,0);
				}
			}
			if (type == 1)
				KatoMotorHole(len);
			if (type == 2)
				TomixMotorHole(len);
		}
	}
}

module WickhamShell(type, unit) {
	if (unit == 999507)
		WickhamShellBuild(type, unit, 76);
	else
		WickhamShellBuild(type, unit, 74);
}

module RoofAssembly(type, unit) {
	if (type != 0) {
		difference() {
			union() {
				Roof(unit);
				RoofLamps(unit);
				RoofDetail(unit);
			}
			BodyInner(unit,1);
			if (unit != 999507)
				DestinationBox();
		}
	}
}

module WickhamUnit(type, unit) {
	WickhamShell(type, unit);
	if (type != 0) {
		translate([0,-2.5,0])
			RoofAssembly(type, unit);
	}
}

module WickhamPack() {
	rotate([270,0,0]) {
		WickhamUnit(0, 79965);
		translate([20,0,0])
			WickhamUnit(0, 79966);
		translate([40,0,0])
			WickhamUnit(0, 999507);
	}
}

module WickhamPack2() {
	rotate([270,0,0]) {
		WickhamUnit(0, 79965);
		translate([20,0,0])
			WickhamUnit(0, 79966);
		translate([40,0,0])
			WickhamUnit(0, 79966);
	}
}

module WickhamIntPack() {
	rotate([270,0,0]) {
		WickhamUnit(2, 79965);
		translate([20,0,0])
			WickhamUnit(2, 79966);
		translate([40,0,0])
			WickhamUnit(2, 79966);
	}
}


WickhamPack2();


