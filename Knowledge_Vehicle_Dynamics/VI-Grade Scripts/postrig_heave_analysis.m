%pkg load signal
%clear

%% Vi-Grade 7 post rig analysis

%% Basic plots
% load 'SCG003C_2019_v30high_spr_heave_temp.mat'
f = 100;        %Acquisition frequency
filter = 0.01;  %percentage, default 0.01

% Define base variables
t = time;
n = length(t);

% Frequency bins
f1 = 0:(f/n):(floor(f/2)-f/n);

% Front left
x = global_pad_disp_front_left.*1000;
y = FL_ACC_sensor_ACCZ./9.81;

mx_fl = abs(fft(x)./f); %x magnitude
mx_fl = mx_fl(1:floor(n/2));
mxF_fl = movmean(mx_fl,floor(filter*n/4)); %filtered mx

my_fl = abs(fft(y)./f); %y magnitude
my_fl = my_fl(1:n/2);
myF_fl = movmean(my_fl,floor(filter*n/4)); %filtered my

G_fl = myF_fl./mxF_fl;

% Front right
x = global_pad_disp_front_right.*1000;
y = FR_ACC_sensor_ACCZ./9.81;

mx_fr = abs(fft(x)./f); %x magnitude
mx_fr = mx_fr(1:n/2);
mxF_fr = movmean(mx_fr,floor(filter*n/4)); %filtered mx

my_fr = abs(fft(y)./f); %y magnitude
my_fr = my_fr(1:n/2);
myF_fr = movmean(my_fr,floor(filter*n/4)); %filtered my

G_fr = myF_fr./mxF_fr;

% Rear left
x = global_pad_disp_rear_left.*1000;
y = RL_ACC_sensor_ACCZ./9.81;

mx_rl = abs(fft(x)./f); %x magnitude
mx_rl = mx_rl(1:n/2);
mxF_rl = movmean(mx_rl,floor(filter*n/4)); %filtered mx

my_rl = abs(fft(y)./f); %y magnitude
my_rl = my_rl(1:n/2);
myF_rl = movmean(my_rl,floor(filter*n/4)); %filtered my

G_rl = myF_rl./mxF_rl;

% Rear right
x = global_pad_disp_rear_right.*1000;
y = RR_ACC_sensor_ACCZ./9.81;

mx_rr = abs(fft(x)./f); %x magnitude
mx_rr = mx_rr(1:n/2);
mxF_rr = movmean(mx_rr,floor(filter*n/4)); %filtered mx

my_rr = abs(fft(y)./f); %y magnitude
my_rr = my_rr(1:n/2);
myF_rr = movmean(my_rr,floor(filter*n/4)); %filtered my

G_rr = myF_rr./mxF_rr;

figure(2)
plot(f1,G_fl);
hold on
plot(f1,G_rl);
%plot(f1,G_fr);
%plot(f1,G_rr);
title('Acceleration response [g/mm]')
grid on
xlim([1 25])
ylim([0 0.5])
legend('Front Left','Rear Left','Front Right','Rear Right')

figure(11)
pitchfft = abs(fft(chassis_displacements_pitch)./f);
pitchfft = pitchfft(1:n/2);
hold on
plot(f1,tan(movmean(pitchfft,floor(filter*n/4))).*2700./mxF_fl);
title('Pitch response [mm/mm]')
xlabel('Frequency [Hz]')
grid on
xlim([1 25])

figure(7)
cpl_fl = abs(fft(til_wheel_tire_forces_normal_front)./f);
cpl_fl = cpl_fl(1:n/2);
% cpl_fr = abs(fft(tir_wheel_tire_forces_normal_front)./f);
% cpl_fr = cpl_fr(1:n/2);
cpl_rl = abs(fft(til_wheel_tire_forces_normal_rear)./f);
cpl_rl = cpl_rl(1:n/2);
% cpl_rr = abs(fft(tir_wheel_tire_forces_normal_rear)./f);
% cpl_rr = cpl_rr(1:n/2);
hold on
plot(f1,movmean(cpl_fl,floor(filter*n/4)));
% plot(f1,movmean(cpl_fr,floor(filter*n/4)));
plot(f1,movmean(cpl_rl,floor(filter*n/4)));
% plot(f1,movmean(cpl_rr,floor(filter*n/4)));
title('CPL vs Frequency [N]')
xlabel('Frequency [Hz]')
grid on
legend('FL','FR','RL','RR')
xlim([1 25])
ylim([0 2e3])

