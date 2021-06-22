


%
% Funkciju grafinis pavaizdavimas (ankstesnes MATLAB versijos)
% 

function main
clc, close all
syms x f

roots=[ -1 ,0 ,2,  10];
% roots=[2 1]
% roots=[-5 2]
roots=[-5 -3 -2 -1  1 2 3 4 6 7]
f=1;
for i=1:numel(roots), f=f*(x-roots(i)); end
f=expand(f)           % daugianario israiska daugikliais 


% f='sin(x).*(x.^2-1).*(x+3)-0.9'

xmin=-10; xmax=10; nst=1000;
xrange=[xmin :(xmax-xmin)/nst : xmax];
figure(1);grid on;hold on

plot(xrange,eval(subs(f,x,sym(xrange))),'b-')

end
