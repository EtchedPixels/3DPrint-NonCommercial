module F4_34(b) {
// Render quality
// 32 = smooth
smooth=32;
// Loco
// 0 - standard
// 1 - First 30 locos
early_loco=0;
//	Cylinders on early locos
// 0 - covers enlarged
// 1 - covers visible
cylinder_covers = 1;
// Boiler type
// 1 Type 33 (Wordsell)
// 2 Type 33 (Holden)
// 3 Type 34
boiler=3;
// Set to add a steam dome to the render
// 1 Intended for visualisation checks
// 2 Nice flanged dome
steam_dome = 2;
// Add a funnel
// 1 for Stove pipe (LNER)
// 2 for Stove (F4 with num 34 boiler)
// 3 for F5 (M15 RBT - TODO)
// 4 for NER style (TODO)
funnel = 2;
// Printed filler caps as opposed to using
// N Brass
filler_cap = 1;
// Set to 8 for an 8" pump on the loco side,
// 6 for a front of tank pump not supported yet
// 0 for original F4 in cab (ie not rendered)
westinghouse_pump = 1;
// Set for GER buffers
ger_buffers = 1;
// Set for buffer holes (don't mix with buffers)
buffer_holes = 0;
// Set for later style coal rails
// 1 = later, 2 = old (right now can't render
// to resolution needed so same)
// 0 = none (F4 pre 1895)
coal_rails = 1;
// Set for Ramsbottom's safety valves
ramsbottom_valves = 1;
// Set if you want a step on the right hand tank
right_tank_step = 0;
// Step type on bunker
bunker_step = 1;
// Condensing pipes
condensing = 1;
// Smokebox door
// 0 - hole for casting
// 1 - original
// 2 - with sealing ring
smokebox_door = 2;
// Handrails
// 0 - none
// 1 - old style moulded
// 2 - new style moulded
handrails = 2;
// Set to enable rivets (very slow - use for final // renders only)
rivets = 1;
// Set brass option
brass = b;

include <F5-module.scad>;

f5_floor();

}