figure(12)
jounceFLfft = abs(fft(aero_forces_height_front.*1000)./f);
jounceFLfft = jounceFLfft(1:n/2);
% jounceRLfft = abs(fft(Suspension_Jounce_L2.*1000)./f);
% jounceRLfft = jounceRLfft(1:n/2);
hold on
plot(f1,movmean(jounceFLfft,floor(filter*n/4))./mxF_fl);
% plot(f1,movmean(jounceRLfft,floor(filter*n/4))./mxF_fl);
title('Heave Front Axle [mm/mm]')
xlabel('Frequency [Hz]')
grid on
xlim([1 25])

figure(120)
jounceFLfft = abs(fft(aero_forces_height_rear.*1000)./f);
jounceFLfft = jounceFLfft(1:n/2);
% jounceRLfft = abs(fft(Suspension_Jounce_L2.*1000)./f);
% jounceRLfft = jounceRLfft(1:n/2);
hold on
plot(f1,movmean(jounceFLfft,floor(filter*n/4))./mxF_fl);
% plot(f1,movmean(jounceRLfft,floor(filter*n/4))./mxF_fl);
title('Heave Rear Axle [mm/mm]')
xlabel('Frequency [Hz]')
grid on
xlim([1 25])

%Find peaks
peak_fl = find(my_fl == max(my_fl));
flow_fl = f1(find(my_fl > 0.5.*my_fl(peak_fl),1));
fhigh_fl = f1(find(my_fl > 0.5.*my_fl(peak_fl),1,'last'));
disp('Front Left Natural Frequency [Hz]: ')
disp(f1(peak_fl))
disp(' ')
disp('Front Left Damping Ratio: ')
disp(f1(peak_fl)/(fhigh_fl-flow_fl))
disp(' ')

peak_fr = find(my_fr == max(my_fr));
flow_fr = f1(find(my_fr > 0.5.*my_fr(peak_fr),1));
fhigh_fr = f1(find(my_fr > 0.5.*my_fr(peak_fr),1,'last'));
disp('Front Right Natural Frequency [Hz]: ')
disp(f1(peak_fr))
disp(' ')
disp('Front Right Damping Ratio: ')
disp(f1(peak_fr)/(fhigh_fr-flow_fr))
disp(' ')

peak_rl = find(my_rl == max(my_rl));
flow_rl = f1(find(my_rl > 0.5.*my_rl(peak_rl),1));
fhigh_rl = f1(find(my_rl > 0.5.*my_rl(peak_rl),1,'last'));
disp('Rear Left Natural Frequency [Hz]: ')
disp(f1(peak_rl))
disp(' ')
disp('Rear Left Damping Ratio: ')
disp(f1(peak_rl)/(fhigh_rl-flow_rl))
disp(' ')

peak_rr = find(my_rr == max(my_rr));
flow_rr = f1(find(my_rr > 0.5.*my_rr(peak_rr),1));
fhigh_rr = f1(find(my_rr > 0.5.*my_rr(peak_rr),1,'last'));
disp('Rear Right Natural Frequency [Hz]: ')
disp(f1(peak_rr))
disp(' ')
disp('Rear Right Damping Ratio: ')
disp(f1(peak_rr)/(fhigh_rr-flow_rr))
disp(' ')

figure(3)
%subplot(2,1,1)
hold on
plot(f1,myF_fl./myF_rl)
grid on
xlim([1 25])
ylim([0.5 1.5])
title('Heave/Pitch Acceleration Coupling [Gain]')
xlabel('Frequency [Hz]')

figure(13)
heavefft = abs(fft(chassis_displacements_vertical.*1000)./f);
heavefft = heavefft(1:n/2);
hold on
plot(f1,movmean(heavefft,floor(filter*n/4))./mxF_fl)
grid on
xlim([1 25])
title('Heave response [mm/mm]')
xlabel('Frequency [Hz]')

