
# 
# Lygties sprendimas funkcija aproksimuojant Teiloro eilute 
# 
import numpy as np
import math
import sympy

x,f,fp,df=sympy.symbols(('x','f','fp','df'))

f=x*sympy.sin(x)  # funkcijos israiska simboliais
x0=0    # pradinis artinys, TE pradinis taskas
N=31  # iki kokios eiles naudoti TE narius    
  
fp=f.subs(x,x0)          # pirmas TE narys 

for i in range (1,N+1):  # TE aproksimavimo ciklas
    f=f.diff(x)         # analizinis diferencijavimas
    fp=fp+f.subs(x,x0)/math.factorial(i)*(x-x0)**i;  # TE suma 

a=sympy.Poly(fp,x) # daugianaris simboliais
kf=np.array(a.all_coeffs()) # visi koeficientai nuo vyriausio
saknys=np.roots(kf)
print(saknys)

