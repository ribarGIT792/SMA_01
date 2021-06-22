%
% Vienos lygties sprendimas: atkarpos dalijimo pusiau metodas 
%                            stygu metodas
% 

function main
clc,close all

syms f x
% f=2*x.*cos(2*x)-(x+1).^2;
f=-2*x.^2+2;

% range=[-10,10]
% range=[-2.5,-1.8];
range=[-2.5,5];
eps=1e-9;
method='bisection';
% method='chords';

% braizomas funkcijos grafikas
npoints=1000
xrange=range(1): (range(2)-range(1))/(npoints-1) :range(2);  
figure(1); grid on; hold on;
str=[char(f),'=0;   Method of ',method]; title(str);
plot(xrange,eval(subs(f,x,sym(xrange))),'r-');
plot(range,[0 0],'b-');


% lygties sprendimas
xn=range(1);xn1=range(2);prec=1;
nit=0;
while prec > eps
    nit=nit+1;
    plot(xn,0,'mp');h = findobj(gca,'Type','line');h1=h(1); % paskutinis objektas visuomet irasomas handle masyvo priekyje
    plot(xn1,0,'cp');h = findobj(gca,'Type','line');h2=h(1);

        if strcmp(method,'bisection')  
            xmid=(xn+xn1)/2;plot(xmid,0,'gs');h = findobj(gca,'Type','line');h3=h(1);
       elseif strcmp(method,'chords') 
            x=xn;fxn=eval(f);
            x=xn1;fxn1=eval(f);
            k=abs(fxn/fxn1);xmid=(xn+k*xn1)/(1+k);
            plot(xmid,0,'gs');plot([xn,xn1],[fxn,fxn1],'g-');h = findobj(gca,'Type','line');h3=h(1:2);
        else, fprintf('neaprasytas metodas \n');
        end
    x=xmid;fxmid=eval(f);
    x=xn;fxn=eval(f);
    if sign(fxmid) == sign(fxn), xn=xmid;
    else, xn1=xmid;
    end
        
    pause(1)
    delete(h1);delete(h2);delete(h3);
    
    prec=abs(fxmid);
    fprintf(1,'iteracija %d    tikslumas= %g \n',nit,prec);
end
plot(xmid,0,'k*');plot(xmid,0,'ko');
xmid
nit

% approx=fsolve(@f,-10)
end


% function value=f(x)
% % value=2*x.*cos(2*x)-(x+1).^2;
% value=-2*x.^2+2;
% return
% end