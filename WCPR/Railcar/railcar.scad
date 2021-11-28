use <fueltank.scad>;

// TODO
// Can we get more rivet detail figured

module ArcRoofFitter(w,h,l) {
	r = (h*h + (w/2) * (w/2))/(2 * h);
	intersection() {
		translate([0,r,0])
			cylinder(r = r, h = l, $fn=64);
		translate([-w/2, 0,0])
			cube([w,h,l]);
	}
}

module ArcRoofedBoxUnit(w,h,l,fh) {
	ArcRoofFitter(w,h,l);
	translate([-w/2,h-0.01,0])
		cube([w,fh,l]);
}

module ArcRoofedBox(w,h,l,fh,t) {
	difference() {
		ArcRoofedBoxUnit(w,h,l,fh);
		translate([0,t,t])
			ArcRoofedBoxUnit(w-2*t, h, l-2*t, fh - t + 0.01);
	}
}

module ArcRoofedBoxRoofArc(w,h,l,t) {
	difference() {
		ArcRoofedBoxUnit(w,h,l,t);
		translate([0,t,-0.01])
			ArcRoofedBoxUnit(w-2*t, h, l+0.02, t);
	}
}

module DrewryTypeBEndWindows() {
	translate([-2,1.3+0.7,-0.5])
		cube([4,5.5,40]);
	translate([3,1.3+0.7,-0.5])
		cube([4,5.5,40]);
	translate([-7,1.3+0.7,-0.5])
		cube([4,5.5,40]);
}

module DrewryTypeBBox(l,w) {
	translate([0,-1.3,0]) {
		difference() {
			union() {
				ArcRoofedBox(16.1,1.3,l,13.4, 0.75);
				translate([0,0,-0.2])
					ArcRoofedBoxRoofArc(16.1,1.3,l + 0.4, 0.3);
			}
			if (w == 1)
				DrewryTypeBEndWindows();
		}
	}
	// Chassis line
	translate([-7.85,13.39,0]) {
		difference() {
			cube([15.7,0.5,l]);
			translate([0.75,-0.05,-0.05])
				cube([14.2,0.6,l+0.1]);
		}
	}
}

module DrewryTypeBCut(l) {
	translate([0,-1.3,0])
			ArcRoofedBox(16.11,1.3,l,13.41, 0.2);
}

module DrewryTypeBEmboss(l,e, w) {
	difference() {
		translate([0,-1.3 - e,-e])
			ArcRoofedBox(16.11 + 2 * e, 1.3 + e,l + 2 * e,13.41, 0.75);
		if (w == 1) {
			translate([0,-1.3,0])
				DrewryTypeBEndWindows();
		}
	}
}

module WCPRSideWindow(x) {
	translate([-10,1,x+0.3])
		cube([20,5,7-0.6]);
}

module WCPRDoorWindow(x) {
	translate([-10,0.7,x])
		cube([20,5.5,3.5]);
}

module WCPRDoorStep(x) {
	translate([-10,12.8,x])
		cube([20,0.4,4]);
}

module WCPRSideWindows() {
	for (i=[0:2])
		WCPRSideWindow(8.1+8*i);
	WCPRDoorWindow(3.65);
	WCPRDoorWindow(31.85);
}

module WCPRSideWindowFrame(x) {
	translate([-10,0.5,x])
		cube([20,6,7]);
}

module WCPRSideWindowFrames() {
	for (i=[0:2])
		WCPRSideWindowFrame(8.1+8*i);
}


module WCPRBufferMount(v) {
	difference() {
		translate([v-1,0,0]) {
			cube([2,2,0.6]);
			translate([0.3,0.3,0])
				cylinder(r=0.2, $fn=10,h=0.75);
			translate([1.7,0.3,0])
				cylinder(r=0.2, $fn=10,h=0.75);
			translate([0.3,1.7,0])
				cylinder(r=0.2, $fn=10,h=0.75);
			translate([1.7,1.7,0])
				cylinder(r=0.2, $fn=10,h=0.75);
		}
	}
}

module WCPRBufferHole(v) {
	translate([v,1,-3])
		cylinder(r=0.4,h=6, $fn=16);
}

module WCPRBufferBeam() {
	difference() {	
		union() {
			translate([-8.05,0,-0.4])
				cube([16.1,3.5,0.8]);
			hull() {
				translate([-7.85,0,-0.4])
					cube([15.7,4.0,0.8]);
				translate([-4.5,0,-0.4])
					cube([9,4.5,0.8]);
			}
			WCPRBufferMount(-6);
			WCPRBufferMount(6);
		}
		union() {
			WCPRBufferHole(-6);
			WCPRBufferHole(6);
		}
	}
}


module WCPRBufferBeamCut() {
	WCPRBufferHole(-6);
	WCPRBufferHole(6);
}


