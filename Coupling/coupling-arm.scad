module coupling_body()
{
	difference() {
	rotate([45,0,0])
	cube([3.8, 1.42 * 1.4, 1.42 * 1.4]);
	translate([0, -1.4, 1.9])
		cube([3.8,3, 2]);
	}
	translate([0,-1.4, 1.4])
		cube([3.8, 0.7,0.5]);

	// End of ARM
	translate([0.25, 0, 1.9])
	difference() {
		cube([0.5, 2.8, 1.0], center = true);
		translate([0,0,2.0])
		rotate([45,0,0])
			cube([0.5, 2.8, 2.8], center = true);
	}
	translate([3.1 + 0.35, 0 , 2.9]) {
		difference() {
		cube([0.7, 2.8, 5.8], center=true);
		translate([0.35, 0, -5.0])
		rotate([0,-15,0])
			cube([0.7, 2.8, 7.8], center=true);
		translate([0, 0, -4.5])
		rotate([45, 0, 0])
			cube([1.1, 5, 1], center=true);
		}
	}
	translate([0.6, 0,5.3])
	difference() {
		cube([6.4, 2.8, 1.0], center=true);
		translate([-4.8,0,0.1])
		rotate([0, -15, 0])
		cube([8.4, 2.8, 1.0], center=true);
	}
}


module test_coupling()
{
	coupling_body();
	translate([3.3 - 2.6,-0.5,5.5])
		cube([1,1, 10]);
}

module nem_pocket_hole(w)
{
	cube([0.4, 4.2, 2.2], center=true);
   translate([0,0,-0.7])
		cube([1.2, w , 2.2], center=true);
	translate([0, 0, 0.6])
	cube([0.4, 4.2, 1], center=true);
	translate([0, 0, 0.1])
		rotate([90,0,0])
			cylinder(h=4.2, r=1.05/2, $fn=64, center=true);
	translate([0, 0, -1.2])
		rotate([90,0,0])
			cylinder(h=4.2, r=0.2, $fn=64, center=true);
	difference() {
		translate([0, 0, 1.3])
			rotate([90,0,0])
				cylinder(h=4.2, r=0.8/2, $fn=64, center=true);
		translate([0,0, 2.6])
			cube([2.3, 4.25, 3], center=true);
	}
	cube([1.2, w, 2.2], center=true);
}

module nem_pocket_body()
{
	cube([3.0, 4, 3.5], center=true);
}


module nem_pocket()
{
	difference()
	{
		nem_pocket_body();
		translate([0,0,0.68])
		nem_pocket_hole(2.5);
	}
}

module nem_pocket_wide()
{
	difference()
	{
		nem_pocket_body();
		translate([0,0,0.68])
		nem_pocket_hole(2.7);
	}
}

module fud_nem_pocket_body(w)
{
	cube([2.2, w + 1, 3.5], center=true);
}


module fud_nem_pocket()
{
	difference()
	{
		fud_nem_pocket_body(2.5);
		translate([0,0,0.68])
		nem_pocket_hole(2.5);
	}
}

module fud_nem_pocket_wide()
{
	difference()
	{
		fud_nem_pocket_body(2.5);
		translate([0,0,0.68])
		nem_pocket_hole(2.7);
	}
}
//nem_pocket();


// Our buffers are 4mm long so the front face of the box
// should be 1mm in front of the buffer beam.
// The centre line of the box should be 4mm above the rai

module nem_close_coupler_arm(a, s)
{
	n = 5;	// Fixme compute this
	cube([1, s, a], center=true);
	translate([0,0, a /2 + n /2])
		difference() {
			union() {
				cube([1, 3, n], center=true);
				translate([0, 0, n/2])
				rotate([0,90,0])
					cylinder(r = 1.5, h=1, center=true, $fn=64);
			}

		}

	// Fixme locate pin correctly
	translate([1.6,0, -n/2])
	rotate([0,90,0]) {
		cylinder(r=0.5, h=2.5, center=true, $fn=64);
		translate([0,0,0.25])
			cylinder(r2=0.6, r1=0.75, h=1, $fn=64);
	}
	// Fixme locate pin correctly
	translate([1.5,0, n + a/2 - 1.2])
	rotate([0,90,0]) {
		cylinder(r=0.6, h=2.5, center=true, $fn=64);
		translate([0,0,0.4])
			cylinder(r2=0.6, r1=0.85, h=0.85, $fn=64);
	}	// Fixme - and make it a split pin or similar ?
}

//
//	Generate the reference block of bodywork. We need to
// amend this so that we put a block for the coupling
//	bar to hold against and a plug in pin. Ultimately
// we will need to make the bar itself cranked to clear
// the bogies or hang the NEM pocket below ?
//
module nem_close_coupler_bodywork(a, s)
{
	// Fixme - compute n, also correct so that end not
	// centre of coupling hole is aligned with centre dip
	// worst case of slot
	n = 5;

	difference() {
		translate([1.3,0,0])
			cube([1, 16,25], center=true);
		translate([1.5, 0, n/2]) {
			rotate([0,90,0])
					cylinder(r = 0.65, h=5, center=true, $fn=64);
			cube([1.5, 1.5, n-3], center=true);
			translate([0, 0, (n-3)/2 + 0.3])
			rotate([0,90,0])
				cylinder(r=0.85, h=4, center=true, $fn=64);
			translate([0, 0, -(n-3)/2])
				rotate([0,90,0])
					cylinder(r=0.75, h=4, center=true, $fn=64);				}
	}
}

//
//	Plot a segment of the curve (see NEM352)
//
module nem_close_coupler_slot_segment(a, e, s, p, m)
{
	k = a - (p + m);
	translate([0,-e,0]) {
	difference() {
		cylinder(h=1.02, r=k, center=true, $fn=64);
		cylinder(h=1.02, r=k-1.2, center=true, $fn=64);
		translate([0,-k/2,0])
			cube([2*k, k, 1.05], center=true);
		translate([-k/2, k/2, 0])
			cube([k, k, 1.05], center = true);
		translate([0, e+k/2, 0])
			cube([2*k, k, 1.05], center=true);
		}
	}
}

//
//	Plot the curves as per NEM352. We assume our input
// is sensible. Given too low a value of A our arcs
// may well be fine mathematically but they won't be
// useful
// ASSUMPTIONS: B = E (spec allows B >= E)
//
module nem_close_coupler_slots(a,e,s,p,m)
{
	rotate([0,90,0]) {
		translate([0,0.01,0])
		nem_close_coupler_slot_segment(a,e,s,p,m);
		mirror([0,1,0])
			nem_close_coupler_slot_segment(a,e,s,p,m);
	}
}

//	A - distance from end point to centre of arcs
// E - buffer outside to centre line (~ 7-7.5mm)
// S - width of coupler
// M - distance between coach end and guide
// P - distance between buffers and coach end (~4mm)
//     (we include the D factor from the spec here)
// 
module nem_close_coupler(a, e, s, p, m)
{
	difference() {
	   nem_close_coupler_bodywork(a, s);
		translate([1.3,0,m])
			nem_close_coupler_slots(a, e, s, p, m);
	}

//	translate([3,0,0]) {
		translate([0,0,-a/2])
   		nem_close_coupler_arm(a, s);

		translate([-1.5,0,-a])
			rotate([180,0,0])
				nem_pocket();
//	}
}


// nem_close_coupler(25, 7, 2.5, 4, 2);
//nem_close_coupler(16, 7, 1.5, 4, 2);

fud_nem_pocket(2.5);