pushForceGnd_FL = Spring_Force_At_Wheel_L1+Damper_Force_At_Wheel_L1;
pushForceGnd_RL = Spring_Force_At_Wheel_L2+Damper_Force_At_Wheel_L2;
pfgFLfft = abs(fft(pushForceGnd_FL)./f);
pfgRLfft = abs(fft(pushForceGnd_RL)./f);
pfgFLfft = pfgFLfft(1:n/2);
pfgRLfft = pfgRLfft(1:n/2);
figure(130)
plot(f1,movmean(pfgFLfft,floor(filter*n/4)))
hold on
plot(f1,movmean(pfgRLfft,floor(filter*n/4)))
grid on
xlim([1 25])
title('Push force at ground [N]')
xlabel('Frequency [Hz]')
legend('front 1','rear 1','front 2','rear 2')

%% More Plots
figure(1)
subplot(2,1,1)
hold off
plot(f1,mxF_fl)
hold on
plot(f1,mxF_rl)
%plot(f1,mxF_fr)
%plot(f1,mxF_rr)
title('Pad displacement [mm]')
grid on
xlim([1 25])
%ylim([0 4000])
legend('Front Left','Rear Left','Front Right','Rear Right')
xlabel('Frequency [Hz]')

subplot(2,1,2)
hold off
plot(f1,myF_fl)
hold on
plot(f1,myF_rl)
%plot(f1,myF_fr)
%plot(f1,myF_rr)
title('Acceleration response [g]')
grid on
xlim([1 25])
%ylim([0 (max(my_rl).*1.1)])
legend('Front Left','Rear Left','Front Right','Rear Right')
xlabel('Frequency [Hz]')

figure(2)
plot(f1,G_fl);
hold on
plot(f1,G_rl);
%plot(f1,G_fr);
%plot(f1,G_rr);
title('Frequency response [g/mm]')
grid on
xlim([1 25])
ylim([0 0.5])
legend('Front Left','Rear Left','Front Right','Rear Right')

