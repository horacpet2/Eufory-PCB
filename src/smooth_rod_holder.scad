

/*
** 0 - hight
** 1 - al profile width
** 2 - mount screw diameter
** 3 - mount screw head diameter
** 4 - mount screw head hight
** 5 - smooth rod diameter
** 6 - wall thisckness
** 7 - smooth rod y offset
** 8 - delta
*/
smooth_rod_holder_params = [12, 30, 6, 10, 6, 8, 3, 6, 0.7];
 
module smooth_rod_holder_parameters_structure_help()
{
    echo(" 0 - hight");
    echo(" 1 - al profile width");
    echo(" 2 - mount screw diameter");
    echo(" 3 - mount screw head diameter");
    echo(" 4 - mount screw head hight");
    echo(" 5 - smooth rod diameter");
    echo(" 6 - wall thisckness");
    echo(" 7 - smooth rod y offset");
    echo(" 8 - delta");
}

 
module smooth_rod_holder_holes(params)
{
    translate([0,0,-1])
    {
        cylinder(d1=params[5]+0.2, d2=params[5]+params[8], h=params[0]+2, $fn=50);

        translate([params[5]/2+params[6]+5,params[7],params[4]])
            cylinder(d=params[3],h=params[0]+2, $fn=50);

        translate([params[5]/2+params[6]*2+params[2]+13,params[7],params[4]])
            cylinder(d=params[3],h=params[0]+2, $fn=50);

        translate([params[5]/2+params[6]+5,params[7],0])
            cylinder(d=params[2]+0.5,h=params[0]+2, $fn=50);

        translate([params[5]/2+params[6]*2+params[2]+13,params[7],0])
            cylinder(d=params[2]+0.5,h=params[0]+2, $fn=50);
    }
}
 
module smooth_rod_holder_body(params)
{
    hull()
    {	
        cylinder(d=params[5]+params[6]*2, h=params[0], $fn=50);

        translate([params[5]/2+params[6]+5,params[7],0])
            cylinder(d=params[3]+(params[6]*2),h=params[0], $fn=50);
    }

    hull()
    {	
        translate([params[5]/2+params[6]+5,params[7],0])
            cylinder(d=params[3]+params[6]*2,h=params[0], $fn=50);

        translate([params[5]/2+params[6]*2+params[2]+13,params[7],0])
            cylinder(d=params[3]+params[6]*2,h=params[0], $fn=50);
    }
}

module smooth_rod_holder(params)
{
    difference()
    {
        smooth_rod_holder_body(params);
        smooth_rod_holder_holes(params);
    }
}

//smooth_rod_holder(smooth_rod_holder_params);