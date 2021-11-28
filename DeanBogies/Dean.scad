use <../Coupling/coupling-arm.scad>;

module axle_shape() {
	cylinder(r=0.75,h=axlelength-1.2, center=true, $fn=16);
	translate([0,0,-axlelength/2+0.3])
		cylinder(r1=0.1,r2=0.75, h=0.61, center=true, $fn=16);
	translate([0,0,axlelength/2-0.3])
		cylinder(r2=0.1,r1=0.75, h=0.61, center=true, $fn=16);
	translate([0,0,-4.01])
		cylinder(r1=wheelradius+0.3,r2=wheelradius+0.6, h=0.4, center=true, $fn=32);
	translate([0,0,-4.81])
		cylinder(r1=wheelradius,r2=wheelradius+0.1,h=2, center=true, $fn=32);
	translate([0,0, 4.81])
		cylinder(r2=wheelradius,r1=wheelradius+0.1,h=2, center=true, $fn=32);
	translate([0,0,4.01])
		cylinder(r2=wheelradius+0.3,r1=wheelradius+0.6, h=0.4, center=true, $fn=32);
}

// Axle in plane of bogie assembly
module axle() {
	rotate([0,90,90])
		axle_shape();
}

module axle_cut() {
	rotate([0,90,90])
		cylinder(r=0.3,h=axlelength+0.8, center=true,$fn=32);
}

module GWRaxlebox() {
	// Main shape of axlebox (back)
	hull() {
		translate([-0.4,0.6,0])
			cylinder(r=0.1,$fn=32,h=1);
		translate([0.4,0.6,0])
			cylinder(r=0.1,$fn=32,h=1);
		translate([-0.4,1.9,0])
			cylinder(r=0.1,$fn=32,h=1);
		translate([0.4,1.9,0])
			cylinder(r=0.1,$fn=32,h=1);
		translate([-0.3,0.45,0])
			cube([0.6,0.05,1]);
	}

	// Top part of axlebox shape
	hull() {
		translate([-0.3,0.45,0])
			cube([0.6,0.05,1]);
		translate([-0.25,0.05,0])
			cylinder(r=0.05,$fn=32,h=1);
		translate([0.25,0.05,0])
			cylinder(r=0.05,$fn=32,h=1);
	}
	// top bit of axlebox to spring area
	translate([-0.25,-0.6,0.1])
		cube([0.5,0.81,0.8]);
	// top of axlebox front
	hull() {
		translate([0,1.3,-0.2])
			cylinder(r=0.5,h=1.2,$fn=32);
		translate([-0.4,1.9,-0.2])
			cylinder(r=0.1,$fn=32,h=0.21);
		translate([0.4,1.9,-0.2])
			cylinder(r=0.1,$fn=32,h=0.21);
	}
	// Bottom bit
	hull() {
		translate([0,0.7,-0.2])
			cylinder(r=0.1,h=1.2,$fn=32);
		translate([-0.2,1,-0.2])
			cube([0.4,0.1,1]);
	}
	// Bar across
	translate([-0.5,1.3,-0.25])
		cube([1,0.2,1]);
	// Nipple
	translate([0,1.65,-0.28])
		cylinder(r=0.1,$fn=32,h=1);
}

module axle_spring() {
        for(i=[0:3]) {
                hull() {
                        translate([-1.5-i-0.2,i*0.15+0.3,0.4])
                                cube([0.2,0.3,0.6]);
                        translate([0,i*0.12+0.24,0.4])
                                cube([0.2,0.3,0.6]);
                }
                hull() {
                        translate([1.5+i,i*0.15+0.3,0.4])
                                cube([0.2,0.3,0.6]);
                        translate([-0.2,i*0.12+0.24,0.4])
                                cube([0.2,0.3,0.6]);
                }
        }

        for(i=[0:3]) {
                hull() {
                        translate([-1.5-i-0.2,i*0.15+0.35,0.2])
                                cube([0.2,0.15,0.8]);
                        translate([0,i*0.12+0.27,0.2])
                                cube([0.2,0.15,0.8]);
                }
                hull() {
                        translate([1.5+i,i*0.15+0.35,0.2])
                                cube([0.2,0.15,0.8]);
                        translate([-0.2,i*0.12+0.27,0.2])
                                cube([0.2,0.15,0.8]);
                }
        }
}

