
module cyl(hv,rv1,rv2, o)
{
	translate([0,0, hv/2 + o])
			cylinder(h=hv, r1=rv1, r2=rv2, $fn=32, center=true);
}

module cone_shape() {
	cyl(18, 130, 130, 0);
	cyl(630, 120, 40, 16);
	cyl(10, 32, 32, 645);
	cyl(28, 25, 25, 654);
	cyl(22, 33, 33, 681);
}

module base() {
	hull() {
		cube([465,295,50], center=true);
		cube([295,465,50], center=true);
		translate([0,0,32]) {
			cube([425,255,15], center=true);
			cube([255,425,15], center=true);
		}
	}
}

module cone() {
	scale(1/148) {
		difference() {
			union() {
				translate([0,0,24])
					cone_shape();
				base();
			}
			// Note this cylinder ought to be calculated
			// by wall thickness and scale. For now its
			// hard coded for 1:148 FUD
			cyl(500, 120, 0, -34);
		}
	}
}

module cone_sprue() {
	for (i = [0:9]) {
		translate([0, i * 3.7, 0])
			cone();
	}
	translate([1.1,33.3/2, -0.35])
		cube([0.5, 34.3, 0.5], center=true);
}

module cone_pack() {
	for (i = [0:9]) {
		translate([i * 3.7, 0, 0])
			cone_sprue();
	}
	translate([33.3/2, 33.3/2 + 0.7, -0.35])
		cube([34.3, 0.5, 0.5], center=true);
}

cone_pack();
