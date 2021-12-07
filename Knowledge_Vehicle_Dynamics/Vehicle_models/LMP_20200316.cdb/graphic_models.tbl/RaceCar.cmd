!
!-------------------------- Default Units for Model ---------------------------!
!
!
defaults units  &
   length = mm  &
   angle = deg  &
   force = newton  &
   mass = kg  &
   time = sec
!
defaults units  &
   coordinate_system_type = cartesian  &
   orientation_type = body313
!
!------------------------ Default Attributes for Model ------------------------!
!
!
defaults attributes  &
   inheritance = bottom_up  &
   icon_visibility = on  &
   grid_visibility = off  &
   size_of_icons = 50.0  &
   spacing_for_grid = 50.0
!
!------------------------------ Adams/View Model ------------------------------!
!
!
model create  &
   model_name = RaceCar  &
   title = "ADAMS/Car template"
!
view erase
!
!-------------------------------- Data storage --------------------------------!
!
!
data_element create string  &
   string_name = .RaceCar.minor_role_string  &
   string = ""
!
!--------------------------------- Materials ----------------------------------!
!
!
material create  &
   material_name = .RaceCar.steel  &
   youngs_modulus = 2.07E+005  &
   poissons_ratio = 0.29  &
   density = 7.801E-006
!
!-------------------------------- Rigid Parts ---------------------------------!
!
! Create parts and their dependent markers and graphics
!
!----------------------------------- ground -----------------------------------!
!
!
! ****** Ground Part ******
!
defaults model  &
   part_name = ground
!
defaults coordinate_system  &
   default_coordinate_system = .RaceCar.ground
!
! ****** Markers for current part ******
!
marker create  &
   marker_name = .RaceCar.ground.origo  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker attributes  &
   marker_name = .RaceCar.ground.origo  &
   visibility = off  &
   name_visibility = off
!
marker create  &
   marker_name = .RaceCar.ground.shell_Ref  &
   location = 0.0, 0.0, -345.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker attributes  &
   marker_name = .RaceCar.ground.shell_Ref  &
   visibility = off  &
   name_visibility = off
!
!-------------------------------- ges_chassis ---------------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = .RaceCar.ground
!
part create rigid_body name_and_position  &
   part_name = .RaceCar.ges_chassis  &
   adams_id = 2  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
defaults coordinate_system  &
   default_coordinate_system = .RaceCar.ges_chassis
!
! ****** Markers for current part ******
!
marker create  &
   marker_name = .RaceCar.ges_chassis.cm  &
   location = 1500.0, 0.0, 300.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker attributes  &
   marker_name = .RaceCar.ges_chassis.cm  &
   visibility = off  &
   name_visibility = off
!
marker create  &
   marker_name = .RaceCar.ges_chassis.inertia_frame  &
   location = 1500.0, 0.0, 300.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker attributes  &
   marker_name = .RaceCar.ges_chassis.inertia_frame  &
   visibility = off  &
   name_visibility = off
!
marker create  &
   marker_name = .RaceCar.ges_chassis.fwl  &
   location = 0.0, 760.0, 329.0  &
   orientation = 0.0d, 90.0d, 0.0d
!
marker attributes  &
   marker_name = .RaceCar.ges_chassis.fwl  &
   visibility = off  &
   name_visibility = off
!
marker create  &
   marker_name = .RaceCar.ges_chassis.rwl  &
   location = -2777.2, 797.0, 379.28  &
   orientation = 0.0d, 90.0d, 0.0d
!
marker attributes  &
   marker_name = .RaceCar.ges_chassis.rwl  &
   visibility = off  &
   name_visibility = off
!
marker create  &
   marker_name = .RaceCar.ges_chassis.rwr  &
   location = -2777.2, -797.0, 379.28  &
   orientation = 0.0d, 90.0d, 0.0d
!
marker attributes  &
   marker_name = .RaceCar.ges_chassis.rwr  &
   visibility = off  &
   name_visibility = off
!
marker create  &
   marker_name = .RaceCar.ges_chassis.fwr  &
   location = 0.0, -760.0, 329.0  &
   orientation = 0.0d, 90.0d, 0.0d
!
marker attributes  &
   marker_name = .RaceCar.ges_chassis.fwr  &
   visibility = off  &
   name_visibility = off
