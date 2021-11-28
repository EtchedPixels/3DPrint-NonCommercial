
module FuelTank() {
	difference() {
		cylinder(r=1.2,h=5.6, $fn=32, center=true);	
		cylinder(r=1.0,h=7,$fn=32, center=true);
	}

	hull() {
		cylinder(r=1.2,h=5.3, $fn=32, center=true);
		cylinder(r=0.6,h=5.8, $fn=32, center=true);
		cylinder(r=0.2,h=6, $fn=32, center=true);
	}
}

module FuelBracket() {
	cube([2,2,0.5], center=true);
}

module FuelTankRing()
{
	cylinder(r=1.3,h=0.3,$fn=32, center=true);
}


module WCPRFuelTank() {
	FuelTank();
	translate([-0.5,0,2])
		FuelBracket();
	translate([0,0,2])
		FuelTankRing();

	translate([-0.5,0,-2])
		FuelBracket();
	translate([0,0,-2])
		FuelTankRing();
	translate([0,0.3,-2])
		cube([1,2,1], center=true);
	translate([0,0.3,2])
		cube([1,2,1], center=true);
}

