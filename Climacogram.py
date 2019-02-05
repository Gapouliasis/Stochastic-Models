import numpy as np
import matplotlib.pyplot as plt
Tseries=np.loadtxt('testdata.txt')
nk=round(Tseries.shape[0]/10)
k=np.arange(1,nk+1)
sk=np.zeros((nk,1))
for i in range(1,nk+1):
    e=int(np.fix(Tseries.shape[0]/i))
    temp=np.zeros((e,1))
    for j in range(1,e+1):
        temp[j-1]=np.mean(Tseries[(j-1)*i:j*i])
    sk[i-1]=np.std(temp)
lnk=np.transpose(np.log(k))
lnsk=np.log(sk)
coeffvals = np.polyfit(lnk,lnsk[:,0],1)
H=1-abs(coeffvals[0])
f=np.poly1d(coeffvals)
plt.scatter(lnk,lnsk)
plt.plot(lnk,f(lnk),'g')
a=str(H)
plt.text(lnk[2],f(lnk[2]),a)
plt.show()
