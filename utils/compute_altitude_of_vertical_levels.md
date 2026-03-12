## Compute altitude of vertical levels
  
```python
# -*- coding: utf-8 -*-

KMAX=120 #nb levels
ZMAX=5000 #ZMAX_STRGRD
ZGRD=10 # mesh size at the ground ZGRD
ZTOP=300 # Mesh size at the top ZTOP
SGRD=4 # low level stretching SGRD
STOP=5 # top level stretching STOP

RZ=[0 for i in range(1,KMAX+1)]
RZ[1]=0.
RZ[2]=ZGRD

for i in range(2,KMAX-1):
  if RZ[i]<= ZMAX:
    RZ[i+1]=RZ[i] +(RZ[i]-RZ[i-1])* (1+SGRD/100)
  else:
    RZ[i+1]=RZ[i] +(RZ[i]-RZ[i-1])* (1+STOP/100)

  if (RZ[i+1]-RZ[i]) >=ZTOP:
    RZ[i+1]=RZ[i]+ZTOP

 print(RZ)
```