module GWRspring46unit() {
	cylinder(r=0.6,h=0.7,$fn=6);
	translate([0,0,-0.4])
		cylinder(r=0.45,h=0.41,$fn=32);
	translate([-0.45,-0.5,-0.4])
		cube([0.9,0.5,0.61]);
	translate([0,0,-1])
		cylinder(r=0.15,h=1,$fn=32);
	translate([-0.15,-0.6,-1])
		cube([0.3,0.6,0.61]);
}

module GWRsprings46() {
	translate([-4.5,-0.1,-0.2])
		GWRspring46unit();
	translate([4.5,-0.1,-0.2])
		GWRspring46unit();
	translate([-0.25,0,-1.1])
		cube([0.5,0.3,0.7]);
	translate([0,0.3,-0.2])
	rotate([90,180,0])
		axle_spring();
}

module axlebox_block() {
	translate([1,1,0])
		rotate([90,0,0])
			GWRaxlebox();
	translate([1,0.8,-0.2])
		GWRsprings46();
	// Hornblocks etc area
	cube([2,0.7,1.8]);
	// The main V
	hull() {
		translate([-1.4,-0.4,-1.2])
			cube([4.8,1,0.2]);
		translate([-1.4,-0.4,0.1])
			cube([4.8,1,0.2]);
		translate([-0.2,-0.4,1.8])
			cube([2.4,1,0.2]);
	}
	// Bottom detail
	translate([-0.2,-0.4,1.8])
		cube([2.4,1,0.4]);
	translate([-0.2,-0.4,1.8])
		cube([0.5,1.2,0.5]);
	translate([1.7,-0.4,1.8])
		cube([0.5,1.2,0.5]);
}

module axlebox_join(x) {
	difference() {
		translate([x-2,0.3,1.4])
			cube([2,1,0.5]);
		translate([x,-2,2.4])
			rotate([0,90,90])
				cylinder(r=1,h=5,$fn=64);
	}
}

module axlebox() {
	difference() {
		axlebox_block();
		translate([0.25,-1.4,0.6])
			cube([1.5,0.8,3]);
	}
}

module mainspring() {
	hull() {
		cylinder(r2=1.3/2,r1=1.5/2,h=1.1,$fn=32);
		translate([1.5,0,0])
			cylinder(r2=1.3/2,r1=1.5/2,h=1.1,$fn=32);
	}
	translate([0,0,-0.3])
		cylinder(r=1.5/2,h=0.31,$fn=6);
	translate([0,0,-1.0])
		cylinder(r=1.3/2,h=0.71,$fn=32);
	translate([1.5,0,-2])
		cylinder(r=1.3/2,h=2,$fn=32);
	translate([0.85,-0.65,-2])
		cube([1.3,1.3,1]);
	translate([0,0,-2.5])
		cylinder(r=0.4,h=1,$fn=32);
	translate([0,-0.4,-2])
		cube([0.8,0.8,0.5]);
	translate([0,-0.2,-2.5])
		cube([0.8,0.4,1.5]);
}

module axle_boss() {
	translate([0,-axlelength/2-0.11,0])
		rotate([0,90,90])
			cylinder(r=1,$fn=32,h=0.8);
	translate([0,axlelength/2-0.69,0])
		rotate([0,90,90])
			cylinder(r=1,$fn=32,h=0.8);
}

module bogie_side_3d()
{
	translate([-20.2/2,0.1,-0.6])
		cube([20.2,1.0,2]);
	translate([-frame_length/2,0.3,-0.6])
		cube([frame_length,0.8,1.5]);
	translate([-wheelbase/2-1,0.7,1.1])
		axlebox();
	translate([wheelbase/2-1,0.7,1.1])
		axlebox();
	axlebox_join(-wheelbase/2+2.9);
	mirror([1,0,0])
		axlebox_join(-wheelbase/2+2.9);
	translate([-3.2,1.3,2.4])
		rotate([0,0,-90])
			mainspring();
	translate([3.2,1.3,2.4])
		rotate([0,0,-90])
			mainspring();

}

