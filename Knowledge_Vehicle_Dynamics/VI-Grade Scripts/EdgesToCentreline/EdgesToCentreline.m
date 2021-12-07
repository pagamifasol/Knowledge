close all
clear
clc
load LandR_Portimao.mat

% Cut first point (origin of track)
Lxcoord = Lxcoord(2:end);
Lycoord = Lycoord(2:end);
Lzcoord = Lzcoord(2:end);
Rxcoord = Rxcoord(2:end);
Rycoord = Rycoord(2:end);
Rzcoord = Rzcoord(2:end);

% Put end of track in the first point
Lxcoord(end+1) = Lxcoord(1);
Lycoord(end+1) = Lycoord(1);
Lzcoord(end+1) = Lzcoord(1);
Rxcoord(end+1) = Rxcoord(1);
Rycoord(end+1) = Rycoord(1);
Rzcoord(end+1) = Rzcoord(1);

STEP = 1; %m - step of output

% Left path S
SL = zeros(length(Lxcoord),1);
for i=2:length(Lxcoord)
    SL(i) = SL(i-1) + sqrt((Lxcoord(i)-Lxcoord(i-1)).^2+(Lycoord(i)-Lycoord(i-1)).^2);
end

% Right path S
SR = zeros(length(Rxcoord),1);
for i=2:length(Rxcoord)
    SR(i) = SR(i-1) + sqrt((Rxcoord(i)-Rxcoord(i-1)).^2+(Rycoord(i)-Rycoord(i-1)).^2);
end

% Resample to step size
SR1 = (0:STEP:SR(end))';
SL1 = (0:STEP:SL(end))';

xL = interp1(SL,Lxcoord,SL1);
yL = interp1(SL,Lycoord,SL1);
zL = interp1(SL,Lzcoord,SL1);
xR = interp1(SR,Rxcoord,SR1);
yR = interp1(SR,Rycoord,SR1);
zR = interp1(SR,Rzcoord,SR1);

% Find centerline
%find closest point
nearestR = zeros(length(xL),1);
W = zeros(length(xL),1);
xM = zeros(length(xL),1);
yM = zeros(length(xL),1);
zM = zeros(length(xL),1);
B = zeros(length(xL),1);

for i=1:length(xL)
    dist = 1e6;
    for k=1:length(xR)
        dist1 = sqrt((xL(i)-xR(k)).^2 + (yL(i)-yR(k)).^2);
        if dist1 < dist
            dist = dist1;
            nearestR(i) = k;
        end
    end
    W(i) = dist;
    xM(i) = (xL(i) + xR(nearestR(i)))./2;
    yM(i) = (yL(i) + yR(nearestR(i)))./2;
    zM(i) = (zL(i) + zR(nearestR(i)))./2;
    B(i) = atan(zL(i) - zR(nearestR(i)))./W(i);
end

S = zeros(length(xM),1);
for i=2:length(xM)
    S(i) = S(i-1) + sqrt((xM(i)-xM(i-1)).^2+(yM(i)-yM(i-1)).^2);
end

% Output for vigrade measured track
Wout = [S W];
Mout = [xM yM zM B];

% Plots
figure
plot(xL,yL)
hold on
plot(xR,yR)
plot(xM,yM)
title('Plant view')

figure
plot(S,W)
title('Track width [m]')

figure
plot(S,zM)
title('Altitude [m]')

figure
plot(S,B.*57.325)
title('Banking [deg]')
