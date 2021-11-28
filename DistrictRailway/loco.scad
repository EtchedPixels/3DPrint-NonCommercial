//TODO:
// roof grilles ?
module RoundedBlock(w,h,r,l) {
	translate([0,r,0])
		cube([w,h-2*r,l]);
	translate([r,0,0])
		cube([w-2*r,h,l]);
	translate([r,r,0])
		cylinder(r=r,h=l,$fn=32);
	translate([w-r,r,0])
		cylinder(r=r,h=l,$fn=32);
	translate([r,h-r,0])
		cylinder(r=r,h=l,$fn=32);
	translate([w-r,h-r,0])
		cylinder(r=r,h=l,$fn=32);
}

module RoundedEndWindow(y,w,h) {
	translate([-w/2,y,-1]) {
		RoundedBlock(w,h,0.5,55);
	}
}

module RoofArc(i,w,r,rh) {
	translate([0,10.3])
	intersection() {
		translate([0,i,0])
			circle(r=r+i,$fn=64);
		translate([-w/2,-r,0])
			square([w,rh]);
	}
}


// w = width of roof to generate
// r = arc of roof
// l = total length of the roof
// h = height of roof segment
module RoofEnd(w,r,l,h) {
	intersection() {
		translate([-w/2,-10.3,-20])
			cube([w,h,20.6]);
		translate([0,10.3,-20])
			cylinder(r=r,h=59,$fn=64);
		hull() {
			for(i=[0:9])
				rotate([i*10,0,0])
					linear_extrude(height=0.1)
							RoofArc(10*i,w,r,h);
			translate([-w/2,-10.3+h-0.1,-8.1])
				cube([w,0.1,0.1]);
		}
	}
}

module DistrictElectricRoof(w,r,l,h)
{
	translate([0,-10.3,0])
		RoofEnd(w,r,l,h);
	intersection() {
		cylinder(r=r,h=l,$fn=64);
		translate([-w/2,-r,0])
			cube([w,h,l]);
	}
	translate([0,-10.3,l])
		mirror([0,0,1])
			RoofEnd(w,r,l,h);
}

module DistrictElectricRoofCut(w,r,l,w2,h)
{
	intersection() {
		DistrictElectricRoof(w,r,l,h);
		union() {
			translate([-w/2,-20.6,-10.3])
				cube([w2,10,l+20.6]);
			translate([w/2-w2,-20.6,-10.3])
				cube([w2,10,l+20.6]);
			translate([-w/2+w2+1,-20.6,-10.3])
				cube([w-2*w2-2,10,l+20.6]);
		}
	}
}

module DistrictElectricUnitRoof() {
	h = 4.3; // 3.8
	translate([0,16.8-0.5,8.1])
	difference() {
		union() {
			DistrictElectricRoof(11.9,20.6,53-16.2,h);
			translate([0,-0.3,0])
				DistrictElectricRoof(0.5,20.6,53-16.2,h);
		}
		translate([0,0.7,0.5])
			DistrictElectricRoofCut(12.1,20.6,52-16.2,1,h);
	}
}

module DistrictElectricRoofBase(w,r,l,h) {
	translate([0,-10.3,0])
		RoofEnd(w,r,l,h);
	intersection() {
		cylinder(r=r,h=l,$fn=64);
		translate([-w/2,-r,0])
			cube([w,h,l]);
	}
	translate([0,-10.3,l])
		mirror([0,0,1])
			RoofEnd(w,r,l,h);
}

module DistrictElectricUnitRoofBase() {
	difference() {
		intersection() {
			translate([0,16.8+1.5,7.9])
				DistrictElectricRoofBase(18.2,20.6,52-14.8,2.3);
			translate([-10,-1.4,0])
				cube([20,1.4,53]);
		}
		translate([-9.9/2,-1.5,7])
			cube([9.9,5,53-14]);
	}
}