figure(3)
%subplot(2,1,1)
hold on
plot(f1,myF_fl./myF_rl)
grid on
xlim([1 25])
ylim([0.5 1.5])
title('Heave/Pitch Acceleration Coupling [Gain]')
xlabel('Frequency [Hz]')
%subplot(2,1,2)
%plot(f1,angle

disp('Filter samples: ')
disp(floor(filter*n/4))
disp(' ')

%Find peaks
peak_fl = find(my_fl == max(my_fl));
flow_fl = f1(find(my_fl > 0.5.*my_fl(peak_fl),1));
fhigh_fl = f1(find(my_fl > 0.5.*my_fl(peak_fl),1,'last'));
disp('Front Left Natural Frequency [Hz]: ')
disp(f1(peak_fl))
disp(' ')
disp('Front Left Damping Ratio: ')
disp(f1(peak_fl)/(fhigh_fl-flow_fl))
disp(' ')

peak_fr = find(my_fr == max(my_fr));
flow_fr = f1(find(my_fr > 0.5.*my_fr(peak_fr),1));
fhigh_fr = f1(find(my_fr > 0.5.*my_fr(peak_fr),1,'last'));
disp('Front Right Natural Frequency [Hz]: ')
disp(f1(peak_fr))
disp(' ')
disp('Front Right Damping Ratio: ')
disp(f1(peak_fr)/(fhigh_fr-flow_fr))
disp(' ')

peak_rl = find(my_rl == max(my_rl));
flow_rl = f1(find(my_rl > 0.5.*my_rl(peak_rl),1));
fhigh_rl = f1(find(my_rl > 0.5.*my_rl(peak_rl),1,'last'));
disp('Rear Left Natural Frequency [Hz]: ')
disp(f1(peak_rl))
disp(' ')
disp('Rear Left Damping Ratio: ')
disp(f1(peak_rl)/(fhigh_rl-flow_rl))
disp(' ')

peak_rr = find(my_rr == max(my_rr));
flow_rr = f1(find(my_rr > 0.5.*my_rr(peak_rr),1));
fhigh_rr = f1(find(my_rr > 0.5.*my_rr(peak_rr),1,'last'));
disp('Rear Right Natural Frequency [Hz]: ')
disp(f1(peak_rr))
disp(' ')
disp('Rear Right Damping Ratio: ')
disp(f1(peak_rr)/(fhigh_rr-flow_rr))
disp(' ')

% Dampers velocity
figure(4)
hold off
plot(t,dal_ride_damper_data_velocity_front.*1000)
hold on
plot(t,dal_ride_damper_data_velocity_rear.*1000)
%plot(t,dar_ride_damper_data_velocity_front.*1000)
%plot(t,dar_ride_damper_data_velocity_rear.*1000)
xlabel('Time [s]')
title('Damper Velocity (positive extension) [mm/s]')
legend('Front Left','Rear Left','Front Right','Rear Right')
grid on

figure(5)
%%hold off
plot(t,(aero_forces_height_front-aero_forces_height_front(1)).*1000)
hold on
plot(t,(aero_forces_height_rear-aero_forces_height_rear(1)).*1000)
grid on
title('Ride height F/R [mm]')

figure(6)
hold on
plot(t,chassis_displacements_deg.*57.325);
title('Pitch [deg]')
xlabel('Time [s]')
grid on


figure(60)
hold on
plot(t,chassis_displacements_vertical.*1000);
title('Heave [mm]')
xlabel('Time [s]')
grid on

figure(7)
cpl_fl = abs(fft(til_wheel_tire_forces_normal_front)./f);
cpl_fl = cpl_fl(1:n/2);
% cpl_fr = abs(fft(tir_wheel_tire_forces_normal_front)./f);
% cpl_fr = cpl_fr(1:n/2);
cpl_rl = abs(fft(til_wheel_tire_forces_normal_rear)./f);
cpl_rl = cpl_rl(1:n/2);
% cpl_rr = abs(fft(tir_wheel_tire_forces_normal_rear)./f);
% cpl_rr = cpl_rr(1:n/2);
hold on
plot(f1,movmean(cpl_fl,floor(filter*n/4)));
% plot(f1,movmean(cpl_fr,floor(filter*n/4)));
plot(f1,movmean(cpl_rl,floor(filter*n/4)));
% plot(f1,movmean(cpl_rr,floor(filter*n/4)));
title('CPL vs Frequency [N]')
xlabel('Frequency [Hz]')
grid on
legend('FL','FR','RL','RR')
xlim([1 25])
ylim([0 2e3])

figure(3)
hold off
plot(t,nsl_ride_spring_data_displacement_front.*1000)
hold on
plot(t,nsl_ride_spring_data_displacement_rear.*1000)
%plot(t,nsr_ride_spring_data_displacement_front.*1000)
%plot(t,nsr_ride_spring_data_displacement_rear.*1000)
grid on
title('Spring displacement [mm]')
xlabel('Time [s]')
legend('Front Left','Rear Left','Front Right','Rear Right')

figure(9)
hold off
plot(t,dal_ride_damper_data_force_front)
hold on
plot(t,dal_ride_damper_data_force_rear)
%plot(t,dar_ride_damper_data_force_front)
%plot(t,dar_ride_damper_data_force_rear)
grid on
title('Damper force [N]')
xlabel('Time [s]')
legend('Front Left','Rear Left','Front Right','Rear Right')

figure(10)
hold on
plot(t,til_wheel_tire_forces_normal_front);
plot(t,til_wheel_tire_forces_normal_rear);
%plot(t,tir_wheel_tire_forces_normal_front);
%plot(t,tir_wheel_tire_forces_normal_rear);
title('CPL vs Time [N]')
xlabel('Time [s]')
grid on
legend('FL','FR','RL','RR')

figure(11)
pitchfft = abs(fft(chassis_displacements_pitch)./f);
pitchfft = pitchfft(1:n/2);
hold on
plot(f1,tan(movmean(pitchfft,floor(filter*n/4))).*2700);
title('Pitch response [mm/mm]')
xlabel('Time [s]')
grid on
xlim([1 25])

figure(12)
jounceFLfft = abs(fft(Suspension_Jounce_L1.*1000)./f);
jounceFLfft = jounceFLfft(1:n/2);
jounceRLfft = abs(fft(Suspension_Jounce_L2.*1000)./f);
jounceRLfft = jounceRLfft(1:n/2);
hold on
plot(f1,movmean(jounceFLfft,floor(filter*n/4)));
plot(f1,movmean(jounceRLfft,floor(filter*n/4)));
title('Jounce response [mm/mm]')
xlabel('Time [s]')
grid on
xlim([1 25])