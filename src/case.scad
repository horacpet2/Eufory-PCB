





module case_profile_construction()
{
	for(i=[-1:2:1])
	{
		for(j=[-1:2:1])
		{
			translate([((case_width-SirkaProfilu)/2)*i, ((case_length-SirkaProfilu)/2)*j, 0])
				AlProfil(case_al_profile_length_3);
		}

		translate([-case_width/2+SirkaProfilu,((case_length-SirkaProfilu)/2)*i,SirkaProfilu/2])
		{
			rotate([0,90,0])
			{
				AlProfil(case_al_profile_length_1);
			}
		}

		translate([-case_width/2+SirkaProfilu,((case_length-SirkaProfilu)/2)*i,case_high-SirkaProfilu/2])
		{
			rotate([0,90,0])
			{
				AlProfil(case_al_profile_length_1);
			}
		}

		translate([((case_width-SirkaProfilu)/2)*i,((case_length)/2-SirkaProfilu),SirkaProfilu/2])
		{
			rotate([90,0,0])
			{
				AlProfil(case_al_profile_length_2);
			}
		}

		translate([((case_width-SirkaProfilu)/2)*i,((case_length)/2-SirkaProfilu),case_high-SirkaProfilu/2])
		{
			rotate([90,0,0])
			{
				AlProfil(case_al_profile_length_2);
			}
		}
	}

	translate([-case_width/2+SirkaProfilu,((case_length-SirkaProfilu)/2)-(SirkaProfilu+NX17_mount_width),SirkaProfilu/2])
	{
		rotate([0,90,0])
		{
			AlProfil(case_al_profile_length_1);
		}
	}

	translate([-case_width/2+SirkaProfilu,((case_length-SirkaProfilu)/2)-(SirkaProfilu+NX17_mount_width),case_high-SirkaProfilu/2])
	{
		rotate([0,90,0])
		{
			AlProfil(case_al_profile_length_1);
		}
	}

	translate([-case_width/2+SirkaProfilu,-((case_length-SirkaProfilu)/2-SirkaProfilu-20),case_high-SirkaProfilu/2])
	{
		rotate([0,90,0])
		{
			#AlProfil(case_al_profile_length_1);
		}
	}
}
