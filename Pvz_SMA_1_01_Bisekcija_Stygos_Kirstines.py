

import numpy as np
#from tkinter import *
import matplotlib.pyplot as plt
from PyFunkcijos import *

#-------- Lygties funkcija---------
def LF(x): s= x**2/10-2+3*np.sin(x); return s
#----------------------------------

#
#*******************  Programa ************************************ 
# 
delay=0.5           # pauses ilgumas grafiniam vaizdavimui
eps=1e-6            # reikalaujamas tikslumas
xrange = [-10,10]   # LF grafiko vaizdavimo sritis
x1=-10  ;   x2=5    # atskyrimo intervalas arba du artiniai   
maxiter=30          # didziausias leistinas iteraciju skaicius
metodas="Bisekcijos"  # pasirinkti metoda
#metodas="Stygu"
#metodas="Kirstiniu"
T=ScrollTextBox(140,20) # sukurti teksto isvedimo langa
T.insert(END,"--------  "+metodas+" metodas -------------\n")

f1=LF(x1); f2=LF(x2);  # funkcijos reiksmes saknu intervalo galuose arba artiniuose

# Grafika: -------------------------------------------------------------------------------------------------
X=np.linspace(xrange[0],xrange[1],500) # funkcijos vaizdavimo taskai
fig=plt.figure();ax=fig.add_subplot(1, 1, 1);ax.set_xlabel('x');ax.set_ylabel('y')
c1,=ax.plot(X,LF(X),'b');
c2,=ax.plot(xrange,[0,0],'k.--');plt.draw();plt.pause(delay)
m1,=ax.plot([x1,x1],[0,f1],'mo--');plt.draw(); m2,=ax.plot([x2,x2],[0,f2],'co--');plt.draw();
if metodas == "Stygu" : st,=ax.plot([x1,x2],[f1,f2],'k.-.'); # punktyru jungiami funkcijos reiksmiu taskai 
if metodas == "Kirstiniu" : st,=ax.plot([x2,x1],[f2,f1],'k.-.');
plt.draw();plt.pause(delay)
#-----------------------------------------------------------------------------------------------------------

T.insert(END,"Saknies reiksmes tikslinimas "+metodas+" metodu:  \n")

for i in range (1,maxiter+1) :  # saknies tikslinimo iteracijos

    if metodas == "Bisekcijos" : xmid=(x1+x2)/2;   # intervalo vidurys
    elif metodas == "Stygu" : k=np.abs(f1/f2); xmid=(x1+k*x2)/(1+k);  # stygos nulio taskas
    elif  metodas == "Kirstiniu" :  xmid=x1-(x1-x2)/(f1-f2)*f1;  # kvazi-liestines nulio taskas
    fmid=LF(xmid); 
    
    # Grafika: --------------------------------------------------------------------------
    mmid,=ax.plot([xmid,xmid],[0,fmid],'ks--');
    if metodas == "Stygu" : st.remove(); 
    if metodas == "Kirstiniu" : st.remove();st,=ax.plot([x2,x1,xmid],[f2,f1,0],'k.-.');
    plt.draw();plt.pause(delay)
    #------------------------------------------------------------------------------------

    if metodas == "Stygu" or  metodas == "Bisekcijos":
        if np.sign(f1) != np.sign(fmid): x2=xmid; f2=fmid;
        else:  x1=xmid; f1=fmid; 
    if metodas == "Kirstiniu":  x2=x1; f2=f1;x1=xmid;f1=fmid;               
    
    # Grafika: ------------------------------------------------------------------------------------------------------------------------------
    if metodas == "Stygu" or  metodas == "Bisekcijos":
        if np.sign(f1) != np.sign(fmid): m2.remove();mmid.remove();m2,=ax.plot([x2,x2],[0,f2],'co--');
        else: m1.remove();mmid.remove();m1,=ax.plot([x1,x1],[0,f1],'mo--');
    if metodas == "Stygu" : st,=ax.plot([x1,x2],[f1,f2],'k.-.');
    if metodas == "Kirstiniu": mmid.remove(); m1.remove();m2.remove();m1,=ax.plot([x1,x1],[0,f1],'mo--'); m2,=ax.plot([x2,x2],[0,f2],'co--');
    plt.draw();plt.pause(delay)
    # ---------------------------------------------------------------------------------------------------------------------------------------
    tksl=tikslumas(x1,x2,f1,f2,eps)
    str="%2d.   x1= %-20g   x2= %-20g  f1= %-20g   f2= %-20g  tikslumas= %-20g" % (i,x1,x2,f1,f2,tksl)
    T.insert(END,str+"\n");   T.yview(END)  
    if tksl < eps:  str="\nIsspresta: x=  %-25g  f=   %-25g   tikslumas=%-25g\n" % (x1,f1,tksl);break
    elif i == maxiter :   str="\nTikslumas nepasiektas"

T.insert(END,str+"\n");T.yview(END)  

str1=input("Baigti darba? Press 'Y' \n")
