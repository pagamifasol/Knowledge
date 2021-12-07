import numpy as np

name = 'R100_tv'

number = ''

#load vi-animator csv
source = np.loadtxt('' + name + number + '.csv',delimiter=',',skiprows=1)

sourceT = source.transpose()

#create target array
target = np.vstack((sourceT[0],sourceT[1],sourceT[2],sourceT[4],sourceT[5],sourceT[6],sourceT[7],sourceT[117],sourceT[118],sourceT[119],sourceT[121],sourceT[123],sourceT[132],sourceT[829],sourceT[523],sourceT[524],sourceT[525],sourceT[526],sourceT[493],sourceT[494],sourceT[830]))

targetT = target.transpose()

np.savetxt('' + name + number + '_readyForImport.csv',targetT,delimiter=',',header='crt_Time,crt_Speed,crt_nmot,Brake_Moment_L1,Brake_Moment_L2,Brake_Moment_R1,Brake_Moment_R2,crt_gyrx,crt_gyry,crt_accx,crt_accy,crt_accz,crt_gyrz,crt_gear,crt_TrqFL,crt_TrqRL,crt_TrqFR,crt_TrqRR,crt_Beta,crt_Kundersteer,crt_driverSteering',comments='')
