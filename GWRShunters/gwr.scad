//
//	Generate a side on plank
//
module sideplank(h) {
	translate([0,0.2,0])
		cube([wall,h-0.2,l]);
	translate([0.1,0,0.1])
		cube([wall-0.2,h,l-0.2]);
}

//
//	Generate an end on plank
//
module endplank(h) {
	translate([0.1,0.2,0])
		cube([w-0.2,h-0.2,wall]);
	translate([0.1,0,0.1])
		cube([w-0.2,h,wall-0.2]);
}


//
//	Generate the planks layer by layer
//
module planks(n,h) {
	for(i=[0:n-1]) {
		translate([0,h*i,0])
			child(0);
	}
}

//
//	Output a Peco floor with coupling tabs
//
module PecoFloor() {
	translate([-w/2,0,0])
		cube([w,0.7,l]);
	translate([-w/2+0.4,0,0.4])
		cube([w-0.8,1,l-0.8]);
	translate([-bw/2,-bh, l/2-bd])
		cube([bw,bh+1,bl]);
	translate([-bw/2,-bh, l/2+bd-bl])
		cube([bw,bh+1,bl]);
}

//
//	The toolbox is generated as a hull of
// the rectangles forming each end and the
// one forming the high point
//
module ToolBoxShape() {
	hull() {
		translate([-3,0.9,6.5])
			cube([0.1,3.3,15]);
		translate([-2,0.9,6.5])
			cube([0.1,3.8,15]);
		translate([2.9,0.9,6.5])
			cube([0.1,2.8,15]);
	}
}

module ToolBoxHinge() {
	hull() {
		translate([-2.8,0.9,6.5])
			cube([0.1,3.9,0.7]);
		translate([-2.3,0.9,6.5])
			cube([0.1,4.4,0.7]);
	}
	translate([-2.3,0.9,6.5])
		cube([0.7,4.8,0.7]);
}

//
//	Generate a cutting pattern for cutting
// the planks into the toolbox shape
//
module CubeSlicer() {
	difference() {
		translate([0,0,1.2])
			cube([6,0.2,13]);
		translate([0.2,-0.1,1.2])
			cube([5.6,0.4,12.6]);
	}
	difference() {
		translate([1,0,0])
			cube([4,0.2,15]);
		translate([1.2,-0.1,0.2])
			cube([3.6,0.4,14.6]);
	}
}

//
//	Assemble the cutters into a single
// object
//
module ToolBoxCutters() {
	translate([-3,0.9+1.1,6.5])
		CubeSlicer();
	translate([-3,0.9+2.2,6.5])
		CubeSlicer();
	translate([-3,0.9+3.3,6.5])
		CubeSlicer();
}


//
//	Put the lid on the toolbox. This is the
// same idea but two hulls as we need the
// shape preserved and also only to plank
// the long side
//
module ToolBoxTopSlice(n) {
	hull() {
		translate([-3,3.9,6.2])
			cube([0.1,0.5,n]);
		translate([-2,4.4,6.2])
			cube([0.1,0.5,n]);
	}
	hull() {
		translate([-2,4.4,6.2])
			cube([0.1,0.5,0.9]);
		translate([2.9,3.4,6.2])
			cube([0.1,0.5,0.9]);
	}
}

//
//	Assemble the toolbox out of the slices
//
module ToolBoxTop() {
	for (i=[0:13]) {
		translate([0,0,i*1.13])
			if (i != 13)
				ToolBoxTopSlice(1.14);
			else
				ToolBoxTopSlice(0.9);
	}
	translate([0,0,1.1])
		ToolBoxHinge();
	translate([0,0,14.3-1.13])
		ToolBoxHinge();
	translate([0,0,7.5-2.4])
		ToolBoxHinge();
	translate([0,0,7.5+1.7])
		ToolBoxHinge();
}

//
//	Put the entire toolbox together
//
module ToolBox() {
	difference() {
		ToolBoxShape();
		ToolBoxCutters();
	}
	ToolBoxTop();
}

// Parameters for Peco 10ft chassis cut
// down for the shunters truck
w = 15.5;		// Wagon width
l = 28;		// Wagon length
bd = 12;		// Distance from centre to front
				// of coupling block
bw = 4.5;		// Width of coupling block
bl = 1;		// Length of coupling block
bh = 2;		// Height of coupling block
wall = 0.5;	// Wall thickness
floor = 1.0;	// Floor thickness
sbar = 1.5;	// Solebar

module TruckBody() {
	PecoFloor();

	// Generate low planks around the edges
	translate([-w/2,0.4,0])
		planks(1,1)
			sideplank(0.4);

	translate([w/2-wall,0.4,0])
		planks(1,1)
			sideplank(0.4);

	translate([-w/2,0.4,0])
		planks(1,1)
			endplank(0.4);

	translate([-w/2,0.4,l-wall])
		planks(1,1)
			endplank(0.4);

	// Stick the toolbox on top
	ToolBox();
}


//
//	Vertical cylinder for the handrails
//
module PoleHole() {
	rotate([-90,0,0])
		cylinder(r=0.3,h=5,$fn=16, center=true);
}

//
//	Set of cylinders for all the handrail holes
//
module PoleCuts() {
	translate([-w/2+1.5,0.4,1.5])
		PoleHole();
	translate([w/2-1.5,0.4,1.5])
		PoleHole();
	translate([-w/2+1.5,0.4,l-1.5])
		PoleHole();
	translate([w/2-1.5,0.4,l-1.5])
		PoleHole();
	translate([-w/2+1.5,0.4,l/2-((l-3)/6)])
		PoleHole();
	translate([w/2-1.5,0.4,l/2-((l-3)/6)])
		PoleHole();
	translate([-w/2+1.5,0.4,l/2+((l-3)/6)])
		PoleHole();
	translate([w/2-1.5,0.4,l/2+((l-3)/6)])
		PoleHole();
}

//
//	All the bits to cut out
//
module TruckCuts() {
	// Plank the wagon floor
	for(i=[0:22])
		translate([-(w-1.8)/2,0.9,i*1.16+0.5+1.16/2])
			cube([w-1.8,0.25,0.3]);
	PoleCuts();
}

// The final truck is the wagon minus the
// cutouts
module GWRShuntersTruck() {
	difference() {
		TruckBody();
		TruckCuts();
	}

}

for (i = [0:3]) {
	translate([16.2 * i, 0, 0])
		GWRShuntersTruck();
	translate([8.1 + 16.2 * i, 8, 0])
		rotate([0,0,180])
			GWRShuntersTruck();
	translate([16.2 * i, 12, 0])
		GWRShuntersTruck();
	translate([8.1 + 16.2 * i, 20, 0])
		rotate([0,0,180])
			GWRShuntersTruck();
}
