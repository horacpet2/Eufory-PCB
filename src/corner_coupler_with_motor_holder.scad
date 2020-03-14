
include </home/petr/OpenScadLib/AlProfil.scad>
include </home/petr/OpenScadLib/NEMA_SX17.scad>


/*
** 0 - height 1
** 1 - height 2
** 2 - mounting screw diameter
** 3 - stepper possition offset
** 4 - delta
** 5 - al profile parameters

*/


ccsm_params = 
[
	3, 
	5, 
	6, 
	30+51/2+5, 
	0.5,
	AlProfile30x30Params,
	nema17_1005Params,
];


function ccsm_get_height_1(self)=self[0];
function ccsm_get_height_2(self)=self[1];
function ccsm_get_mounting_screw_diameter(self)=self[2];
function ccsm_get_delta(self)=self[4];
function ccsm_get_stepper_possition_offset_x(self)=self[3];
function ccsm_get_al_profile_params(self)=self[5];
function ccsm_get_stepper_params(self)=self[6];



function ccsm_get_width_1(self)=ALProfile_get_width(ccsm_get_al_profile_params(self))+SX17_get_width(ccsm_get_stepper_params(self))+5+10;
function ccsm_get_width_2(self)=(ALProfile_get_width(ccsm_get_al_profile_params(self))*1.5)+SX17_get_width(ccsm_get_stepper_params(self))+5+10;
function ccsm_get_length(self)=(ALProfile_get_width(ccsm_get_al_profile_params(self))*2)+SX17_get_width(ccsm_get_stepper_params(self))+5;
function ccsm_get_stepper_support_width(self)=ccsm_get_width_1(self)-ALProfile_get_width(ccsm_get_al_profile_params(self));
function ccsm_get_stepper_support_length(self)=SX17_get_width(ccsm_get_stepper_params(self))+5;
function ccsm_get_stepper_position_offset_y(self)=ccsm_get_stepper_support_length(self)/2+ALProfile_get_width(ccsm_get_al_profile_params(self));
function ccsm_get_stepper_mount_screw_diameter_with_delta(self)=
            SX17_get_mount_screw_diameter(ccsm_get_stepper_params(self))+ccsm_get_delta(self);
function ccsm_get_mount_screw_diameter_with_delta(self)=ccsm_get_mounting_screw_diameter(self)+ccsm_get_delta(self);

module corner_coupler_with_motor_holder_holes(self)
{
    translate([ALProfile_get_width(ccsm_get_al_profile_params(self))/2,ALProfile_get_width(ccsm_get_al_profile_params(self))/2,0])
        cube([ALProfile_get_width(ccsm_get_al_profile_params(self))+0.1,ALProfile_get_width(ccsm_get_al_profile_params(self))+0.1,3*ccsm_get_height_1(self)],center=true);
    
    translate([ccsm_get_stepper_possition_offset_x(self),ccsm_get_stepper_position_offset_y(self),0])
    {
        cylinder(d=SX17_get_rim_diameter(ccsm_get_stepper_params(self)), h=ccsm_get_height_2(self)*3,center=true);
        
        for(i = [0: 90:270])
        {
            rotate([0,0,i])
            {
                translate([SX17_get_mount_screw_position(ccsm_get_stepper_params(self)),SX17_get_mount_screw_position(ccsm_get_stepper_params(self)),0])
                    cylinder(d=ccsm_get_stepper_mount_screw_diameter_with_delta(self),h=ccsm_get_height_2(self)*3,center=true);
            }
        }
    }
    
    translate([ALProfile_get_width(ccsm_get_al_profile_params(self))/2,ccsm_get_length(self)-ALProfile_get_width(ccsm_get_al_profile_params(self))/2,0])
        cylinder(d=ccsm_get_mount_screw_diameter_with_delta(self), h=ccsm_get_height_1(self)*3,center=true);
    
     translate([ALProfile_get_width(ccsm_get_al_profile_params(self))/2,ALProfile_get_width(ccsm_get_al_profile_params(self))*1.5,0])
        cylinder(d=ccsm_get_mount_screw_diameter_with_delta(self), h=ccsm_get_height_1(self)*3,center=true);
    
    translate([(ccsm_get_width_1(self)-ALProfile_get_width(ccsm_get_al_profile_params(self)))/2+ALProfile_get_width(ccsm_get_al_profile_params(self)),ALProfile_get_width(ccsm_get_al_profile_params(self))/2,0])
        cylinder(d=ccsm_get_mount_screw_diameter_with_delta(self), h=ccsm_get_height_1(self)*3,center=true);
    
    translate([ccsm_get_width_2(self)-ALProfile_get_width(ccsm_get_al_profile_params(self))/2,ccsm_get_length(self)-ALProfile_get_width(ccsm_get_al_profile_params(self))/2,0])
        cylinder(d=ccsm_get_mount_screw_diameter_with_delta(self), h=ccsm_get_height_1(self)*3,center=true);
    
}

module corner_coupler_with_motor_holder_body(self)
{
   base_position_z1 = ccsm_get_height_1(self)/2;
   base_position_z2 = ccsm_get_height_2(self)/2;
   
   translate([ccsm_get_width_1(self)/2, ccsm_get_length(self)/2,base_position_z1])
        cube([ccsm_get_width_1(self), ccsm_get_length(self), ccsm_get_height_1(self)],center=true);
    
    
    translate([ccsm_get_stepper_support_width(self)/2+ALProfile_get_width(ccsm_get_al_profile_params(self)),ccsm_get_stepper_position_offset_y(self),base_position_z2])
    {
        cube([ccsm_get_stepper_support_width(self), 
                ccsm_get_stepper_support_length(self), 
                ccsm_get_height_2(self)],
                center=true);
    }
    
    translate([ccsm_get_width_2(self)/2,ccsm_get_length(self)-ALProfile_get_width(ccsm_get_al_profile_params(self))/2, base_position_z1])
        cube([ccsm_get_width_2(self),ALProfile_get_width(ccsm_get_al_profile_params(self)),ccsm_get_height_1(self)],center=true);
}

module corner_coupler_with_motor_holder(self)
{
    difference()
    {
        corner_coupler_with_motor_holder_body(self);
        corner_coupler_with_motor_holder_holes(self);
    }
}

//
//corner_coupler_with_motor_holder(ccsm_params);