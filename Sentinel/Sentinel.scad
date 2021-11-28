// Notes
// GWR: no side grilles, coal covers
// LNER: side grilles, open coal area
// LNER 8400 - no grilles ? angled buffer beam, deep side steps, no raised roof bit
// LNER 62 - grilles, shallow steps
// LNER 150 - no grilles handrail near front
// LNER 94 - grilles, raised roof bit
//
// Hinge on end of tank filler ?

//	TODO
//	Rear grille space
//	Detail on roof hatch
// Hole for whistle
// Roof rainstrips and joins
// 0.1mm raise for joins/strips/window frames
// buffer beam coupling hook slot
// chassis wheels area etc
// Rivets
// Grab rails
// Front grab option
// Grilles as option
// Hatch as option
// Sandboxes
// Holes to shove in foot steps ?



//
//	Library routines
//
module vcylinder(r,h) {
	rotate([270,0,0])
		cylinder(r=r,h=h,$fn=64);
}

//
//	Arc Roof Library
//
module ArcRoofFitter(w,h,l) {
        r = (h*h + (w/2) * (w/2))/(2 * h); 
        intersection() {
                translate([0,r,0])
                        cylinder(r = r, h = l, $fn=128);
                translate([-w/2, 0,0])
                        cube([w,h,l]);
        }
}

module ArcRoof(w,h,l,t) {
        difference() {
                ArcRoofFitter(w,h,l);
                translate([0,t+0.01,-0.01])
                        ArcRoofFitter(w-2*t,h-t,l+0.02);
        }
}

module Rivet() {
	sphere(r=0.1);
}

module RivetAlong(l,n) {
	for(i=[0:n-1])
		translate([0,0,(l/(n-1))*i])
			Rivet();
}

module RivetDown(l,n) {
	for(i=[0:n-1])
		translate([0,(l/(n-1))*i,0])
			Rivet();
}

module RivetAcross(l,n) {
	for(i=[0:n-1])
		translate([(l/(n-1))*i,0,0])
			Rivet();
}

module RoofBlock() {
	translate([0,0,-0.5])
	ArcRoofFitter(15.6, 1.3, 23);
	translate([-15.6/2,1.3,-0.5])
		cube([15.6,0.3,23]);
	translate([0,-0.75,1])
		ArcRoofFitter(6.5,0.4,6);
	translate([-3,-0.4,1])
		cube([6,2,6]);
}

module Chimney() {
	hull() {
		translate([-0.8,-1.4,19])
			vcylinder(r=0.8,h=3);
		translate([0.8,-1.4,19])
			vcylinder(r=0.8,h=3);
	}
}

module Roof() {
	mirror([0,1,0]) {
		RoofBlock();
		Chimney();
	}
}
	
module Buffer() {
	hull() {
		translate([-1,-1,0])
			cube([2,2,0.01]);
		translate([-1.3,-1.3,0.1])
			cube([2.6,2.6,0.01]);
	}
	cylinder(r=0.75,h=2.5, $fn=32);
	// Stem so the print merges nicely
	// and they can in theory print alone
	translate([0,0,-1])
		cylinder(r=1,h=2.4, $fn=32);
	translate([0,0,2.3])
		cylinder(r=1.75,h=0.7, $fn=32);
}

module ChassisBlock() {
	// Form the solid block and edges. Ignore
   // the tiny bottom edge as it is too small
	// to print
	translate([-8,0,0])
		cube([16,3.0,0.5]);
	translate([-8,0,31.5])
		cube([16,3.0,0.5]);
	// Fixme - does the top solebar line
   // up with the buffer beam ?
	// Have to keep main solebars slightly
	// overwide. Chassis needs 13mm to clear
	// N scale wheels (or could etch ..)
	translate([-8,2.5,0])
		cube([16,0.8,32.0]);
	translate([-7.5,0,0])
		cube([15,3.0,32.0]);

