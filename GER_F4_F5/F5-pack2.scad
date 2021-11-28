use <F4-34.scad>;
use <F4-34NC.scad>;
use <F4-early.scad>;

F4_early(0);
translate([0,0,20])
	F4_early(0);
translate([0,0,40])
	F4_34NC(0);