!
part create rigid_body mass_properties  &
   part_name = .RaceCar.ges_chassis  &
   mass = 1.0  &
   center_of_mass_marker = .RaceCar.ges_chassis.cm  &
   inertia_marker = .RaceCar.ges_chassis.inertia_frame  &
   ixx = 1.0  &
   iyy = 1.0  &
   izz = 1.0  &
   ixy = 0.0  &
   izx = 0.0  &
   iyz = 0.0
!
part attributes  &
   part_name = .RaceCar.ges_chassis  &
   visibility = on  &
   name_visibility = on
!
!------------------------------ whl_front_wheel -------------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = .RaceCar.ground
!
part create rigid_body name_and_position  &
   part_name = .RaceCar.whl_front_wheel  &
   adams_id = 3  &
   location = 0.0, 760.0, 329.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
defaults coordinate_system  &
   default_coordinate_system = .RaceCar.whl_front_wheel
!
! ****** Markers for current part ******
!
marker create  &
   marker_name = .RaceCar.whl_front_wheel.cm  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker attributes  &
   marker_name = .RaceCar.whl_front_wheel.cm  &
   visibility = off  &
   name_visibility = off
!
marker create  &
   marker_name = .RaceCar.whl_front_wheel.tire_i  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 90.0d, 0.0d
!
marker attributes  &
   marker_name = .RaceCar.whl_front_wheel.tire_i  &
   visibility = off  &
   name_visibility = off
!
part create rigid_body mass_properties  &
   part_name = .RaceCar.whl_front_wheel  &
   mass = 1.0  &
   center_of_mass_marker = .RaceCar.whl_front_wheel.cm  &
   ixx = 1.0  &
   iyy = 1.0  &
   izz = 1.0  &
   ixy = 0.0  &
   izx = 0.0  &
   iyz = 0.0
!
part attributes  &
   part_name = .RaceCar.whl_front_wheel  &
   visibility = on  &
   name_visibility = on
!
!------------------------------ whr_front_wheel -------------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = .RaceCar.ground
!
part create rigid_body name_and_position  &
   part_name = .RaceCar.whr_front_wheel  &
   adams_id = 5  &
   location = 0.0, -760.0, 329.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
defaults coordinate_system  &
   default_coordinate_system = .RaceCar.whr_front_wheel
!
! ****** Markers for current part ******
!
marker create  &
   marker_name = .RaceCar.whr_front_wheel.cm  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker attributes  &
   marker_name = .RaceCar.whr_front_wheel.cm  &
   visibility = off  &
   name_visibility = off
!
marker create  &
   marker_name = .RaceCar.whr_front_wheel.tire_i  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 90.0d, 0.0d
!
marker attributes  &
   marker_name = .RaceCar.whr_front_wheel.tire_i  &
   visibility = off  &
   name_visibility = off
!
part create rigid_body mass_properties  &
   part_name = .RaceCar.whr_front_wheel  &
   mass = 1.0  &
   center_of_mass_marker = .RaceCar.whr_front_wheel.cm  &
   ixx = 1.0  &
   iyy = 1.0  &
   izz = 1.0  &
   ixy = 0.0  &
   izx = 0.0  &
   iyz = 0.0
!
part attributes  &
   part_name = .RaceCar.whr_front_wheel  &
   visibility = on  &
   name_visibility = on
!
!------------------------------- whl_rear_wheel -------------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = .RaceCar.ground
!
part create rigid_body name_and_position  &
   part_name = .RaceCar.whl_rear_wheel  &
   adams_id = 4  &
   location = -2777.2, 797.0, 379.28  &
   orientation = 0.0d, 0.0d, 0.0d
!
defaults coordinate_system  &
   default_coordinate_system = .RaceCar.whl_rear_wheel
!
! ****** Markers for current part ******
!
marker create  &
   marker_name = .RaceCar.whl_rear_wheel.cm  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker attributes  &
   marker_name = .RaceCar.whl_rear_wheel.cm  &
   visibility = off  &
   name_visibility = off
!
marker create  &
   marker_name = .RaceCar.whl_rear_wheel.tire_i  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 90.0d, 0.0d
!
marker attributes  &
   marker_name = .RaceCar.whl_rear_wheel.tire_i  &
   visibility = off  &
   name_visibility = off
!
part create rigid_body mass_properties  &
   part_name = .RaceCar.whl_rear_wheel  &
   mass = 1.0  &
   center_of_mass_marker = .RaceCar.whl_rear_wheel.cm  &
   ixx = 1.0  &
   iyy = 1.0  &
   izz = 1.0  &
   ixy = 0.0  &
   izx = 0.0  &
   iyz = 0.0
