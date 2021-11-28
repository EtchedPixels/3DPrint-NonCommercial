

module toolbox_core(r,h,l) {
	translate([r,0,0]) {
		intersection() {
			cylinder(r=r,h=l, $fn=256);
			translate([r-h,-0.9,0])
				cube([h,1.8,l]);
		}
		intersection() {
			difference() {
				translate([0,0,-0.1])
					cylinder(r=r,h=l+0.2, $fn=256);
				translate([0,0,-0.2])
					cylinder(r=r-0.2,h=l+0.4, $fn=256);
			}
			translate([r-h,-1,-0.2])
				cube([h,2.0,l+0.4]);
		}
	}
}

module toolbox_strap(r,sp,h,l) {
	translate([r,0,0]) {
		intersection() {
			difference() {
				translate([0,0,-0.1])
					cylinder(r=r+0.1,h=l+0.2, $fn=256);
				translate([0,0,-0.2])
					cylinder(r=r-0.1,h=l+0.4, $fn=256);
			}
			translate([r-h+0.2,-1,sp-0.1])
				cube([h,2.0,0.2]);
		}
	}
}

module toolbox() {
	toolbox_core(1.5,2.3,5.5);
	toolbox_strap(1.5,0.3,2.3,5.5);
	toolbox_strap(1.5,2.75,2.3,5.5);
	toolbox_strap(1.5,5.2,2.3,5.5);
}



module toolbox_sprue_line(n) {
	for (i = [0:(n-1)])
		translate([0,2.6*i,0])
			toolbox();
	translate([0.01,-0.4,2.7])
		cube([0.7,2.6*(n-1)+0.8,0.7]);
}

module toolbox_sprue(n,m) {
	for(i=[0:(n-1)])
		translate([0,0,6*i])
			toolbox_sprue_line(m);
	translate([-0.6,1.3*(n-1),2.7])
		cube([0.7,0.7,6*(m-1)+0.6]);
}


toolbox_sprue(10,10);

