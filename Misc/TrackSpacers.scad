
module TrackSpacer(s1,s2) {
	cube([8.5,10,1.5]);
	translate([s1,0,0])
		cube([8.5,10,1.5]);

	translate([0,-5,0]) {
		cube([8.5,10,1.5]);
		translate([s2,0,0])
			cube([8.5,10,1.5]);
	}
	cube([s2+8.5,6,1.5]);
}

TrackSpacer(22,24);
translate([0,0,2.5])
	TrackSpacer(22,24);
translate([0,0,5])
	TrackSpacer(22,24);