!
part attributes  &
   part_name = .RaceCar.whl_rear_wheel  &
   visibility = on  &
   name_visibility = on
!
!------------------------------- whr_rear_wheel -------------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = .RaceCar.ground
!
part create rigid_body name_and_position  &
   part_name = .RaceCar.whr_rear_wheel  &
   adams_id = 6  &
   location = -2777.2, -797.0, 379.28  &
   orientation = 0.0d, 0.0d, 0.0d
!
defaults coordinate_system  &
   default_coordinate_system = .RaceCar.whr_rear_wheel
!
! ****** Markers for current part ******
!
marker create  &
   marker_name = .RaceCar.whr_rear_wheel.cm  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker attributes  &
   marker_name = .RaceCar.whr_rear_wheel.cm  &
   visibility = off  &
   name_visibility = off
!
marker create  &
   marker_name = .RaceCar.whr_rear_wheel.tire_i  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 90.0d, 0.0d
!
marker attributes  &
   marker_name = .RaceCar.whr_rear_wheel.tire_i  &
   visibility = off  &
   name_visibility = off
!
part create rigid_body mass_properties  &
   part_name = .RaceCar.whr_rear_wheel  &
   mass = 1.0  &
   center_of_mass_marker = .RaceCar.whr_rear_wheel.cm  &
   ixx = 1.0  &
   iyy = 1.0  &
   izz = 1.0  &
   ixy = 0.0  &
   izx = 0.0  &
   iyz = 0.0
!
part attributes  &
   part_name = .RaceCar.whr_rear_wheel  &
   visibility = on  &
   name_visibility = on
!
!----------------------------- Analysis settings ------------------------------!
!
!
!---------------------------- Adams/View Variables ----------------------------!
!
!
variable create  &
   variable_name = .RaceCar.cil_front_wheel_center  &
   units = "length"  &
   real_value = 0.0, 760.0, 329.0
!
variable create  &
   variable_name = .RaceCar.cir_front_wheel_center  &
   units = "length"  &
   real_value = 0.0, -760.0, 329.0
!
variable create  &
   variable_name = .RaceCar.cil_rear_wheel_center  &
   units = "length"  &
   real_value = -2777.2, 797.0, 379.28
!
variable create  &
   variable_name = .RaceCar.cir_rear_wheel_center  &
   units = "length"  &
   real_value = -2777.2, -797.0, 379.28
!
variable create  &
   variable_name = .RaceCar.cil_front_toe_angle  &
   units = "no_units"  &
   real_value = 0.0
!
variable create  &
   variable_name = .RaceCar.cir_front_toe_angle  &
   units = "no_units"  &
   real_value = 0.0
!
variable create  &
   variable_name = .RaceCar.cil_front_camber_angle  &
   units = "no_units"  &
   real_value = 0.0
!
variable create  &
   variable_name = .RaceCar.cir_front_camber_angle  &
   units = "no_units"  &
   real_value = 0.0
!
variable create  &
   variable_name = .RaceCar.cil_rear_camber_angle  &
   units = "no_units"  &
   real_value = 0.0
!
variable create  &
   variable_name = .RaceCar.cir_rear_camber_angle  &
   units = "no_units"  &
   real_value = 0.0
!
variable create  &
   variable_name = .RaceCar.cil_rear_toe_angle  &
   units = "no_units"  &
   real_value = 0.0
!
variable create  &
   variable_name = .RaceCar.cir_rear_toe_angle  &
   units = "no_units"  &
   real_value = 0.0
!
!--------------------------- Expression definitions ---------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = ground
!
material modify  &
   material_name = .RaceCar.steel  &
   youngs_modulus = (2.07E+011(Newton/meter**2))  &
   density = (7801.0(kg/meter**3))
!
marker modify  &
   marker_name = .RaceCar.ges_chassis.inertia_frame  &
   location =   &
      (LOC_RELATIVE_TO({0, 0, 0}, .RaceCar.ges_chassis.cm))  &
   orientation =   &
      (ORI_RELATIVE_TO({0, 0, 0}, .RaceCar.ges_chassis))  &
   relative_to = .RaceCar.ges_chassis
!
defaults coordinate_system  &
   default_coordinate_system = .RaceCar.ground
!
marker modify  &
   marker_name = .RaceCar.ges_chassis.fwl  &
   location =   &
      (.RaceCar.cil_front_wheel_center)  &
   orientation =   &
      (ORI_RELATIVE_TO({180d - .RaceCar.cil_front_toe_angle, -90d - .RaceCar.cil_front_camber_angle, 180d}, .RaceCar.ground.origo))  &
   relative_to = .RaceCar.ges_chassis
