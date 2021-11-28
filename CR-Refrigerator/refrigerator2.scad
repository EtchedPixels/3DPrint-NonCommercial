// TODO
// CR style top
// 9ft cylinders ?
// Scale length version (33m not 35)



// Van library

// Fit an arc roof to the measurable parameters
// Allow for slack so that we can also print roof
// overhang this way
module ArcRoofFitter(w,h,l,s) {
	// Trust me I worked it out 8)
	r = (h*h + (w/2) * (w/2))/(2 * h);
	intersection() {
		translate([0,r,0])
			cylinder(r = r, h = l, $fn=256);
		translate([-w/2-s, 0,0])
			cube([w+2*s,h+s,l]);
	}
}

module ArcRoofedBoxUnit(w,h,l,fh,s) {
	ArcRoofFitter(w,h,l,s);
	translate([-w/2,h-0.01,0])
		cube([w,fh,l]);
}

// Produce an Arc roofed box
// w - width of the body
// h - height of the roof at centre
// l - length of the vehicle
// fh - height of the flat part of the body
// t - wall thickness
module ArcRoofedBox(w,h,l,fh,t) {
	difference() {
		ArcRoofedBoxUnit(w,h,l,fh,0);
		translate([0,t,t])
			ArcRoofedBoxUnit(w-2*t, h, l-2*t, fh - t + 0.01,0);
	}
}

// Produce a Roof segment to extend the van roof out
// a shade
// s - slack (amount of extra width to allow
module ArcRoofedBoxRoofArc(w,h,l,t,s) {
	difference() {
		ArcRoofedBoxUnit(w,h,l,t,s);
		translate([0,t,-0.01])
			ArcRoofedBoxUnit(w-2*t, h, l+0.02, t, s);
	}
}


// The roof of the van with what we can
// remove cut out of the inside. 
module vanroof(rh) {
	translate([0,rh,0]) {
		mirror([0,1,0])
			difference() {
				translate([0,0,-0.2])
					ArcRoofedBoxUnit(w,1.7,l+0.4,wall,0.3);
				translate([0,wall,wall])
					ArcRoofedBoxUnit(w-2*wall,1.7,l-2*wall,wall,0.3);
			}
	}
}

// A thin slice of roof we stick out of the
// end of the van - below the normal wall
// thickness (as that is too big)
module vanend(rh) {
	translate([0,rh,0]) {
		mirror([0,1,0])
			difference() {
				translate([0,0,-0.4])
					ArcRoofFitter(w,1.7,l+0.8,0.3);
				translate([0,0.3,-0.5])
					ArcRoofFitter(w,1.7,l+1,0.3);
			}
	}
}

// Length of 35.5 but leave ends to their own
// fill

// Side planking
module sideplank(h) {
	translate([0,0.2,0])
		cube([wall,h-0.2,l]);
	translate([0.1,0,0.1])
		cube([wall-0.2,h,l-0.2]);
}


// End planking
module endplank(h) {
	translate([0.1,0.2,0])
		cube([w-0.2,h-0.2,wall]);
	translate([0.1,0,0.1])
		cube([w-0.2,h,wall-0.2]);
}

// Produce a row of the planks specified
module planks(n,h) {
	for(i=[0:n-1]) {
		translate([0,h*i,0])
			child(0);
	}
}

// Floor with hollow centre. We can't make
// the vehicle entirely hollow as we need
// the locating/coupling pegs
module floor() {
	translate([-w/2,0,0])
		cube([w,0.9,4]);

	translate([-w/2,0,l-4])
		cube([w,0.9,4]);

	translate([-w/2-0.2,0,0])
		cube([wall+0.1,0.9,l]);
	translate([w/2-wall,0,0])
		cube([wall+0.2,0.9,l]);

	// Add the pegs
	translate([-bw/2,-bh, l/2-bd])
		cube([bw,bh+1,bl]);
	translate([-bw/2,-bh, l/2+bd-bl])
		cube([bw,bh+1,bl]);
}

// Put the wooden framing around the area
// below the wagon roof
module topwood(h) {
	translate([-w/2,h+0.3,-0.2])
		cube([w,0.4,1]);
	translate([-w/2,h+0.3,l-0.8])
		cube([w,0.4,1]);
	translate([-w/2,h,0])
		cube([w,0.7,wall]);
	translate([-w/2,h,l-wall])
		cube([w,0.7,wall]);

	translate([-w/2-0.2,h+0.3,0])
		cube([wall+0.1,0.4,l]);
	translate([w/2-wall,h+0.3,0])
		cube([wall+0.2,0.4,l]);
	translate([-w/2,h,0])
		cube([wall,0.7,l]);
	translate([w/2-wall,h,0])
		cube([wall,0.7,l]);
}

