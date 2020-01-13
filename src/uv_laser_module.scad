




/*
** 0 - cooler width
** 1 - cooler lenght
** 2 - cooler hight
** 3 - module hole diameter
*/
UVLaserModuleParams = [22,27,58,12];

function uv_laser_cooler_get_width(self)=self[0];
function uv_laser_cooler_get_length(self)=self[1];
function uv_laser_cooler_get_hight(self)=self[2];
function uv_laser_cooler_get_hole_diameter(self)=self[3];

module uv_laser_module_cool_ribbing(self)
{
    translate([0,-(uv_laser_cooler_get_length(self)-5)/2,0])
        cube([uv_laser_cooler_get_width(self),5,uv_laser_cooler_get_hight(self)],center=true);
    
    translate([0,-uv_laser_cooler_get_length(self)/4,0])
        cube([uv_laser_cooler_get_hole_diameter(self)+3,uv_laser_cooler_get_length(self)/2,uv_laser_cooler_get_hight(self)],center=true);

    translate([0,(uv_laser_cooler_get_length(self)-uv_laser_cooler_get_hole_diameter(self))/2-5,0])
    {
        cylinder(d=uv_laser_cooler_get_hole_diameter(self)+5, h=uv_laser_cooler_get_hight(self), center=true);
        
          for(i=[0:18:180])
          {
              rotate([0,0,i])
              {
                  translate([uv_laser_cooler_get_width(self)/2,0,0])
                       cube([uv_laser_cooler_get_width(self),1,uv_laser_cooler_get_hight(self)],center=true);
              }
          }
    }
    
   for(i=[0:1:4])
   {
        translate([0,(-uv_laser_cooler_get_length(self)/2+5)+i*2,0])
            cube([uv_laser_cooler_get_width(self), 1, uv_laser_cooler_get_hight(self)],center=true);
   }
       
   translate([0,uv_laser_cooler_get_length(self)/2-5,0])
        cube([8,10,uv_laser_cooler_get_hight(self)],center=true);
}
		
module uv_laser_module_cooler_holes(self)
{
    translate([0,-uv_laser_cooler_get_length(self)/2,0])
         rotate([90,0,0])cylinder(d=5,h=5,$fn=30,center=true);

    for(i = [-1:2:1])
    {
        for(j = [-1:2:1])
        {
            translate([(uv_laser_cooler_get_width(self)/2-3.5)*i, -uv_laser_cooler_get_length(self)/2, (uv_laser_cooler_get_hight(self)/2-10)*j])
                rotate([90,0,0])cylinder(d=3,h=10,$fn=30,center=true);
        }
    }

    for(i=[11:10:21])
    {
        translate([0,uv_laser_cooler_get_length(self)/2, -uv_laser_cooler_get_hight(self)/2+i])
            rotate([90,0,0])cylinder(d=3, h=20,$fn = 30, center=true);
    }
}

module uv_laser_module_cooler(self)
{
    color("gray")
    {
    	translate([0,0,uv_laser_cooler_get_hight(self)/2])
    	{
        	intersection()
        	{
        	    difference()
        	    {
        	        cube([uv_laser_cooler_get_width(self), uv_laser_cooler_get_length(self), uv_laser_cooler_get_hight(self)], center=true);
            
        	        translate([0,(uv_laser_cooler_get_length(self)-uv_laser_cooler_get_hole_diameter(self))/2-5,0])
        	            cylinder(d=uv_laser_cooler_get_hole_diameter(self), h=uv_laser_cooler_get_hight(self)+1, $fn = 50, center=true);
        	        
        	        translate([0,-((uv_laser_cooler_get_length(self)-5)/2-2),0])
        	            cube([uv_laser_cooler_get_width(self)/2,5,uv_laser_cooler_get_hight(self)+1],center=true);
        	    
        	        uv_laser_module_cooler_holes(self);
        	    }
        	    
        	    uv_laser_module_cool_ribbing(self);
	        }
         }
     }
}


uv_laser_module_cooler(UVLaserModuleParams);