!
defaults coordinate_system  &
   default_coordinate_system = .RaceCar.ground
!
marker modify  &
   marker_name = .RaceCar.ges_chassis.rwl  &
   location =   &
      (.RaceCar.cil_rear_wheel_center)  &
   orientation =   &
      (ORI_RELATIVE_TO({180d - .RaceCar.cil_rear_toe_angle, -90d - .RaceCar.cil_rear_camber_angle, 180d}, .RaceCar.ground.origo))  &
   relative_to = .RaceCar.ges_chassis
!
defaults coordinate_system  &
   default_coordinate_system = .RaceCar.ground
!
marker modify  &
   marker_name = .RaceCar.ges_chassis.rwr  &
   location =   &
      (.RaceCar.cir_rear_wheel_center)  &
   orientation =   &
      (ORI_RELATIVE_TO({180d - .RaceCar.cir_rear_toe_angle, -90d - .RaceCar.cir_rear_camber_angle, 180d}, .RaceCar.ground.origo))  &
   relative_to = .RaceCar.ges_chassis
!
defaults coordinate_system  &
   default_coordinate_system = .RaceCar.ground
!
marker modify  &
   marker_name = .RaceCar.ges_chassis.fwr  &
   location =   &
      (.RaceCar.cir_front_wheel_center)  &
   orientation =   &
      (ORI_RELATIVE_TO({180d - .RaceCar.cir_front_toe_angle, -90d - .RaceCar.cir_front_camber_angle, 180d}, .RaceCar.ground.origo))  &
   relative_to = .RaceCar.ges_chassis
!
defaults coordinate_system  &
   default_coordinate_system = .RaceCar.ground
!
marker modify  &
   marker_name = .RaceCar.whl_front_wheel.tire_i  &
   location =   &
      (LOC_RELATIVE_TO({0, 0, 0}, .RaceCar.ges_chassis.fwl))  &
   orientation =   &
      (ORI_RELATIVE_TO({0, 0, 0}, .RaceCar.ges_chassis.fwl))  &
   relative_to = .RaceCar.whl_front_wheel
!
defaults coordinate_system  &
   default_coordinate_system = .RaceCar.ground
!
part modify rigid_body name_and_position  &
   part_name = .RaceCar.whl_front_wheel  &
   location =   &
      (LOC_RELATIVE_TO({0, 0, 0}, .RaceCar.ges_chassis.fwl))
!
marker modify  &
   marker_name = .RaceCar.whr_front_wheel.tire_i  &
   location =   &
      (LOC_RELATIVE_TO({0, 0, 0}, .RaceCar.ges_chassis.fwr))  &
   orientation =   &
      (ORI_RELATIVE_TO({0, 0, 0}, .RaceCar.ges_chassis.fwr))  &
   relative_to = .RaceCar.whr_front_wheel
!
defaults coordinate_system  &
   default_coordinate_system = .RaceCar.ground
!
part modify rigid_body name_and_position  &
   part_name = .RaceCar.whr_front_wheel  &
   location =   &
      (LOC_RELATIVE_TO({0, 0, 0}, .RaceCar.ges_chassis.fwr))
!
marker modify  &
   marker_name = .RaceCar.whl_rear_wheel.tire_i  &
   location =   &
      (LOC_RELATIVE_TO({0, 0, 0}, .RaceCar.ges_chassis.rwl))  &
   orientation =   &
      (ORI_RELATIVE_TO({0, 0, 0}, .RaceCar.ges_chassis.rwl))  &
   relative_to = .RaceCar.whl_rear_wheel
!
defaults coordinate_system  &
   default_coordinate_system = .RaceCar.ground
!
part modify rigid_body name_and_position  &
   part_name = .RaceCar.whl_rear_wheel  &
   location =   &
      (LOC_RELATIVE_TO({0, 0, 0}, .RaceCar.ges_chassis.rwl))
!
marker modify  &
   marker_name = .RaceCar.whr_rear_wheel.tire_i  &
   location =   &
      (LOC_RELATIVE_TO({0, 0, 0}, .RaceCar.ges_chassis.rwr))  &
   orientation =   &
      (ORI_RELATIVE_TO({0, 0, 0}, .RaceCar.ges_chassis.rwr))  &
   relative_to = .RaceCar.whr_rear_wheel