module DistrictElectricBodyBox(double_ended) {
	translate([-9.1,-0.01,0]) {
		difference() {
			union() {
				// Body Shell
				cube([18.2,15.21,53]);
				// Body bands across roof join
				translate([-0.2,0,-0.2])
					cube([18.6,0.4,53.4]);
				// Bodyside floor line
				translate([-0.2,15,0])
					cube([18.6,0.2,53]);
				// Mid body panel joins
				translate([-0.2,8.6,1.5])
					cube([18.6,0.5,50]);
				translate([0.9,8.6,-0.2])
					cube([17.4,0.5,53.4]);
				// Over window seam
				translate([-0.1,1.2,-0.1])
					cube([18.4,0.1,53.2]);
				// Corner Bracing
				translate([-0.1,0,-0.1])
					cube([0.8,15.2,1.4]);
				translate([18.2-0.7,0,-0.1])
					cube([0.8,15.2,1.4]);
				translate([-0.1,0,53-1.3])
					cube([0.8,15.2,1.4]);
				translate([18.2-0.7,0,53-1.3])
					cube([0.8,15.2,1.4]);
				// Lower brackets
				translate([-0.2,14.2,-0.2])
					cube([0.9,1,1.4]);
				translate([18.2-0.7,14.2,-0.2])
					cube([0.9,1,1.4]);
				translate([-0.2,14.2,53-1.2])
					cube([0.9,1,1.4]);
				translate([18.2-0.7,14.2,53-1.2])
					cube([0.9,1,1.4]);
				// Vertical Seams
				translate([-0.1,1.2,1.3])
					cube([18.4,14,0.1]);
				translate([-0.1,1.2,53-1.3-0.1])
					cube([18.4,14,0.1]);
				translate([-0.1,1.2,6.6])
					cube([18.4,14,0.1]);
				translate([-0.1,1.2,53-6.5-0.1])
					cube([18.4,14,0.1]);
				translate([-0.1,1.2,31.4])
					cube([18.4,14,0.1]);
				translate([-0.1,1.2,53-31.4-0.1])
					cube([18.4,14,0.1]);
				translate([-0.1,1.2,36.8])
					cube([18.4,14,0.1]);
				translate([-0.1,1.2,53-36.8-0.1])
					cube([18.4,14,0.1]);
				translate([-0.1,1.2,23.8])
					cube([18.4,14,0.1]);
				translate([-0.1,1.2,53-23.8-0.1])
					cube([18.4,14,0.1]);
				translate([-0.1,1.2,8.8])
					cube([18.4,14,0.1]);
				translate([-0.1,1.2,53-8.8-0.1])
					cube([18.4,14,0.1]);
				translate([-0.1,1.2,14])
					cube([18.4,14,0.1]);
				translate([-0.1,1.2,53-14-0.1])
					cube([18.4,14,0.1]);
				// End Seams
				translate([0.8,1.2,-0.1])
					cube([0.1,14,53.2]);
				translate([18.2-0.8-0.1,1.2,-0.1])
					cube([0.1,14,53.2]);
				translate([5.8,0.8,-0.1])
					cube([0.1,12.5,53.2]);
				translate([18.2-5.8-0.1,0.8,-0.1])
					cube([0.1,12.5,53.2]);

				// Steps below doors
				translate([18.1,13.3,6.6])
					cube([0.4,1.9,9.6]);
				translate([-0.2,13.3,53-6.6-9.6])
					cube([0.3,1.9,9.6]);
				// Lamps
				// FIXME: one end only for most
				// units!
				if (double_ended == 1) {
					translate([2,10.1,-0.2])
						cylinder(r=0.55,h=53.4,$fn=32);
					translate([2,12.3,-0.2])
						cylinder(r=0.55,h=53.4,$fn=32);
					translate([16.2,10.1,-0.2])
						cylinder(r=0.55,h=53.4,$fn=32);
					translate([16.2,12.3,-0.2])
						cylinder(r=0.55,h=53.4,$fn=32);	
				} else {
					translate([2,10.1,-0.2])
						cylinder(r=0.55,h=5,$fn=32);
					translate([2,12.3,-0.2])
						cylinder(r=0.55,h=5,$fn=32);
					translate([16.2,10.1,-0.2])
						cylinder(r=0.55,h=5,$fn=32);
					translate([16.2,12.3,-0.2])
						cylinder(r=0.55,h=5,$fn=32);	
				}
			}
			translate([0.8,-0.01,0.8])
				cube([18.2-1.6,15.3,53-1.6]);
		}
		translate([18.2-1.5,0.6,6.5])
			cube([1.5,13.5,9.6]);
		translate([0,0.6,53-9.6-6.5])
			cube([1.5,13.5,9.6]);
	}
	translate([-6.7/2,0.7,0])
		cube([6.7,12.8,1.5]);
	translate([-6.7/2,0.7,53-1.5])
		cube([6.7,12.8,1.5]);
	translate([-5.1/2,0.5,-0.2])
		cube([5.1,13.0,1.5]);
	translate([-5.1/2,0.5,53-1.3])
		cube([5.1,13.0,1.5]);
}