//
//	A handy helper which lets us apply
// the same thing to each corner rotated
// as necessary
//
module corner(c) {
	if (c == 1)
		translate([-w/2,0,0])
			child(0);
	if (c == 2)
			translate([w/2,0,0])
				mirror([1,0,0])
					child(0);
	if (c == 3)
		translate([-w/2,0,l])
			mirror([0,0,1])
				child(0);
	if (c == 4)
		translate([w/2,0,l])
			mirror([0,0,1])
				mirror([1,0,0])
					child(0);
}

// A helper to apply things to the ends
// either side of their centre line
module end(n,o) {
	if (n == 1) {
		translate([-o,0,0])
			child(0);
		translate([o,0,0])
			mirror([1,0,0])
				child(1);
	} else {
		translate([-o,0,l])
			mirror([0,0,1])
				child(1);
		translate([o,0,l])
			mirror([0,0,1])
				mirror([1,0,0])
					child(0);
	}
}

// Same idea but for sides
module side(n,o) {
	if (n == 1) {
		translate([-w/2,0,l/2-o])
			child(0);
		translate([-w/2,0,l/2+o])
			mirror([0,0,1])
				child(1);
	} else {
		translate([w/2,0,l/2-o])
			mirror([1,0,0])
				child(0);
		translate([w/2,0,l/2+o])
			mirror([1,0,0])
				mirror([0,0,1])
					child(1);
	}
}

// Corner metalwork for the wagon
module cornerplate(h) {
	translate([-0.2,0,-0.2])
		cube([0.4,h,0.6]);
	translate([-0.2,0,-0.2])
		cube([0.6,h,0.4]);
}

// Fixme: rivetting
module sidestrut(h1,h2) {
	translate([-0.1,-sbar,-0.5])
		cube([0.6,h2+sbar,1]);
	translate([0.7,0,-0.5])
		cube([0.3,h2,1]);
	hull() {
		translate([-0.4,-sbar,-0.3])
			cube([0.5,h1+sbar,0.6]);
		translate([-0.1,-sbar,-0.3])
			cube([0.2,h2+sbar,0.6]);
	}
}

module sidecyl(r,h) {
	rotate([0,90,0])
		cylinder(r=r,h=h,$fn=32);
}

module sidebar() {
	hull() {
		translate([-0.2,7.7,0.5])
			sidecyl(r=0.2,h=0.2);
		translate([-0.2,0,12])
			sidecyl(r=0.2,h=0.2);
	}
}

// Angle iron pieces

module rivet() {
	if (detail==1)
		sphere(r=0.1);
}

module rivet_line(x,y,z,dx,dy,dz,n) {
	for(i=[0:n-1])
		translate([x+i*dx,y+i*dy,z+i*dz])
			rivet();
}

module rivets(x1,y1,z1,x2,y2,z2,n,pre,post) {
	total = n + pre + post;
	dx = (x2-x1)/total;
	dy = (y2-y1)/total;
	dz = (z2-z1)/total;
	echo("dx ",dx," dy ",dy," dz ",dz);
	rivet_line(x1+pre*dx,
				  y1+pre*dy,
				  z1+pre*dz,
				  dx,dy,dz,n);
}


module hinge() {
	translate([0,-0.3,0.2])
		rotate([-90,0,0])
			cylinder(r=0.2,h=1,$fn=16);
}

module angleiron() {
	// First add the angles around the corner
	translate([-0.3,0.5,-0.5]) {
		cube([0.6,0.4,2.1]);
		translate([0,0.2,0.3])
			rivet();
		translate([0,0.2,1.6])
			rivet();
		cube([2.4,0.4,0.4]);
		translate([0.85,0.2,0])
			rivet();
		translate([2.1,0.2,0])
			rivet();
	}
	translate([-0.3,14.8,-0.5]) {
		cube([0.6,0.4,2.1]);
		translate([0,0.2,0.3])
			rivet();
		translate([0,0.2,1.6])
			rivet();
		cube([2.4,0.4,0.4]);
		translate([0.85,0.2,0])
			rivet();
		translate([2.1,0.2,0])
			rivet();
	}
	// angles where bars join
	translate([-0.3,0.5,10.5]) {
		cube([0.6,0.4,2]);
		translate([0,0,1.6])
			cube([0.6,2,0.4]);
		translate([0,0.2,0.3])
			rivet();
		translate([0,0.2,1.8])
			rivet();
		translate([0,1.4,1.8])
			rivet();
		translate([0,1.8,1.8])
			rivet();
		translate([0,0.6,1.6])
			cube([0.6,0.4,5]);
		translate([0,0.8,6.6])
			rotate([0,90,0])
				cylinder(r=0.2,h=0.6,$fn=32);
		rivets(0,0.8,1.8,0,0.8,7.3,5,1,0);
		translate([0,0.6,1.6])
			hinge();

	}
	// Now add the angled bars
	hull() {
		translate([-0.3,15,0])
			sidecyl(r=0.2,h=0.4);
		translate([-0.3,0.7,12.3])
			sidecyl(r=0.2,h=0.6);
	}	
	rivets(-0.3,15,0,-0.3,0.7,12.3,
			12,0.9,0.1);
	translate([-0.3,0.7+0.5*1.1,12.3-0.5*0.91])
		rivet();
	// top bar
	translate([-0.3,14.8,10.5]) {
		cube([0.6,0.4,2]);
		translate([0,0.2,0.3])
			rivet();
		translate([0,0.2,1.8])
			rivet();
		translate([0,-1.6,1.6])
			cube([0.6,2,0.4]);
		translate([0,-1.4,1.8])
			rivet();
		translate([0,-1,1.8])
			rivet();
		translate([0,-0.6,1.6])
			cube([0.6,0.4,5]);
		translate([0,-0.4,6.6])
			rotate([0,90,0])
				cylinder(r=0.2,h=0.6,$fn=32);
		rivets(0,-0.4,1.8,0,-0.4,7.3,5,1,0);
		translate([0,-0.6,1.6])
			hinge();
	}
}



