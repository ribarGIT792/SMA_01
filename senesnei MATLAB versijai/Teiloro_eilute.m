
% Teiloro eilutes esmes paaiskinimas
clc, close all, clear all

sss={'k','ko','b-','r-','g-','m-','c-'}
syms x f fp fpc

f=x.*sin(x)
% fp=10*x^10+5*x^3-2*x^2+x-5


figure(1);hold on;grid on;
xrange=[-24:0.1:24];
f0=eval(subs(f,x,sym(xrange))); 
plot(xrange,f0,sss{1},'LineWidth',2);
axis([min(xrange) max(xrange) min(f0) max(f0)])

x0=-10; % taskas, kurio aplinkoje skleidziama
f0=eval(subs(f,x,sym(x0)));
plot(x0,f0,sss{2});
haprox=plot(xrange,f0*ones(1,length(xrange)),'b-');  % nulines eiles artinys (pastovi reiksme)
title(['f(x)=',char(fp)])
leg={'duota funkcija','taskas','1 TE narys'};
hleg=legend(leg);

N=50;

for i=1:N
    f=diff(f)
    f1=eval(subs(f,x,sym(x0)))
    f0=f0+((xrange-x0)).^i./factorial(i).*f1;
    if i+3 > length(sss), sss=[sss,sss(4:end)]; end
    if 1,delete(haprox);haprox=plot(xrange,f0,sss{4});  %i+1 TE nariu artinys
        leg={leg{1:2},sprintf('%d TE nariai',i+1)};
        hleg=legend(leg);
    else, haprox=plot(xrange,f0,sss{i+3}); 
        leg={leg,sprintf('%d TE nariai',i+1)};delete(hleg);hleg=legend(leg);
    end
   pause
   figure(1)
end


    
    
    