// 108" wheelbase longer than a type B
// typically is
module WCPRNumber1() {
	difference() {
		// Q - 19ft body or 16ft3 body ?
		DrewryTypeBBox(39.14, 1);
		WCPRSideWindows();
		intersection() {
			DrewryTypeBCut(39.14);
			WCPRSideWindowFrames();
		}
		translate([0,9.9,39.13])
			WCPRBufferBeamCut();
		translate([0,9.9,0.1])
			mirror([0,0,1])
				WCPRBufferBeamCut();
	}
	intersection() {
		// Higher band
		DrewryTypeBEmboss(39.14, 0.2, 1);
		translate([-10,6.5,-0.5])
			cube([20,0.3,40]);
	}
	intersection() {
		// Door steps
		DrewryTypeBEmboss(39.14, 0.3, 1);
		union() {
			WCPRDoorStep(3.45);
			WCPRDoorStep(31.65);
		}
	}
	intersection() {
		difference() {
			DrewryTypeBEmboss(39.14, 0.11, 1);
			translate([0,9.9,39.13])
				WCPRBufferBeamCut();
			translate([0,9.9,0.1])
				mirror([0,0,1])
					WCPRBufferBeamCut();
		}
		union() {
			// Body band
			translate([-10,6.5,-0.5])
				cube([20,0.5,40]);
			// Top band
			translate([-10,0.25,-0.5])
				cube([20,0.2,40]);
			// Bottom band
			translate([-10,13.2,-0.5])
				cube([20,0.2,40]);
			// Bodysides
			translate([-10,0.3,3.15])
				cube([20,20,0.3]);
			translate([-10,0.3,7.45])
				cube([20,20,0.3]);
			translate([-10,0.3,15.45])
				cube([20,20,0.3]);
			translate([-10,0.3,23.45])
				cube([20,20,0.3]);
			translate([-10,0.3,31.35])
				cube([20,20,0.3]);
			translate([-10,0.3,35.65])
				cube([20,20,0.3]);
			translate([-10,0.3,0.5])
				cube([20,20,0.3]);
			translate([-10,0.3,39.14-0.8])
				cube([20,20,0.3]);
			translate([-2.65,0.3,-0.5])
				cube([0.3,20,40]);
			translate([2.35,0.3,-0.5])
				cube([0.3,20,40]);
		}
	}
	translate([0,9.9,39.13])
		WCPRBufferBeam();
	translate([0,9.9,0.1])
		mirror([0,0,1])
			WCPRBufferBeam();
}

module WCPRTrailerEndWindows() {
	translate([0.5,0.7,-0.5])
		cube([7,5.5,40]);
	translate([-7.5,0.7,-0.5])
		cube([7,5.5,40]);
}

module WCPRTrailerEmboss(l,e) {
	difference() {
		DrewryTypeBEmboss(l,e,0);
		WCPRTrailerEndWindows();
	}
}

module WCPRTrailerWindow(x) {
	translate([-10,0.5,x])
		cube([20,1.5,5]);
	translate([-10,2.5,x])
		cube([20,3.5,5]);
}

module WCPRTrailerDoorWindow(x) {
	translate([-10,0.7,x])
		cube([20,5.5,3]);
}
module WCPRTrailerWindows(l) {
	WCPRTrailerDoorWindow(2.6+0.6);
	WCPRTrailerDoorWindow(l-2.8-0.4-3);
	WCPRTrailerWindow(l/2+0.75);
	WCPRTrailerWindow(l/2-0.75-5);
}

// Trailer
// Computed by analysing photographic evidence
module WCPRNumber24() {
	l = 14*2.06;
	difference() {
		DrewryTypeBBox(l, 0);
		WCPRTrailerEndWindows();
		WCPRTrailerWindows(l);
		translate([0,9.9,l-0.01])
			WCPRBufferBeamCut();
		translate([0,9.9,0.1])
			mirror([0,0,1])
				WCPRBufferBeamCut();
	}
	intersection() {
		// Higher band
		WCPRTrailerEmboss(l, 0.2);
		translate([-10,6.5,-0.5])
			cube([20,0.3,40]);
	}
	intersection() {
		// Door steps
		WCPRTrailerEmboss(l, 0.3);
		union() {
			WCPRDoorStep(2.7);
			WCPRDoorStep(l-2.7-4);
		}
	}
	intersection() {
		difference() {
			WCPRTrailerEmboss(l, 0.11);
			translate([0,9.9,l-0.01])
				WCPRBufferBeamCut();
			translate([0,9.9,0.1])
				mirror([0,0,1])
					WCPRBufferBeamCut();
		}
		union() {
			// Body band
			translate([-10,6.5,-0.5])
				cube([20,0.5,40]);
			// Top band
			translate([-10,0.25,-0.5])
				cube([20,0.2,40]);
			// Bottom band
			translate([-10,13.2,-0.5])
				cube([20,0.2,40]);
			// Bodysides
			translate([-10,0.3,2.6])
				cube([20,20,0.3]);
			translate([-10,0.3,l-2.6-0.3])
				cube([20,20,0.3]);
			translate([-10,0.3,6.5])
				cube([20,20,0.3]);
			translate([-10,0.3,l-6.5-0.3])
				cube([20,20,0.3]);
			translate([-10,0.3,0.2])
				cube([20,20,0.3]);
			translate([-10,0.3,l-0.5])
				cube([20,20,0.3]);

			translate([-10,6.5,l/2-2.47-0.03])
				cube([20,20,0.3]);
			translate([-10,6.5,l/2+2.47])
				cube([20,20,0.3]);

			translate([-2.65,6.5,-0.2])
				cube([0.3,20,40]);
			translate([2.35,6.5,-0.5])
				cube([0.3,20,40]);
		}
	}
	translate([0,9.9,l-0.01])
		WCPRBufferBeam();
	translate([0,9.9,0.1])
		mirror([0,0,1])
			WCPRBufferBeam();
}

module WCPRSet() {
	WCPRNumber1();
	translate([0,0,45])
		WCPRNumber24();
}

rotate([90,180,-15]) {
	WCPRSet();
	translate([5,12,5])
		WCPRFuelTank();
}
