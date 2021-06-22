%
% Daugianariu saknu iverciai 
% 

function main
clc, close all

% daugianario sudarymas: ------
roots=[ -1 ,0 ,2,  10];
% roots=[2 1]
% roots=[-5 2]
% roots=[-5 -3 -2 -1  1 2 3 4 6 7]

syms x f
f=1;
for i=1:numel(roots), f=f*(x-roots(i)); end
f           % daugianario israiska daugikliais 
f=expand(f)   % daugianario skleistine
fneig=expand(subs(f,x,-x))   % daugianario skleistine pakeitus x-> -x
n=numel(roots) % daugianario eile

[CF1,orders1]=coeffs(f,x) % daugianario f koeficientai ir juos atitinkantys x laipsniai
[CF1_neig,orders1_neig]=coeffs(fneig,x) % daugianario f neig koeficientai ir juos atitinkantys x laipsniai

% suformuojama visu x laipsniu eile: 
for i=1:n+1, orders(i)=x^(n-i+1); end
orders

% koeficientu eile papildoma nuliniais nariais:
for i=1:n+1
    j=find(orders1 == orders(i));
    if j>0, CF(i)=CF1(j); 
            CF_neig(i)=CF1_neig(j);
    else,   CF(i)=0;
            CF_neig(i)=0; 
    end
end

% koeficientas prie auksciausio x laipsnio turi buti teigiamas:
CF=CF/CF(1);  % f(x) koeficientai 
CF_neig=CF_neig/CF_neig(1);  % f(-x) koeficientai
CF,CF_neig

% Saknu intervalo iverciai:

% ------------- Grubus ivertis:
CF_value=eval(CF)  % f(x) koeficientu simboliai paverciami skaiciais
grubus_ivertis=max(abs(CF_value(2:end)))/CF_value(1)+1  % taikoma grubaus ivercio formule 

% grafinis funkcijos, saknu ir grubaus ivercio intervalo pavaizdavimas:
t=-grubus_ivertis:grubus_ivertis/500:grubus_ivertis;
figure(1);grid on;hold on
plot(t,fnk(CF_value,t),'g-')
plot(roots,0*roots,'go')
plot([-grubus_ivertis,grubus_ivertis],[0 0],'r*')

% ------------ Tikslesnis ivertis:
% teigiamoms saknims:
neig_ind=find(CF_value(2:end) < 0)
if ~isempty(neig_ind)
    k=min(neig_ind)
    B=max(abs(CF_value(neig_ind+1)))
    Rteig=1+(B/CF_value(1))^(1/k)
else
    Rteig=0
end
plot(Rteig,0,'bp') % pavaizduojamas teigiamu saknu virsutines ribos ivertis 

% neigiamoms saknims: 
CF_value_neig=eval(CF_neig)  % f(-x) koeficientu simboliai paverciami skaiciais
neig_ind1=find(CF_value_neig(2:end) < 0)
if ~isempty(neig_ind1)
    k=min(neig_ind1)
    B=max(abs(CF_value_neig(neig_ind1+1)))
    Rneig=1+(B/CF_value_neig(1))^(1/k)
else
    Rneig=0
end

plot(-Rneig,0,'bp')
legend('kreive f(x)','f(x)=0 saknys','grubus saknu intervalo ivertis','tikslesnis saknu intervalo ivertis')

end

function p=fnk(CF,x)
% Apskaiciuojamos daugianario reiksmes, kai argumentas yra x
% Kai x yra reiksmiu vektorius, p taip pat yra atitinkamu funkcijos reiksmiu vektorius
    p=0; n=length(CF)-1;
    for i=1:length(CF),  p=p+CF(i)*x.^(n-i+1);  end
return
end