!
defaults coordinate_system  &
   default_coordinate_system = .RaceCar.ground
!
part modify rigid_body name_and_position  &
   part_name = .RaceCar.whr_rear_wheel  &
   location =   &
      (LOC_RELATIVE_TO({0, 0, 0}, .RaceCar.ges_chassis.rwr))
!
model display  &
   model_name = RaceCar
!
!---- Customization commands
!
marker create  &
   marker_name = .RaceCar.ges_chassis.geo_mar  &
   location = 0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
geometry create shape shell  &
   shell_name = .RaceCar.ges_chassis.Body  &
   reference_marker = .RaceCar.ges_chassis.geo_mar  &
   file_name = "mdids://LMP_20200316/shell_graphics.tbl/RaceCar_RT_ges_chassis.shl"  &
   wireframe_only = no
geometry attributes  &
   geometry_name = .RaceCar.ges_chassis.Body  &
   transparency = 0 &
   color = red
variable set  &
   variable_name = .RaceCar.cil_front_wheel_center  &
   real_value = 0.0, 825.0, 329.0
variable set  &
   variable_name = .RaceCar.cir_front_wheel_center  &
   real_value = 0.0, -825.0, 329.0
variable set  &
   variable_name = .RaceCar.cil_rear_wheel_center  &
   real_value = -2700.0, 825.0, 360.0
variable set  &
   variable_name = .RaceCar.cir_rear_wheel_center  &
   real_value = -2700.0, -825.0, 360.0
!
defaults model  &
   part_name = .RaceCar.whl_front_wheel
geometry create shape shell  &
   file_name = "mdids://LMP_20200316/shell_graphics.tbl/RaceCar_RT_whl_front_rim.shl"  &
   shell_name = rim  &
   reference_marker = .RaceCar.whl_front_wheel.tire_i  &
   wireframe_only = no
geometry create shape shell  &
   file_name = "mdids://LMP_20200316/shell_graphics.tbl/RaceCar_RT_whl_front_tire.shl"  &
   shell_name = tire  &
   reference_marker = .RaceCar.whl_front_wheel.tire_i  &
   wireframe_only = no
!
defaults model  &
   part_name = .RaceCar.whr_front_wheel
geometry create shape shell  &
   file_name = "mdids://LMP_20200316/shell_graphics.tbl/RaceCar_RT_whr_front_rim.shl"  &
   shell_name = rim  &
   reference_marker = .RaceCar.whr_front_wheel.tire_i  &
   wireframe_only = no
geometry create shape shell  &
   file_name = "mdids://LMP_20200316/shell_graphics.tbl/RaceCar_RT_whr_front_tire.shl"  &
   shell_name = tire  &
   reference_marker = .RaceCar.whr_front_wheel.tire_i  &
   wireframe_only = no
!
defaults model  &
   part_name = .RaceCar.whl_rear_wheel
geometry create shape shell  &
   file_name = "mdids://LMP_20200316/shell_graphics.tbl/RaceCar_RT_whl_rear_rim.shl"  &
   shell_name = rim  &
   reference_marker = .RaceCar.whl_rear_wheel.tire_i  &
   wireframe_only = no
geometry create shape shell  &
   file_name = "mdids://LMP_20200316/shell_graphics.tbl/RaceCar_RT_whl_rear_tire.shl"  &
   shell_name = tire  &
   reference_marker = .RaceCar.whl_rear_wheel.tire_i  &
   wireframe_only = no
!
defaults model  &
   part_name = .RaceCar.whr_rear_wheel
geometry create shape shell  &
   file_name = "mdids://LMP_20200316/shell_graphics.tbl/RaceCar_RT_whr_rear_rim.shl"  &
   shell_name = rim  &
   reference_marker = .RaceCar.whr_rear_wheel.tire_i  &
   wireframe_only = no
geometry create shape shell  &
   file_name = "mdids://LMP_20200316/shell_graphics.tbl/RaceCar_RT_whr_rear_tire.shl"  &
   shell_name = tire  &
   reference_marker = .RaceCar.whr_rear_wheel.tire_i  &
   wireframe_only = no
!
entity attributes &
 entity_name     = whl_front_wheel.rim,whr_front_wheel.rim,whl_rear_wheel.rim,whr_rear_wheel.rim &
 color           = DARK_GRAY 
entity attributes &
 entity_name     = whl_front_wheel.tire,whr_front_wheel.tire,whl_rear_wheel.tire,whr_rear_wheel.tire &
 color           = BLACK 
