import numpy as np

name = 'Artega_CL085'

number = ''

#moving average function
def moving_average(a, n) :
        ret = []

        for i in range(0,n) :
                ret.append(float(a[i]))

        for i in range(n,len(a)-n+1) :
                ret.append( float(np.sum(a[i-n:i+n]) / (2*n + 1)) )

        for i in range(len(a)-n+1,len(a)) :
                ret.append(float(a[i]))
        
        return ret


#load vi-animator csv
print('Loading source file..')
source = np.loadtxt('' + name + number + '.csv',delimiter=',',skiprows=1)

print('File loaded. Begin data filtering..')

sourceT = source.transpose()

#Filter data
HUB_Fx_FL = moving_average(sourceT[359],20)
HUB_Fx_RL = moving_average(sourceT[360],20)
HUB_Fx_FR = moving_average(sourceT[361],20)
HUB_Fx_RR = moving_average(sourceT[362],20)

HUB_Fy_FL = moving_average(sourceT[363],20)
HUB_Fy_RL = moving_average(sourceT[364],20)
HUB_Fy_FR = moving_average(sourceT[365],20)
HUB_Fy_RR = moving_average(sourceT[366],20)

HUB_Fz_FL = moving_average(sourceT[367],20)
HUB_Fz_RL = moving_average(sourceT[368],20)
HUB_Fz_FR = moving_average(sourceT[369],20)
HUB_Fz_RR = moving_average(sourceT[370],20)

HUB_Mx_FL = moving_average(sourceT[384],20)
HUB_Mx_RL = moving_average(sourceT[385],20)
HUB_Mx_FR = moving_average(sourceT[386],20)
HUB_Mx_RR = moving_average(sourceT[387],20)

HUB_My_FL = moving_average(sourceT[387],20)
HUB_My_RL = moving_average(sourceT[388],20)
HUB_My_FR = moving_average(sourceT[389],20)
HUB_My_RR = moving_average(sourceT[390],20)

HUB_Mz_FL = moving_average(sourceT[391],20)
HUB_Mz_RL = moving_average(sourceT[392],20)
HUB_Mz_FR = moving_average(sourceT[393],20)
HUB_Mz_RR = moving_average(sourceT[394],20)

Susp_Jounce_FL = moving_average(sourceT[200] * -1000,20)
Susp_Jounce_RL = moving_average(sourceT[201] * -1000,20)
Susp_Jounce_FR = moving_average(sourceT[202] * -1000,20)
Susp_Jounce_RR = moving_average(sourceT[203] * -1000,20)

Steer_FL = moving_average(sourceT[625] * 57.325,20)
Steer_FR = moving_average(sourceT[627] * 57.325,20)

print('Done. Begin target assemling..')

#create target array
target = np.vstack((sourceT[0],sourceT[1],sourceT[2],sourceT[4],sourceT[5],sourceT[6],sourceT[7],sourceT[117],sourceT[118],sourceT[119],sourceT[121],sourceT[123],sourceT[132],sourceT[829],sourceT[911]))

target = np.vstack((target, HUB_Fx_FL, HUB_Fx_RL, HUB_Fx_FR, HUB_Fx_RR)) #Wheel hub Fx (FL,RL,FR,RR)
target = np.vstack((target, HUB_Fy_FL, HUB_Fy_RL, HUB_Fy_FR, HUB_Fy_RR)) #Wheel hub Fy (FL,RL,FR,RR)
target = np.vstack((target, HUB_Fz_FL, HUB_Fz_RL, HUB_Fz_FR, HUB_Fz_RR)) #Wheel hub Fz (FL,RL,FR,RR)

target = np.vstack((target, HUB_Mx_FL, HUB_Mx_RL, HUB_Mx_FR, HUB_Mx_RR)) #Wheel hub Mx (FL,RL,FR,RR)
target = np.vstack((target, HUB_My_FL, HUB_My_RL, HUB_My_FR, HUB_My_RR)) #Wheel hub My (FL,RL,FR,RR)
target = np.vstack((target, HUB_Mz_FL, HUB_Mz_RL, HUB_Mz_FR, HUB_Mz_RR)) #Wheel hub Mz (FL,RL,FR,RR)

target = np.vstack((target,Susp_Jounce_FL,Susp_Jounce_RL,Susp_Jounce_FR,Susp_Jounce_RR))

target = np.vstack((target,Steer_FL,Steer_FR))


#Gains
target[8]  = target[8] * 57.325   #gyrx
target[9]  = target[9] * 57.325   #gyry
target[13] = target[13] * 57.325  #gyry

target[10] = target[10] / 9.81 #accx
target[11] = target[11] / 9.81 #accy
target[12] = target[12] / 9.81 #accz

targetT = target.transpose()

print('Done. Begin data export..')
#Export data
np.savetxt('' + name + number + '_readyForWinDarab.txt',targetT,delimiter=' ',header='xtime[s] crt_Speed[kph] crt_nmot[rpm] Brake_Moment_L1[Nm] Brake_Moment_L2[Nm] Brake_Moment_R1[Nm] Brake_Moment_R2[Nm] crt_gyrx[deg/s] crt_gyry[deg/s] crt_accx[g] crt_accy[g] crt_accz[g] crt_gyrz[deg/s] crt_gear crt_singleMotPowerToWheels_eta09[kW] HUB_Fx_FL[N] HUB_Fx_RL[N] HUB_Fx_FR[N] HUB_Fx_RR[N] HUB_Fy_FL[N] HUB_Fy_RL[N] HUB_Fy_FR[N] HUB_Fy_RR[N] HUB_Fz_FL[N] HUB_Fz_RL[N] HUB_Fz_FR[N] HUB_Fz_RR[N] HUB_Mx_FL[Nm] HUB_Mx_RL[Nm] HUB_Mx_FR[Nm] HUB_Mx_RR[Nm] HUB_My_FL[Nm] HUB_My_RL[Nm] HUB_My_FR[Nm] HUB_My_RR[Nm] HUB_Mz_FL[Nm] HUB_Mz_RL[Nm] HUB_Mz_FR[Nm] HUB_Mz_RR[Nm] Susp_Travel_FL[mm] Susp_Travel_RL[mm] Susp_Travel_FR[mm] Susp_Travel_RR[mm] Steer_FL[deg] Steer_FR[deg]',comments='')

print('Conversion complete!')

