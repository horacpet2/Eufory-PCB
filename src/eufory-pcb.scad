include </home/petr/OpenScadLib/AlProfil.scad>
include </home/petr/OpenScadLib/NEMA_SX17.scad>




include<case.scad>
include<corner_coupler_with_bearing_idler.scad>
include<corner_coupler_with_motor_holder.scad>
include<smooth_rod_holder.scad>
include<coupler.scad>
include<uv_laser_module.scad>
include<parameters.scad>


case_params=
[
	construction_params,
	AlProfile30x30Params,
	nema17_1005Params
];


/*
** 0 - height 1
** 1 - height 2
** 2 - mounting screw diameter
** 3 - al profil width
** 4 - stepper possition offset
** 5 - stepper mount screw diameter
** 6 - stepper mount screw position
** 7 - stepper width
** 9 - stepper rim diameter
** 9 - delta
*/

ccsm_params = 
[
	3, 
	5, 
	6, 
	ALProfile_get_width(AlProfile30x30Params)+SX17_get_width(nema17_1005Params)/2+5, 
	0.5,
	AlProfile30x30Params,
	nema17_1005Params,
];


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
ccbi_params = 
[
	15,
	12,
	6,
	3,
	10,
	1.5,
	ALProfile_get_width(AlProfile30x30Params)+SX17_get_width(nema17_1005Params)/2+5,
	0.5,
	AlProfile30x30Params, 
	nema17_1005Params
];



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
coupler_params = 
[
	30,
	60, 
	5, 
	6, 
	5, 
	0, 
	7.5,
	0.5
];
	
long_coupler_params = 
[
	30,
	80,
	5, 
	6, 
	0,
	0,
	7.5,
	0.5
];

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
smooth_rod_holder_params = 
[
	12, 
	30, 
	6, 
	10, 
	6, 
	8, 
	3, 
	6, 
	0.7
];



/*
** 0 - case parameters
** 
*/
eufory_pcb_params=
[
	case_params,
	coupler_params,
	long_coupler_params,
	ccbi_params,
	ccsm_params,
	UVLaserModuleParams,
	smooth_rod_holder_params,
	construction_params,
	true,
	false
];


function eufory_pcb_get_case_params(self)=self[0];
function eufory_pcb_get_coupler_params(self)=self[1];
function eufory_pcb_get_long_coupler_params(self)=self[2];
function eufory_pcb_get_ccbi_params(self)=self[3];
function eufory_pcb_get_ccsm_params(self)=self[4];
function eufory_pcb_get_uv_module_params(self)=self[5];
function eufory_pcb_get_smooth_rod_holer_params(self)=self[6];
function eufory_pcb_get_construction_parameters(self)=self[7];
function eufory_pcb_get_right_orientation(self)=self[8];
function eufory_pcb_get_left_orientation(self)=self[9];





module eufory_pcb_place_ccbi(self, position, orientation)
{
	translate(position)
	{
		ccbi_orientation = orientation == eufory_pcb_get_right_orientation(self) ? 1 : 0; 
		
		mirror([ccbi_orientation ,0,0])
		{
			rotate([0,180,0])
				corner_coupler_with_bearing_indler(eufory_pcb_get_ccbi_params(self));
		}
	}
}


module eufory_pcb_ccbi(self, object_color)
{
	z_position = construction_get_height(eufory_pcb_get_construction_parameters(self)) + 
					ccbi_get_height_1(eufory_pcb_get_ccbi_params(self));
	x_position_base = construction_get_width(eufory_pcb_get_construction_parameters(self))/2;
	y_position = - construction_get_length(eufory_pcb_get_construction_parameters(self))/2;
	
	ccbi_pos_left = [x_position_base,y_position,z_position];
	ccbi_pos_right = [-x_position_base,y_position,z_position];
	
	color(object_color)
	{
		eufory_pcb_place_ccbi(self, ccbi_pos_right, eufory_pcb_get_right_orientation(self));
		eufory_pcb_place_ccbi(self, ccbi_pos_left, eufory_pcb_get_left_orientation(self));
	}
}

module eufory_pcm_place_ccsm(self,position, orientation)
{
	translate(position)
	{
		ccbi_orientation = orientation == eufory_pcb_get_right_orientation(self) ? 1 : 0; 
		
		mirror([ccbi_orientation,0,0,])
		{
			rotate([0,180,180])
				corner_coupler_with_motor_holder(eufory_pcb_get_ccsm_params(self));
		}
	}
}

module eufory_pcb_ccsm(self, object_color)
{
	z_position = construction_get_height(eufory_pcb_get_construction_parameters(self)) + 
					ccsm_get_height_1(eufory_pcb_get_ccsm_params(self));
	x_position_base = construction_get_width(eufory_pcb_get_construction_parameters(self))/2;
	y_position = construction_get_length(eufory_pcb_get_construction_parameters(self))/2;
	
	ccsm_pos_left = [-x_position_base,y_position,z_position];
	ccsm_pos_right = [x_position_base,y_position,z_position];
	
	color(object_color)
	{
		eufory_pcm_place_ccsm(self, ccsm_pos_right, eufory_pcb_get_right_orientation(self));
		eufory_pcm_place_ccsm(self, ccsm_pos_left, eufory_pcb_get_left_orientation(self));
	}
}

module eufory_pcb_smooth_rod_place(self, position, side_orientation, position_orientation)
{
	x_rotation = (position[1] > 0 && side_orientation == eufory_pcb_get_left_orientation(self)) ? 90: -90 ;
	
	translate(position)
	{
		rotate([x_rotation,0,0])
			smooth_rod_holder(eufory_pcb_get_smooth_rod_holer_params(self));
	}
}

module eufory_pcb_smooth_rod(self,object_color)
{
/* 
** doladit získávání hodnoty šířky al profilu, offsetu pozice upevňovacích šroubů a 
** výšky držáku hlazené tyče 
*/
	color(object_color)
	{
		z_position = construction_get_height(eufory_pcb_get_construction_parameters(self))-15+eufory_pcb_get_smooth_rod_holer_params(self)[7];
		y_position_right = case_get_front_al_profile_position(eufory_pcb_get_case_params(self))+15;
		
		eufory_pcb_smooth_rod_place(self, [-130,y_position_right,z_position], eufory_pcb_get_right_orientation(self));
	}
}


module eufory_pcb(self)
{
	color("gray")
		case_profile_construction(eufory_pcb_get_case_params(self));
	
	eufory_pcb_ccbi(self, "white");
	eufory_pcb_ccsm(self, "white");
	eufory_pcb_smooth_rod(self,"white");
}

eufory_pcb(eufory_pcb_params);

