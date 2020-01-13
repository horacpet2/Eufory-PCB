
include </home/petr/OpenScadLib/AlProfil.scad>
include </home/petr/OpenScadLib/NEMA_SX17.scad>


/*
** 0 - height 1
** 1 - height 2
** 2 - mounting screw diameter
** 3 - delta
*/
cc_params = [3, 5, 6, 0.5];


function cc_get_height_1(self)=self[0];
function cc_get_height_2(self)=self[1];
function cc_get_mounting_screw_diameter(self)=self[2];
function cc_get_mounting_screw_diameter_with_delta(self)=self[2]+self[3];
function cc_get_delta(self)=self[3];
function cc_get_width(NEMA_SX17, ALProfile)=(2*ALProfile_get_width(ALProfile))+SX17_get_width(NEMA_SX17);


module corner_coupler_with_motor_holder_holes(self, NEMA_SX17, ALProfile)
{
    stepper_screw_position = [SX17_get_mount_screw_position(NEMA_SX17),
                              SX17_get_mount_screw_position(NEMA_SX17),
                              0];
    
    corner_hole_position = [(cc_get_width(NEMA_SX17, ALProfile))/2-ALProfile_get_width(ALProfile)/2,
                            cc_get_width(NEMA_SX17, 
                            ALProfile)/2-ALProfile_get_width(ALProfile)/2,
                            0];
  
    mounting_screw_position_1 = [cc_get_width(NEMA_SX17, ALProfile)/2-2*ALProfile_get_width(ALProfile),
                                cc_get_width(NEMA_SX17, ALProfile)/2-ALProfile_get_width(ALProfile)/2,
                                0];
    
    mounting_screw_position_2 = [-(cc_get_width(NEMA_SX17, ALProfile)/2-20),
                                -(cc_get_width(NEMA_SX17, ALProfile)/2-ALProfile_get_width(ALProfile)/2),
                                0];
    
    mounting_screw_position_3 = [(cc_get_width(NEMA_SX17, ALProfile)/2-ALProfile_get_width(ALProfile)/2),
                                -(cc_get_width(NEMA_SX17, ALProfile)/2-ALProfile_get_width(ALProfile)/2),
                                 0];
    
    mounting_screw_position_4 = [(cc_get_width(NEMA_SX17, ALProfile)/2-ALProfile_get_width(ALProfile)/2),
                                cc_get_width(NEMA_SX17, ALProfile)/2-(ALProfile_get_width(ALProfile)*2),
                                0];
    
    cylinder(d=SX17_get_rim_diameter(NEMA_SX17)+1,h=20,center=true);
    
    for(i=[0:90:270])
    {
           rotate([0,0,i])
           {
               translate(stepper_screw_position)
                    cylinder(d=SX17_get_mount_screw_diameter(NEMA_SX17)+cc_get_delta(self),h=20,center=true);
           }
    }
    
    translate(corner_hole_position)
        cube([ALProfile_get_width(ALProfile)+0.1,ALProfile_get_width(ALProfile)+0.1,10],center=true);
        
    translate(mounting_screw_position_1)
        cylinder(d=cc_get_mounting_screw_diameter_with_delta(self),h=20,$fn=100,center=true);
    
    translate(mounting_screw_position_2)
        cylinder(d=cc_get_mounting_screw_diameter_with_delta(self),h=20,$fn=100,center=true);
    
    translate(mounting_screw_position_3)
        cylinder(d=cc_get_mounting_screw_diameter_with_delta(self),h=20,$fn=100,center=true);
    
    translate(mounting_screw_position_4)
        cylinder(d=cc_get_mounting_screw_diameter_with_delta(self),h=20,$fn=100,center=true);
}

module corner_coupler_with_motor_holder_body(self, NEMA_SX17, ALProfile)
{
    translate([ALProfile_get_width(ALProfile)/4,0,1.5])
    {
        cube([cc_get_width(NEMA_SX17, ALProfile)-ALProfile_get_width(ALProfile)/2,
                cc_get_width(NEMA_SX17, ALProfile),
                cc_get_height_1(self)],center=true);
    }
    
    translate([-ALProfile_get_width(ALProfile)/4,0,0.5])
    {
        cube([SX17_get_width(NEMA_SX17)+ALProfile_get_width(ALProfile)/2, 
                SX17_get_width(NEMA_SX17), 
                cc_get_height_2(self)],
                center=true);
    }
    
    translate([0,-cc_get_width(NEMA_SX17, ALProfile)/2+ALProfile_get_width(ALProfile)/2,1.5])
    {
        cube([cc_get_width(NEMA_SX17, ALProfile),
                ALProfile_get_width(ALProfile),
                cc_get_height_1(self)],
                center=true);
    }
}

module corner_coupler_with_motor_holder(self, NEMA_SX17, ALProfile)
{
    difference()
    {
        corner_coupler_with_motor_holder_body(self, NEMA_SX17, ALProfile);
        corner_coupler_with_motor_holder_holes(self, NEMA_SX17, ALProfile);
    }
}

corner_coupler_with_motor_holder(cc_params, nema17_1005Params,AlProfile30x30Params);