module supporting_bar(l,w,b)
{
	hull() {
		translate([l, -w / 2 - 0.2, -0.6])
			cube([1, 1, 1]);
		translate([l + b, -3, -0.6])
			cube([1.2, 1, 1.2]);
	}
	hull() {
		translate([l, w / 2 - 0.6, -0.6])
			cube([1, 1, 1]);
		translate([l + b, 2, -0.6])
			cube([1.2, 1, 1.2]);
	}
	translate([l + b, -3, -0.6])
		cube([1.2, 6, 1.2]);
}

module bogie_frame()
{
	difference() {
		union() {
			cube([core_width,axlelength+0.5,1.5], center=true);
			translate([0,axlelength/2-0.2,0])
				bogie_side_3d();
			translate([0,-axlelength/2+0.2,0])
				mirror([0,1,0])
					bogie_side_3d();
			cylinder(r=3.6,h=1.5, $fn=32, center=true);
			if (nem) {
				translate([8,0,0])
					cube([nemoffset+7.6,2.5,1.5], center=true);
				translate([nemoffset+6.5,0,1.5])
					cube([1.5,2.5,4.5], center=true);
				translate([nemoffset+8.5,0,2.25]	)
					rotate([0,90,0])
						nem_pocket();
			}
			if (supporting_bars == 1) {
				supporting_bar(frame_length/2-1, 
axlelength+0.4, 1);
				supporting_bar(-frame_length/2, axlelength+0.4, -1);

			}
		}
		cylinder(r=2.1,h=5, $fn=32, center=true);
	}
}

module nemforetch() {
	difference() {
		union() {
			cube([4,axlelength-2,1.2], center=true);
			cylinder(r=3.6,h=1.2, $fn=32, center=true);
			if (nem) {
				translate([6,0,0])
					cube([nemoffset+6,2.5,1.2], center=true);
				translate([nemoffset+6.5,0,1.5])
					cube([1.2,2.5,4.2], center=true);
				translate([nemoffset+8.5,0,2.25]	)
					rotate([0,90,0])
						nem_pocket();
			}
		}
		cylinder(r=2.1,h=5, $fn=32, center=true);
	}
}

module bogie() {
	difference() {
		union() {
			bogie_frame();
			translate([-wheelbase/2,0,2.5])
				axle_boss();
			translate([wheelbase/2,0,2.5])
				axle_boss();
		}
		translate([-wheelbase/2,0,2.5])
			axle();
		translate([wheelbase/2,0,2.5])
			axle();
	}
}

module bogie_model() {
	bogie_frame();
	translate([-wheelbase/2,0,2])
		axle();
	translate([wheelbase/2,0,2])
		axle();
}

module dean_bogie_set(n) {
	for(i=[0:n-1])
		translate([0,18.5*i,0])
			bogie();
}

module nem_for_etch_set(n) {
	for(i=[0:n-1])
		translate([0,18.5*i,0])
			nemforetch();
}

module dean_bogie_pack(n,m) {
	for(i=[0:n-1])
		translate([0,0,8.1*i])
			dean_bogie_set(m);
}

// Parameters for 10ft Dean
axlelength = 13;  
wheelbase = 20 * 1.03;	// 10ft
wheelradius = 3.5;
nem = 1;
nemoffset = 7;
frame_length = 30.2;
core_width = 10;
supporting_bars = 1;

// Parameters for 8ft6 Dean
//axlelength = 13;  
//wheelbase = 17 * 1.03;	// 8ft6
//wheelradius = 3.5;
//nem = 1;
//nemoffset = 5.5;
//frame_length = 27.2;
//core_width = 7;
//supporting_bars = 1;

// Do a FUD version ? - build in correct bearing holes if so

dean_bogie_set(4);
//translate([0,0,-6])
//	nem_for_etch_set(4);

//bogie_model();

//bogie();

//bogie_frame();