// verticals for doors
module doorside() {
	translate([-0.1,0.0])
		cube([wall,15,0.5]);
	translate([0,0,-0.1])
		cube([wall,15,0.6]);
}

// verticals for framing
module sideframe() {
	translate([-0.2,0.0])
		cube([wall,15,0.5]);
}

// Ladder (we merge this into the end for
// strength)

module ladder() {
	if (detail == 1) {
		translate([0,0,-0.3])
		cube([0.3,15.5,wall]);
		translate([-2,0,-0.3])
			cube([0.3,15.5,wall]);
		for (i=[0:9])
			translate([-2,i*1.6+0.6,-0.3])
				cube([2,0.3,wall]);
	}
}

module doorbar(e) {
	if (detail == 1) {
		translate([-0.4,7.6,-5.3]) {
			cube([wall,0.3,5.6]);
			translate([0.2,0.3 + 0.3*e,0])
			rotate([90,0,0])
				cylinder(r=0.2,h=0.6,$fn=32);
		}
	}
}

module roofpod(p) {
	echo(p);
	translate([-3.5,16.6,p]) {
		cube([7,1.0,3.1]);
		translate([-0.1,0.9,0])
			cube([7.2,0.1,3.1]);
	}
}

module ventilator() {
	rotate([0,180,90]) {
		cylinder(r1=0.55,r2=0.4,h=1.7,$fn=32);
		translate([0,0,1.7]) {
			cylinder(r1=0.4,r2=0.55,h=1.7,$fn=32);
			rotate([0,90,0])
				cylinder(r=0.5,$fn=32);
		}
	}
}

// Parameters for Peco 10ft
w = 17.5;		// Wagon width
l = 35.5;		// Wagon length
bd = 15.5;	// Distance from centre to front
				// of coupling block
bw = 4.5;		// Width of coupling block
bl = 1;		// Length of coupling block
bh = 2;		// Height of coupling block
wall = 0.9;	// Wall thickness
floor = 1.0;	// Floor thickness
sbar = 1.5;	// Solebar
detail = 1;	// Set for ladder and bar

module wagonbody() {
	floor();
	topwood(14.5);
	vanroof(15.5+1.7);
	vanend(15.5+1.7);

	roofpod(l/2-16.3);
	roofpod(l/2+16.3-3.1);

	translate([2,17.3,l/2+1.7])
		ventilator();
	translate([-2,17.3,l/2+1.7])
		ventilator();
	

	translate([-w/2,0.2,0])
		planks(13,1.1)
			sideplank(1.1);

	translate([w/2-wall,0.2,0])
		planks(13,1.1)
			sideplank(1.1);

	translate([-w/2,0.2,0])
		planks(13,1.1)
			endplank(1.1);

	translate([-w/2,0.2,l-wall])
		planks(13,1.1)
			endplank(1.1);

	corner(1)
		cornerplate(15.15);
	corner(2)
		cornerplate(15.15);
	corner(3)
		cornerplate(15.15);
	corner(4)
		cornerplate(15.15);

	end(1,2) {
		ladder();
	};

	end(2,2) {
		ladder();
	}

	side(1,5) {
		doorside();
		doorside();
	}

	side(2,5) {
		doorside();
		doorside();
	}

	side(1,5.6) {
		sideframe();
		sideframe();
	}

	side(2,5.6) {
		sideframe();
		sideframe();
	}

	side(1,-0.1) {
		doorside();
		doorside();
	}

	side(2,-0.1) {
		doorside();
		doorside();
	}

	side(1,0) {
		doorbar(0);
		doorbar(1);
	}
	side(2,0) {
		doorbar(0);
		doorbar(1);
	}

	side(1,35/2) {
		angleiron();
		angleiron();
	}

	side(2,35/2) {
		angleiron();
		angleiron();
	}

	
}

module wagoncuts() {
}

module wagon() {
	difference() {
		wagonbody();
		wagoncuts();
	}
}

module wagonrow(n) {
	for(i=[0:n-1])
		translate([20*i,0,0])
			wagon();
}

module wagonpack(n,m) {
	for(i=[0:n-1])
		translate([0,0,40*i])
			wagonrow(m);
}

wagonpack(2,5);

