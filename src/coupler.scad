


/*
** 0 - width
** 1 - lendth
** 2 - height
** 3 - mount screw diameter
** 4 - mount screw 1 offset
** 5 - mount screw 2 offset
** 6 - al profile grove width
** 7 - delta
*/
couplerParams = [30,60, 5, 6, 5, 0, 7.5,0.5];
couplerLongParams = [30,80, 5, 6, 0, 0, 7.5, 0.5];

function coupler_get_width(self)=self[0];
function coupler_get_length(self)=self[1];
function coupler_get_heigth(self)=self[2];
function coupler_get_mount_screw_diameter(self)=self[3];
function coupler_get_mount_screw1_offset(self)=self[4];
function coupler_get_mount_screw2_offset(self)=self[5];
function coupler_get_al_profile_grove_width(self)=self[6];
function coupler_get_delta(self)=self[7];
function coupler_get_height_with_delta(self)=self[2]+self[7];
function coupler_get_mount_screw_diameter_with_delta(self)=self[3]+self[7];


module coupler_base_hole(self, screw_position_offset)
{
	translate([0,screw_position_offset,coupler_get_heigth(self)/2-1])
	{
		cylinder(d=coupler_get_mount_screw_diameter_with_delta(self),
					h=coupler_get_heigth(self)+5,
					center=true,
					$fn=30); 
	}
	
	translate([0,screw_position_offset,coupler_get_heigth(self)+1])
		cube([coupler_get_width(self),14,2],center=true);
}

module coupler_base_body(self, screw_position_offset)
{
	translate([0,0,coupler_get_heigth(self)/2])
	{
		cube([coupler_get_width(self),
				coupler_get_width(self),
				coupler_get_heigth(self)],
				center=true);
	}
	
	translate([0,0,coupler_get_heigth(self)+0.5])
		cube([coupler_get_al_profile_grove_width(self),coupler_get_width(self),1],center=true);
}

module coupler_base(self, screw_position_offset)
{
	difference()
	{
		coupler_base_body(self, screw_position_offset);
		coupler_base_hole(self, screw_position_offset);
	}
}

module coupler(self)
{
	for(i=[-1:2:1])
	{	
		translate([0,(coupler_get_length(self)-coupler_get_width(self))/2*i,0])
		{
			rotate([0,0,i==1? 0 : 90])
			{
				coupler_base(self, 
							i==1?coupler_get_mount_screw1_offset(self):coupler_get_mount_screw2_offset(self));
			}
		}
	}
}

module coupler_long(self)
{   
	for(i=[-1:2:1])
	{	
		translate([0,(coupler_get_length(self)-coupler_get_width(self))/2*i,0])
		{
			rotate([0,0,90])
				coupler_base(self,
							i==1?coupler_get_mount_screw1_offset(self):coupler_get_mount_screw2_offset(self));
		}
	}
	
	translate([0,0,coupler_get_heigth(self)/2+0.5])
	{
		cube([coupler_get_width(self), 
			coupler_get_length(self)-(coupler_get_width(self)*2), 
			coupler_get_heigth(self)+1],
			center=true);
	}
}

//coupler_base(couplerParams, 0);
//coupler(couplerParams);
coupler_long(couplerLongParams);