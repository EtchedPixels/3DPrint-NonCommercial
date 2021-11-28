
// How do we align the spokes
function vertical_bias(a,l) = sin(a) * l;


// Manufacture a spoke
module spoke() {
	cylinder(r=spokeradius,$fn=64,h=spokelen);
	translate([0,0,spokelen-spokebosslen])
		cylinder(r=spokebossradius,$fn=64,h=spokebosslen);
}


// Manufacture a set of spokes
// Currently hardcoded for 12 spoke but
// trivial to fix
module spokes() {
	n = (spokes/2) - 1;
	translate([2-vertical_bias(spokeangle,spokelen),0,0])
		for(i=[0:n]) {
			// 720 as we are doing alternating
			// spokes here
			rotate([i*(720/spokes),0,0])
				rotate([0,spokeangle,0])
					spoke();
	}
	translate([2+vertical_bias(spokeangle,spokelen),0,0])
		for(i=[0:n]) {
			// Move on one spoke, rotate in twos
			rotate([(360/spokes)+i*(720/spokes),0,0])
				rotate([0,-spokeangle,0])
					spoke();
	}
}

// Produce the boss
module boss() {
	translate([(rimwidth-bosswidth)/2,0,0])
		rotate([0,90,0])
			cylinder(r=bossradius,h=bosswidth,$fn=64);
}

module rim() {
	rotate([0,90,0]) {
		difference() {
			cylinder(r=radius,h=rimwidth,$fn=64);
			translate([0,0,-0.5])
				cylinder(r=radius-rimthickness,h=rimwidth+1,$fn=64);
		}
	}
}

module shafthole() {
	if (shaftlength == 0) {
		translate([-5,0,0])
			rotate([0,90,0])
				cylinder(r=shaftradius,h=20,$fn=64);
	}
}

module shaft() {
	if (shaftlength > 0) {
		translate([(rimwidth - shaftlength)/2,0,0])
			rotate([0,90,0])
				cylinder(r=shaftradius,h=shaftlength,$fn=64);
	}
}

module holeflat() {
	translate([(rimwidth-bosswidth)/2,-shaftradius,-flat])
		cube([bosswidth,shaftradius-flat+0.1,2*flat]);
}

module rope() {
	rotate([0,90,0])
		rotate_extrude($fn=64)
			translate([radius,0,0])
				circle(r=0.55,$fn=64);
}

module ropes(){
	for (i = ropeoffsets) {
		translate([i,0,0])
			rope();
	}
}

module wheel() {
	boss();
	shaft();
	rim();
	spokes();
}

module sheave() {
	difference() {
		wheel();
		shafthole();
		ropes();
	}
	if (flat)
		holeflat();
}

module sheaves(n) {
	for(i = [0:n-1])
		translate([(max(shaftlength,bosswidth)+1)*i,0,0])
			sheave();
}

spokes = 12;		// Must be even
spokeradius = 0.5;	// keep 0.5mm or higher for most materials
spokeangle = 10;	// angle of spokes
spokelen = 17.25;		// length of each spoke
spokebossradius = 1;	// radius of the boss of each spoke
spokebosslen = 3;	// length of the boss (0 for none)

rimwidth = 4;		// Width of the rim
rimthickness = 2;	// Thickness of rim

bosswidth = 8;		// Width of the boss
bossradius = 4.5;	// Radius of the boss

shaftlength = 0;	// 0 for a hole value for 
						//	a shaft included
shaftradius = 1.5;	// Radius of the shaft in the boss

flat = 1.4;		   // 0 for none otherwise
						// distance of flat from
						//	centre
			// for WSF make sure the boss radius is
			// >= 1mm bigger than the shaft radius

radius = 17;		// Radius of sheave (to outside of rim)

ropewidth=0.55;		// Radius of groove for the rope
ropeoffsets=[1,2,3];	// Offsets of rope groove centres from the
			// edge of the rim - [] for none, [2] for one etc


// specify how many you want and off you go
sheaves(3);
