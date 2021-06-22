% 
% Teiloro eilutes paaiskinimas
% 
function Teiloro_eilutes_paaiskinimas
clc, close all, clear all


syms x f fT deltax
% parenkame funkcija ir taska, kurio aplinkoje funkcija aproksimuojama Teiloro eilute
f=sin(x),x0=0;
fT=f
for i=1:3    % aproksimacijos eiles ciklas
    f=diff(f);  % analizinis veiksmas: funkcija diferencijuojama
    fT=fT+deltax^i*f/factorial(i);
end
fT=vpa(eval(subs(fT,x,x0)),3)
end


