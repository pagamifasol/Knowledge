%% Find index for accy=1.5
x15g = find(chassis_accelerations_lateral < -1.5,1);

%% Load transfer distribution
deltaFz_front = tir_wheel_tire_forces_normal_front(x15g) - til_wheel_tire_forces_normal_front(x15g);
deltaFz_rear = tir_wheel_tire_forces_normal_rear(x15g) - til_wheel_tire_forces_normal_rear(x15g);

disp('Front load transfer distribution @1.5g [%]: ')
disp(deltaFz_front/(deltaFz_front+deltaFz_rear)*100)

%% Understeer gradient
disp('Driver steering @1.5g [deg]: ')
disp(driver_demands_steering(x15g)*57.325)

%% Vehicle side slip angle
disp('Side slip angle @1.5g [deg]: ')
disp(Vehicle_States_side_slip(x15g).*57.325)

%% Roll angle
disp('Roll angle @1.5g [deg]: ')
disp(Vehicle_States_roll_angle(x15g)*57.325)

%% Max lateral acceleration
disp('Maximum lateral acceleration [g]: ')
xmax = find(chassis_accelerations_lateral == min(chassis_accelerations_lateral));
disp(chassis_accelerations_lateral(xmax))