	// Add buffers
	translate([-5.5,1.5,32])
		Buffer();
	translate([5.5,1.5,32])
		Buffer();
	translate([-5.5,1.5,0])
		mirror([0,0,1])
			Buffer();
	translate([5.5,1.5,0])
		mirror([0,0,1])
			Buffer();

}

module ChassisHole() {
	translate([-6.5,-0.1,1])
		cube([13,3.5,30.0]);

}


module Chassis() {
	difference() {
		ChassisBlock();
		ChassisHole();
	}
}

module Tub(w,h,f,b) {
	hull() {
		translate([-w/2+1,0,f])
			vcylinder(r=1,h=h);
		translate([w/2-1,0,f])
			vcylinder(r=1,h=h);
		translate([-w/2+1,0,b])
			vcylinder(r=1,h=h);
		translate([w/2-1,0,b])
			vcylinder(r=1,h=h);
	}
}

module CoreShellBlock() {
	Tub(15,11.6,1.3,30.7);
	Tub(15.2,0.4,1.2,30.8);
	translate([0,6.6,0])
		Tub(15.2,0.4,1.2,30.8);
	translate([-7.6,0.2,1.6])
		RivetAlong(30.4-1.6,40);
	translate([7.6,0.2,1.6])
		RivetAlong(30.4-1.6,40);
	translate([-7.6,6.8,1.6])
		RivetAlong(30.4-1.6,40);
	translate([7.6,6.8,1.6])
		RivetAlong(30.4-1.6,40);
}

module CoreShellHollow() {
	translate([0,-1,0])
		Tub(12,15.5,2.3,29.7);
}

module CoreShellTankCut() {
	translate([-10,7,0])
		cube([20,10,10.2]);
	hull() {
		translate([-6.0,6,1.8])
			vcylinder(r=1,h=1.1);
		translate([6.0,6,1.8])
			vcylinder(r=1,h=1.1);
		translate([-7,6,10.2])
			cube([14,1.1,0.1]);
	}
}

module CoreShellCabFrontWindowHole() {
	translate([0,0,-1])
		cube([3.5,3.7,3]);
}

module CoreShellCabFrontWindow() {
	translate([-0.3,-0.3,-0.2])
		cube([4.1,4.3,1]);
	// Rivets
}

module CoreShellCabBackWindowHole() {
	translate([0,0,-1])
		cube([3.5,3.7,3]);
}

module CoreShellBackWindowHoles() {
		// Cut out window holes
		translate([-5.8,7.6,30.7])
			CoreShellCabBackWindowHole();
		translate([5.8-3.5,7.6,30.7])
			CoreShellCabBackWindowHole();
}

module CoreShellCabBackWindow() {
	translate([-0.3,-0.3,0.2])
		cube([4.1,4.3,1]);
	// Rivets
}

module CoreShellCabBackWindows() {
		// Cab window frames
		translate([-5.8,7.6,30.7])
			CoreShellCabBackWindow();
		translate([5.8-3.5,7.6,30.7])
			CoreShellCabBackWindow();
}

module CoreShellCabFront() {
	difference() {
		union() {
			translate([-7.5,5,10.2])
				cube([15,6.6,1]);
			translate([-5.8,7.6,10.2])
				CoreShellCabFrontWindow();
			translate([5.8-3.5,7.6,10.2])
				CoreShellCabFrontWindow();
		}
		// Cut out window holes
		translate([-5.8,7.6,10.2])
			CoreShellCabFrontWindowHole();
		translate([5.8-3.5,7.6,10.2])
			CoreShellCabFrontWindowHole();
	}
	// Add window detail here

	// FIXME - bigger hole so can do detail better ?
}

module CoreShellWaterCap() {
	vcylinder(r=1.15,h=3.9);
	translate([0,3.3,0])
		vcylinder(r=1.25,h=0.3);
	translate([0,3.59,0])
		vcylinder(r=1.35,h=0.31);
	// FIXME scaled sphere for dome top
}