module Buffer() {
	translate([-1,-1,-0.1])
		cube([2,2,0.2]);
	cylinder(r=1,h=0.5,$fn=32);
	cylinder(r=0.8,h=0.7,$fn=32);
	cylinder(r=0.6,h=0.8,$fn=32);
	cylinder(r=0.5,h=2.2,$fn=32);
	cylinder(r=0.4,h=2.7,$fn=32);
	translate([0,0,2.4])
		cylinder(r1=1.2,r2=1.1,h=0.6,$fn=32);
}

module AntiClimberStep() {
	rotate([45,0,0])
		cube([9.6,0.5,0.5]);
}

module AntiClimber() {
	for(i=[0:4])
	translate([-4.8,-0.2+0.25*i,-0.1])
		AntiClimberStep();
}

module AntiClimberBlocks() {
	translate([-5.5,-1,-1])
		cube([3,2,5]);
	translate([-4.5/2,-1,-1])
		cube([4.5,2,5]);
	translate([2.5,-1,-1])
		cube([3,2,5]);
}

module BufferBeam() {
	translate([-6,0,0])
		Buffer();
	translate([6,0,0])
		Buffer();
	intersection() {
		AntiClimber();
		AntiClimberBlocks();
	}
	translate([-7,-1,-0.4])
		cube([14,2,0.5]);
}

module DistrictElectricBufferBeams() {
	translate([0,14,0])
		mirror([0,0,1])
			BufferBeam();
	translate([0,14,53])
		BufferBeam();
}

module DistrictElectricBodyAssembly(double_ended) {
	translate([0,0,0]) {
		DistrictElectricUnitRoof();
		DistrictElectricUnitRoofBase();
		DistrictElectricBodyBox(double_ended);
		DistrictElectricBufferBeams();
	}
}


module WindowCurve() {
	intersection() {
		translate([0,10.3,0])
			rotate([0,90,0])
				cylinder(r=10.3,h=5,$fn=128);
		translate([0,0,-4.5/2])
			cube([5,4.5,4.5]);
	}
}

module CabWindowCurve() {
	intersection() {
		translate([0,10.3,0])
				cylinder(r=10.3,h=5,$fn=128);
		translate([-3.6/2,0,0])
			cube([3.6,4.5,5]);
	}
}

module DistrictElectricWindowHole(x) {
	translate([9.11,1.3,x]) {
		translate([-0.1,0,0])
			cube([0.1,7.3,5]);
		translate([-1,0.4,0.25])
			cube([2,1.2,4.5]);
		translate([0,2.3,4.5/2+0.25])
			mirror([1,0,0])
				WindowCurve();
	}
	translate([-9.11,1.3,53-x-5]) {
		cube([0.1,7.3,5]);
		translate([0,0.4,0.25])
			cube([2,1.2,4.5]);
		translate([0,2.3,4.5/2+0.25])
			WindowCurve();
	}
}

