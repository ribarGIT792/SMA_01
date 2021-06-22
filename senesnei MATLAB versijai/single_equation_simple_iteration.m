%
% Vienos lygties sprendimas: paprastuju iteraciju metodas
% 

function main
clc
close all

% range=[-10,10];
range=[-2,1];
x0=-1.3
eps=1e-9;
method='simple_iteration';

% braizomas funkcijos grafikas
npoints=1000
x=range(1): (range(2)-range(1))/(npoints-1) :range(2);  fff=f(x);
figure(1); grid on; hold on; axis equal;
plot(x,fff+x,'r-');
plot(range,range,'b-');

% lygties sprendimas
xn=x0;prec=1;
nit=0;nitmax=100;
while prec > eps 
    nit=nit+1;
    if nit > nitmax, fprintf('Virsytas leistinas iteraciju skaicius');break;end

    if strcmp(method,'simple_iteration')
            fn=f(xn)+xn;
            plot([xn,xn,fn],[xn,fn,fn],'g-');
            plot(xn,fn,'mp');
            xn=fn;
    else, fprintf('neaprasytas metodas \n');
    end
     
        pause(1)
        
    prec=abs(f(xn));
    fprintf(1,'iteracija %d  x= %g  prec= %g \n',nit,xn,prec);
end
plot(xn,fn,'k*');plot(xn,fn,'ko');
xn
nit


% approx=fsolve(@f,-10)
end


function value=f(x)
% value=0.5*x.^2-1;
value=1.5*x.^2-1;
return
end