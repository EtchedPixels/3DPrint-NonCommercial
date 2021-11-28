

module milkchurn_lid_open_4mm(r) {
//	cylinder(r1=r-0.4,r2=r-0.8,h=0.4,$fn=32);
}

module milkchurn_lid_4mm(r) {
	cylinder(r1=r,r2=r-0.1,h=0.31,$fn=32);
	translate([0,0,0.3])
		cylinder(r1=r-0.1,r2=r-0.4,h=0.2,$fn=32);
}


module handles(h,v,s) {
	hull() {
		translate([-h,-1,v])
			sphere(r=0.4,$fn=s);
		translate([-h,1,v])
			sphere(r=0.4,$fn=s);
		translate([h,-1,v])
			sphere(r=0.4,$fn=s);
		translate([h,1,v])
			sphere(r=0.4, $fn=s);
	}
}


module milkchurn_17g_1_4mm() {
	difference() {
		union() {
			cylinder(r1=6.85/2,r2=3/2,h=10.7,$fn=32);
			cylinder(r=6.9/2,h=0.5,$fn=32);
			translate([0,0,10.69])
				cylinder(r1=3/2,r2=4.4/2,h=1,$fn=32);
			translate([0,0,11.65])
				cylinder(r=4.4/2,h=0.1,$fn=32);
			translate([0,0,11.74])
				milkchurn_lid_4mm(4.4/2);
		}
		translate([0,0,11.36])
			milkchurn_lid_open_4mm(4.4/2);
	}
	handles(2.2,7,16);
}


module milkchurn_17g_2_4mm() {
	difference() {
		union() {
			cylinder(r1=6.7/2,r2=3.4/2,h=9.9,$fn=32);
			cylinder(r=6.9/2,h=0.5,$fn=32);
			translate([0,0,9.89])
				cylinder(r1=3.4/2,r2=4.8/2,h=1,$fn=32);
			translate([0,0,10.85])
				cylinder(r=4.8/2,h=0.1,$fn=32);
			translate([0,0,10.94])
				milkchurn_lid_4mm(4.4/2);
		}
		translate([0,0,10.56])
			milkchurn_lid_open_4mm(4.8/2);
	}
	handles(2.2,7,16);
}


// 34cm dia, 72cm tall 
module milkchurn_cyl_4mm() {
	cylinder(r=2.2,h=6.4,$fn=32);
	cylinder(r=2.3,h=0.1,$fn=32);
	translate([0,0,0.5])
		cylinder(r=2.3,h=0.1,$fn=32);
	translate([0,0,5.73])
		cylinder(r=2.3,h=0.1,$fn=32);
	translate([0,0,6.39])
		cylinder(r1=2.2, r2=1.5,h=1.01,$fn=32);
	translate([0,0,7.39])
		cylinder(r=1.5,h=1.01,$fn=32);
	translate([0,0,8.39])
		cylinder(r=2.0,h=0.21,$fn=32);
	translate([0,0,8.59])
		cylinder(r1=1.9,r2=1.8,h=0.31,$fn=32);
	translate([0,0,8.89])
		cylinder(r1=1.8,r2=1.5,h=0.2,$fn=32);
}

module handles(h,v,s) {
	hull() {
		translate([-h,-1,v])
			sphere(r=0.4,$fn=s);
		translate([-h,1,v])
			sphere(r=0.4,$fn=s);
		translate([h,-1,v])
			sphere(r=0.4,$fn=s);
		translate([h,1,v])
			sphere(r=0.4, $fn=s);
	}
}

module milkchurn_17g_1_2mm() {
	scale(76/148)
		milkchurn_17g_1_4mm();
}

module milkchurn_17g_2_2mm() {
	scale(76/148)
		milkchurn_17g_2_4mm();
}

module milkchurn_cyl_2mm() {
	scale(76/148)
		milkchurn_cyl_4mm();
}

module churns_trio() {

	module sprue() {
		translate([0,0,-2])
			cylinder(r=0.5,h=2.1,$fn=8);
	}
	sprue();
	milkchurn_17g_1_2mm();
	translate([4,0,0]) {
		sprue();
		milkchurn_17g_2_2mm();
	}
	translate([7.5,0,0]) {
		sprue();
		milkchurn_cyl_2mm();
	}
	translate([-0.5,-0.5,-2.5])
		cube([8.5,1,1]);
}

module churn_pack() {
	for (i=[0:9])
		translate([0,4.5*i,0])
			churns_trio();
	translate([3,-0.5,-2.5])
		cube([1,41,1]);
}

module churn_set() {
	for (i = [0:7])
		translate([12*i,0,0])
			churn_pack();
}

churn_set();
