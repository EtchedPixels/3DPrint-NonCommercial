module bogie_peg()
{
	translate([0,0,0.99])
		cylinder(r=0.96, h=2.8, $fn=32);
	cylinder(r=3, h=1, $fn=32);
}



//bogie_peg();

module row_of_pegs(n)
{
	for(i = [0:n-1])
		translate([0,7*i, 0])
			bogie_peg();
	translate([-0.5,0,0])
		cube([1,7*(n-1),1]);
}

module block_of_pegs(n,m)
{
	for(i = [0:m-1])
		translate([7*i,0,0])
			row_of_pegs(n);
	translate([0,-0.5,0])
		cube([7*(m-1),1,1]);
	translate([0, 7*(m-1)-0.5,0])
		cube([7*(m-1),1,1]);
}


block_of_pegs(10,10);
