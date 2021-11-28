use <Railcar/railcar.scad>
use <SR/Railbus.scad>
use <Railcar/fueltank.scad>

module WCPRPack() {
	translate([0,4.5,0])
		WCPRSet();
	translate([20,0,0])
		DrewryRailcar(1,1,1);
	translate([5,16.5,5])
		WCPRFuelTank();
	translate([5,16.5,12])
		WCPRFuelTank();
}

rotate([90,180,-15]) {
	WCPRPack();
}
