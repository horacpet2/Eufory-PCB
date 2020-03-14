
include </home/petr/OpenScadLib/AlProfil.scad>
include </home/petr/OpenScadLib/NEMA_SX17.scad>

include <parameters.scad>

/*
** rear al profile position
**((case_get_length(self)-ALProfile_get_width(case_get_al_profile_params(self)))/2)-(ALProfile_get_width(case_get_al_profile_params(self))+SX17_get_width(case_get_stepper_params(self)))
*/

/*
** front al profile position
** -((case_get_length(self)-ALProfile_get_width(case_get_al_profile_params(self)))/2-ALProfile_get_width(case_get_al_profile_params(self))-20)
*/

/*
** 0 - construction parameters
** 1 - al profile parameters
** 2 - stepper parameters
** 3 - rear al profil position
** 4 - front al profile position
*/
case_params=
[
	construction_params,
	AlProfile30x30Params,
	nema17_1005Params
];


function case_get_width(self)=construction_get_width(self[0]);
function case_get_length(self)=construction_get_length(self[0]);
function case_get_height(self)=construction_get_height(self[0]);
function case_get_al_profile_params(self)=self[1];
function case_get_stepper_params(self)=self[2];
function case_get_rear_al_profile_position(self)=((case_get_length(self)-ALProfile_get_width(case_get_al_profile_params(self)))/2)-(ALProfile_get_width(case_get_al_profile_params(self))+SX17_get_width(case_get_stepper_params(self)));
function case_get_front_al_profile_position(self)=-((case_get_length(self)-ALProfile_get_width(case_get_al_profile_params(self)))/2-ALProfile_get_width(case_get_al_profile_params(self))-20);

function case_get_al_profile_1_length(self)=
								case_get_width(self)-
								2*ALProfile_get_width(case_get_al_profile_params(self));
function case_get_al_profile_2_length(self)=
							case_get_length(self)-
							2*ALProfile_get_width(case_get_al_profile_params(self));
function case_get_al_profile_3_length(self)=case_get_height(self);

module case_profile_construction(self)
{
	for(i=[-1:2:1])
	{
		for(j=[-1:2:1])
		{
			translate([((case_get_width(self)-ALProfile_get_width(case_get_al_profile_params(self)))/2)*i, ((case_get_length(self)-ALProfile_get_width(case_get_al_profile_params(self)))/2)*j, 0])
				AlProfile(case_get_al_profile_params(self), case_get_al_profile_3_length(self));
		}

		translate([-case_get_width(self)/2+ALProfile_get_width(case_get_al_profile_params(self)),((case_get_length(self)-ALProfile_get_width(case_get_al_profile_params(self)))/2)*i,ALProfile_get_width(case_get_al_profile_params(self))/2])
		{
			rotate([0,90,0])
			{
				AlProfile(case_get_al_profile_params(self), case_get_al_profile_1_length(self));
			}
		}

		translate([-case_get_width(self)/2+ALProfile_get_width(case_get_al_profile_params(self)),((case_get_length(self)-ALProfile_get_width(case_get_al_profile_params(self)))/2)*i,case_get_height(self)-ALProfile_get_width(case_get_al_profile_params(self))/2])
		{
			rotate([0,90,0])
			{
				AlProfile(case_get_al_profile_params(self), case_get_al_profile_1_length(self));
			}
		}

		translate([((case_get_width(self)-ALProfile_get_width(case_get_al_profile_params(self)))/2)*i,((case_get_length(self))/2-ALProfile_get_width(case_get_al_profile_params(self))),ALProfile_get_width(case_get_al_profile_params(self))/2])
		{
			rotate([90,0,0])
			{
				AlProfile(case_get_al_profile_params(self), case_get_al_profile_2_length(self));
			}
		}

		translate([((case_get_width(self)-ALProfile_get_width(case_get_al_profile_params(self)))/2)*i,((case_get_length(self))/2-ALProfile_get_width(case_get_al_profile_params(self))),case_get_height(self)-ALProfile_get_width(case_get_al_profile_params(self))/2])
		{
			rotate([90,0,0])
			{
				AlProfile(case_get_al_profile_params(self), case_get_al_profile_2_length(self));
			}
		}
	}

	translate([-case_get_width(self)/2+ALProfile_get_width(case_get_al_profile_params(self)),case_get_rear_al_profile_position(self),ALProfile_get_width(case_get_al_profile_params(self))/2])
	{
		rotate([0,90,0])
		{
			AlProfile(case_get_al_profile_params(self), case_get_al_profile_1_length(self));
		}
	}

	translate([-case_get_width(self)/2+ALProfile_get_width(case_get_al_profile_params(self)),case_get_rear_al_profile_position(self),case_get_height(self)-ALProfile_get_width(case_get_al_profile_params(self))/2])
	{
		rotate([0,90,0])
		{
			AlProfile(case_get_al_profile_params(self), case_get_al_profile_1_length(self));
		}
	}

	translate([-case_get_width(self)/2+ALProfile_get_width(case_get_al_profile_params(self)),case_get_front_al_profile_position(self),case_get_height(self)-ALProfile_get_width(case_get_al_profile_params(self))/2])
	{
		rotate([0,90,0])
		{
			AlProfile(case_get_al_profile_params(self), case_get_al_profile_1_length(self));
		}
	}
}

//case_profile_construction(case_params);