module CoreShellCabTank() {
	hull() {
		translate([-6.5,5,1.3])
			vcylinder(r=1,h=1);
		translate([6.5,5,1.3])
			vcylinder(r=1,h=1);
		translate([-7.5,5,10.2])
			cube([15,1,0.1]);
	}
	translate([-3.5,5.7,0.3])
		cube([7,1,10.0]);
	for (i=[1:10])
		translate([-3.5,5.9,0.3+(10*i)/11])
			cube([7,1,0.2]);
	translate([0,6,4])
		CoreShellWaterCap();
}

module CoreShellSideWindowHoles() {
	translate([-10,7,15.7])
		cube([20,4.5,3]);
	translate([-10,7.3,21.3])
		cube([20,3.7,3.7]);
}

// Framing and windows - should be 0.1mm ??

module CoreShellCabSideWindows() {
	// Frame the cab door
	translate([-7.6,6.8,15.5])
		cube([0.3,4.9,3.4]);
	translate([7.3,6.8,15.5])
		cube([0.3,4.9,3.4]);
	// Frame the windows
	translate([-7.6,7.1,21.1])
		cube([0.3,4.1,4.1]);
	translate([7.3,7.1,21.1])
		cube([0.3,4.1,4.1]);
	// Bars down the cab window/door area
	translate([-7.6,0,15.5]) {
		cube([0.3,6.8,0.2]);
		translate([0,0.2,0.1])
			RivetDown(6.4,10);
	}
	translate([7.3,0,15.5]) {
		cube([0.3,6.8,0.2]);
		translate([0.3,0.2,0.1])
			RivetDown(6.4,10);
	}
	translate([-7.6,0,18.7]) {
		cube([0.3,6.8,0.2]);
		translate([0,0.2,0.1])
			RivetDown(6.4,10);
	}
	translate([7.3,0,18.7]) {
		cube([0.3,6.8,0.2]);
		translate([0.3,0.2,0.1])
			RivetDown(6.4,10);
	}
}

module CoreShellEndFraming() {
	translate([-7.6,0,1.5]) {
		cube([0.3,7,0.2]);
		translate([0,0.2,0.1])
			RivetDown(6.6,10);
	}
	translate([7.3,0,1.5]) {
		cube([0.3,7,0.2]);
		translate([0.3,0.2,0.1])
			RivetDown(6.6,10);
	}
	translate([-7.6,0,30.3]) {
		cube([0.3,11.7,0.2]);
		translate([0,0.2,0.1])
			RivetDown(11.2,20);
	}
	translate([7.3,0,30.3]) {
		cube([0.3,11.7,0.2]);
		translate([0.3,0.2,0.1])
			RivetDown(11.2,20);
	}
	// Cab front join.. 
	// FIXME - when add to front will 
	// need to adjust positions to match
	translate([-7.6,7,10.2]) {
		cube([0.3,4.7,0.2]);
		translate([0,0.2,0.1])
			RivetDown(4.1,8);
	}
	translate([7.3,7,10.2]) {
		cube([0.3,4.7,0.2]);
		translate([0.3,0.2,0.1])
			RivetDown(4.1,8);
	}
}

module CoreShellGrilleInlay() {
	translate([-7.7,1.2,24.5])
		cube([0.3,4.2,4.2]);
	translate([7.4,1.2,24.5])
		cube([0.3,4.2,4.2]);
	translate([-5.5,1.5,31.5])
		cube([4.2,4.2,0.3]);
	translate([1.3,1.5,31.5])
		cube([4.2,4.2,0.3]);
}

module CoreShell() {
	difference() {
		union() {
			CoreShellBlock();
			CoreShellCabBackWindows();
			CoreShellCabSideWindows();
		}
		CoreShellBackWindowHoles();
		CoreShellTankCut();
		CoreShellHollow();
		CoreShellSideWindowHoles();
		CoreShellGrilleInlay();
	}
	CoreShellCabFront();
	CoreShellCabTank();
	CoreShellEndFraming();
}

CoreShell();
translate([0,-3,0])
	Chassis();
translate([0,13.15,9.9])
	Roof();


