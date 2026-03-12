import numpy as np
#Max number of exponent for 2,3 and 5
n2=15
n3=9
n5=7
val=np.zeros([n2*n3*n5+3])
index=0
for i in range(n2):
  for j in range(n3):
    for k in range(n5):
      val[index]=(2**i)*(3**j)*(5**k)
      index=index+1
val.sort()
np.set_printoptions(formatter={'float': '{: 5.0f}'.format})
print(val)
