


SirkaProfilu = 30;
NX17_mount_width = 42.5;


/*
** 0 - AlProfil Width
** 1 - NX17 mount width
** 2 - idler bearing diameter
** 3 - belt guide diameter
** 4 - mount screw diameter
** 5 - height 1
** 6 - height 2
** 7 - belt width
** 8 - delta
*/
cc_with_bearing_params = [30, 50, 15, 12,6,3,10,1.5,0.5];

function cc_bearing_idler_get_al_profil_width(self)=self[0];
function cc_bearing_idler_get_nx17_mount_width(self)=self[1];
function cc_bearing_idler_get_bearing_diameter(self)=self[2];
function cc_bearing_idler_get_belt_guide_diameter(self)=self[3];
function cc_bearing_idler_get_mount_screw_diameter(self)=self[4];
function cc_bearing_idler_get_height_1(self)=self[5];
function cc_bearing_idler_get_height_2(self)=self[6];
function cc_bearing_idler_get_delta(self)=self[7];


function cc_bearing_idler_get_mount_screw_diameter_with_delta(self)=self[4]+self[7];



module corner_coupler_with_bearing_idler_holes(self)
{
	bearing_diameter= 15;
    belt_guide_diameter=12;
	
	/* je třeba započítat tloušťku řemene, přítlačné ložisko 2 */
	translate([(bearing_diameter+belt_guide_diameter)/2+1.5,10+SirkaProfilu/2,0])
	{
		cylinder(d=cc_bearing_idler_get_mount_screw_diameter_with_delta(self),
				h=cc_bearing_idler_get_height_2(self)*3,
				center=true,
				$fn=30);
	}
	
	/* přítlačné ložisko 1 */
	 translate([(bearing_diameter-belt_guide_diameter)/2,0,0])
		cylinder(d=6.5, h=20,center=true);
	
	
	
	
	translate([-SirkaProfilu-NX17_mount_width/2+SirkaProfilu/2,SirkaProfilu/2+10,0])
		cylinder(d=6.5, h=20,center=true);
	
	translate([-((SirkaProfilu*2)-NX17_mount_width)/2+SirkaProfilu/2,-(SirkaProfilu/2+10),0])
		cylinder(d=6.5, h=20,center=true);
	
	
	translate([-(SirkaProfilu+NX17_mount_width)/2,-(2*SirkaProfilu+20)/2+SirkaProfilu/2,0])
		cube([SirkaProfilu+0.1, SirkaProfilu+0.1,10],center=true);
}

module corner_coupler_with_bearing_indler_body(self)
{
	bearing_diameter= 15;
 belt_guide_diameter=12;
            
	translate([-SirkaProfilu/4,0,1.5])
		cube([1.5*SirkaProfilu+NX17_mount_width,2*SirkaProfilu+20,3],center=true);
	
	translate([SirkaProfilu/2-SirkaProfilu/4,0,5])
		cube([SirkaProfilu/2+NX17_mount_width,20,10],center=true);
}


module corner_coupler_with_bearing_indler(self)
{
	difference()
	{
		corner_coupler_with_bearing_indler_body(self);
		corner_coupler_with_bearing_idler_holes(self);
	}
}

corner_coupler_with_bearing_indler(cc_with_bearing_params);