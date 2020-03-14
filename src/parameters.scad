
/*
** 0 - width
** 1 - length
** 3 - height
** 4 - smooth rod diameter
** 5 - mounting crew diameter
** 6 - mounting screw head diameter
*/
construction_params=
[
	400,
	490,
	200,
	8,
	10
];

function construction_get_width(self)=self[0];
function construction_get_length(self)=self[1];
function construction_get_height(self)=self[2];
function contruction_get_smooth_rod_diameter(self)=self[3];