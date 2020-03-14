

include </home/petr/OpenScadLib/AlProfil.scad>
include </home/petr/OpenScadLib/NEMA_SX17.scad>


/*
** 0 - idler bearing diameter
** 1 - belt guide diameter
** 2 - mount screw diameter
** 3 - height 1
** 4 - height 2
** 5 - belt width
** 6 - stepper offset position
** 7 - delta
** 8 - Al profile parameter
** 9 - stepper motor parameter
*/
cc_with_bearing_params = 
[
	15,
	12,
	6,
	3,
	10,
	1.5,
	30+51/2+5,
	0.5,
	AlProfile30x30Params, 
	nema17_1005Params
];

function ccbi_get_bearing_diameter(self)=self[0];
function ccbi_get_belt_guide_diameter(self)=self[1];
function ccbi_get_mount_screw_diameter(self)=self[2];
function ccbi_get_height_1(self)=self[3];
function ccbi_get_height_2(self)=self[4];
function ccbi_get_belt_thickness(self)=self[5];
function ccbi_get_stepper_offset_position(self)=self[6];
function ccbi_get_delta(self)=self[7];
function ccbi_get_al_profile_parameters(self)=self[8];
function ccbi_get_stepper_motor_parameters(self)=self[9];


function ccbi_get_mount_screw_diameter_with_delta(self)=											ccbi_get_mount_screw_diameter(self)+
											   ccbi_get_delta(self);

function ccbi_get_idler_1_offset(self)=self[0];

function ccbi_get_idler_2_offset(self)=
									(ccbi_get_bearing_diameter(self)+
									ccbi_get_belt_guide_diameter(self))/2+
									ccbi_get_belt_thickness(self);

function ccbi_get_width(self)=
			ALProfile_get_width(ccbi_get_al_profile_parameters(self))+
			SX17_get_width(ccbi_get_stepper_motor_parameters(self))+5+10;
			
function ccbi_get_length(self)=2*ALProfile_get_width(ccbi_get_al_profile_parameters(self))+20;


function cc_idler_reposition(self)=(ccbi_get_belt_guide_diameter(self)+
									ccbi_get_bearing_diameter(self))/2+
									ccbi_get_belt_thickness(self);

function ccbi_get_offset_position_1(self)=
							ccbi_get_stepper_offset_position(self)+cc_idler_reposition(self);
function ccbi_get_offset_position_2(self)=
							ccbi_get_stepper_offset_position(self)-cc_idler_reposition(self);





module corner_coupler_with_bearing_idler_holes(self)
{
	translate([ALProfile_get_width(ccbi_get_al_profile_parameters(self))/2,ALProfile_get_width(ccbi_get_al_profile_parameters(self))/2,0])
	{
		cube([ALProfile_get_width(ccbi_get_al_profile_parameters(self))+0.1,
				ALProfile_get_width(ccbi_get_al_profile_parameters(self))+0.1,
				ccbi_get_height_1(self)*3],
				center=true);
	}
	
	translate([ALProfile_get_width(ccbi_get_al_profile_parameters(self))/2,ALProfile_get_width(ccbi_get_al_profile_parameters(self))*1.5+20,0])
	{
		cylinder(d=ccbi_get_mount_screw_diameter_with_delta(self),
				h=ccbi_get_height_1(self)*3,
				center=true,
				$fn=30);
	}
	
	translate([(ccbi_get_width(self)-ALProfile_get_width(ccbi_get_al_profile_parameters(self)))/2+ALProfile_get_width(ccbi_get_al_profile_parameters(self)),ALProfile_get_width(ccbi_get_al_profile_parameters(self))/2,0])
	{
		cylinder(d=ccbi_get_mount_screw_diameter_with_delta(self),
				h=ccbi_get_height_1(self)*3,
				center=true,
				$fn=30);
	}
	
	
	translate([ccbi_get_offset_position_1(self),ALProfile_get_width(ccbi_get_al_profile_parameters(self))*1.5+20,0])
	{
		cylinder(d=ccbi_get_mount_screw_diameter_with_delta(self),
				h=ccbi_get_height_1(self)*3,
				center=true,
				$fn=30);
	}
		
	
	translate([ccbi_get_offset_position_2(self),ALProfile_get_width(ccbi_get_al_profile_parameters(self))+10,0])
	{
		cylinder(d=ccbi_get_mount_screw_diameter_with_delta(self),
				h=ccbi_get_height_2(self)*3,
				center=true,
				$fn=30);
	}
		
}

module corner_coupler_with_bearing_indler_body(self)
{
	
            
	translate([ccbi_get_width(self)/2,ccbi_get_length(self)/2,ccbi_get_height_1(self)/2])
	{
		cube([ccbi_get_width(self),
				ccbi_get_length(self),
				ccbi_get_height_1(self)],
				center=true);
	}
	
	translate([(ccbi_get_width(self)-ALProfile_get_width(ccbi_get_al_profile_parameters(self)))/2+ALProfile_get_width(ccbi_get_al_profile_parameters(self)),10+ALProfile_get_width(ccbi_get_al_profile_parameters(self)),ccbi_get_height_2(self)/2])
	{
		cube([ccbi_get_width(self)-ALProfile_get_width(ccbi_get_al_profile_parameters(self)),
				20,
				ccbi_get_height_2(self)],center=true);
	}
}


module corner_coupler_with_bearing_indler(self)
{
	difference()
	{
		corner_coupler_with_bearing_indler_body(self);
		corner_coupler_with_bearing_idler_holes(self);
	}
}

//corner_coupler_with_bearing_indler(cc_with_bearing_params);