module DistrictElectricCabWindowHole(x) {
	translate([-x,1.3,-1]) {
		cube([4.1,7.3,1.1]);
		translate([0.25,0.4,0])
			cube([3.6,1.2,2]);
		translate([0.25+3.6/2,2.3,0])
			CabWindowCurve();
	}
	translate([x-4.1,1.3,-1]) {
		cube([4.1,7.3,1.1]);
		translate([0.25,0.4,0])
			cube([3.6,6.4,2]);
	}
	translate([x-4.1,1.3,53-0.1]) {
		cube([4.1,7.3,1]);
		translate([0.25,0.4,-1])
			cube([3.6,1.2,2]);
		translate([0.25+3.6/2,2.3,-1])
			CabWindowCurve();
	}
	translate([-x,1.3,53-0.1]) {
		cube([4.1,7.3,1.1]);
		translate([0.25,0.4,-2])
			cube([3.6,6.4,3]);
	}
}

module RoofCutGrilleC() {
	for(i=[0:6])
		translate([0,0.2*i,0])
			cube([5.2,0.1,4.1]);
}

module DistrictElectricRoofHoleC(x) {
	translate([-10,-2.7,x-4.1/2])
		RoofCutGrilleC();
	translate([4.8,-2.7,x-4.1/2])
		RoofCutGrilleC();
}

module SideDoorCutPanel() {
	difference() {
		cube([1.7,3,2.5]);
		translate([-0.1,0.2,0.2])
			cube([1.9,2.6,2.1]);
	}
}

module SideDoorCutWindow(){
	rotate([0,-90,0])
	RoundedBlock(2.5,3.5,0.5,6);
//	cube([2,3.5,2.5]);
}

module SideDoorCut() {
	translate([3,0.6,0.6])
		SideDoorCutWindow();
	translate([3,0.6,4])
		SideDoorCutWindow();
	translate([-0.1,4.3,0.6])
		SideDoorCutPanel();
	translate([-0.1,4.3,4])
		SideDoorCutPanel();
	translate([-0.1,8,0.6])
		SideDoorCutPanel();
	translate([-0.1,8,4])
		SideDoorCutPanel();
}

module DistrictElectricDoorRecess(x) {
	translate([18.2/2-0.5,0.5,x+2.3/2]) {
		cube([1.5,12.8,7.3]);
		SideDoorCut();
	}
	translate([-18.2/2-1.01,0.7,53-x-2.3/2-7.3]) {
		cube([1.51,12.8,7.3]);
		SideDoorCut();
	}
}



module EndDoorPanel() {
	difference() {
		translate([-3.4/2,8.8,0])
			cube([3.4,3.2,0.2]);
		translate([-2.8/2,9.1,0])
			cube([2.8,2.6,0.2]);
	}
}

module DistrictElectricNoseDoorRecess() {
	translate([-4.7/2,0.7,-1])
		cube([4.7,12.7,1.5]);
	translate([-4.7/2,0.7,53-0.5])
		cube([4.7,12.7,1.5]);
	RoundedEndWindow(3.2,3.4,4.9);
	RoundedEndWindow(1.2,3.4,1.4);
	translate([0,0,0.49])
		EndDoorPanel();
	translate([0,0,52.31])
		EndDoorPanel();
}

module DistrictElectricWindowCuts() {
	DistrictElectricWindowHole(1.5);
	DistrictElectricWindowHole(31.6);
	DistrictElectricWindowHole(46.6);

	DistrictElectricRoofHoleC(53/2);
	DistrictElectricRoofHoleC(53/2-7.5);
	DistrictElectricRoofHoleC(53/2-15);
	DistrictElectricRoofHoleC(53/2+7.5);
	DistrictElectricRoofHoleC(53/2+15);

	DistrictElectricDoorRecess(6.5);
	DistrictElectricNoseDoorRecess();

	DistrictElectricCabWindowHole(7.7);
}

module ShapewaysFix() {
	translate([-9.1,14,25.5])
		cube([18.2,1,1]);
}

module Unit(double_ended) {
	difference() {
		DistrictElectricBodyAssembly(double_ended);
		DistrictElectricWindowCuts();
	}
	ShapewaysFix();
}

module DistrictSet(double_ended) {
	Unit();
	if (double_ended==0) {
		translate([0,0,113])
			rotate([0,180,0])
				Unit(double_ended);
	}
}

DistrictSet(0);
