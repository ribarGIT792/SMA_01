%
% Vienos lygties sprendimas: paprastuju iteraciju metodas
% 

function main
clc, close all

syms f x 


f=(0.5*x.^2-1)*1

% f=atan(x)
% f=-0.5*x

x0=-1.8;
deltax=0.01;
if x0 ~= 0, range=3*[-abs(x0),abs(x0)];
else, range=[-3,0];
end

eps=1e-9;
method='simple iterations';alpha=1;
% method='Newton';alpha=1;
% method='secants';

if strcmp(method,'Newton'),df=diff(f,x), end

% braizomas funkcijos grafikas
npoints=1000

xrange=range(1): (range(2)-range(1))/(npoints-1) :range(2);  
figure(1); grid on; hold on; axis equal;
str=[char(f),'=0;   Method of ',method];title(str);
if strcmp(method,'simple iterations'),plot(xrange,eval(subs(f+alpha*x,x,sym(xrange))),'r-');plot(range,range,'b-');plot(x0,x0,'mp');h = findobj(gca,'Type','line');h1=h(1);
elseif strcmp(method,'Newton') || strcmp(method,'secants'),plot(xrange,eval(subs(f,x,sym(xrange))),'r-');plot(range,[0 0],'b-');plot(x0,0,'mp');h = findobj(gca,'Type','line');h1=h(1);
else, fprintf('neaprasytas metodas \n'); 
end

        input('Press Enter'), figure(1);

% lygties sprendimas
xn=x0;prec=1;
if strcmp(method,'secants'), fxn=eval(subs(f,x,sym(xn)));fxn_1=eval(subs(f,x,sym(xn+deltax)));dfxn=(fxn_1-fxn)/deltax, end
nit=0;nitmax=100;
while prec > eps 
    nit=nit+1;
    if nit > nitmax, fprintf('Virsytas leistinas iteraciju skaicius');break;end

    if strcmp(method,'simple iterations')
            fxn=eval(subs(f,x,sym(xn)));
            fn=fxn+alpha*xn;
            plot([xn,xn,fn],[xn,fn,fn],'g-');
            xn=fn/alpha;
            delete(h1);plot(xn,xn,'mp');h = findobj(gca,'Type','line');h1=h(1);
       elseif strcmp(method,'Newton') 
            fxn=eval(subs(f,x,sym(xn)));dfxn=eval(subs(df,x,sym(xn)));
            xn1=xn-alpha*fxn/dfxn;   % galima daugikliu alpha apriboti x prieaugi, tikintis
                                     % geresnio konvergavimo   
            plot([xn,xn,xn1],[0,fxn,0],'g-');
            delete(h1);plot(xn1,0,'mp');h = findobj(gca,'Type','line');h1=h(1);
            xn=xn1;
        elseif strcmp(method,'secants') 
            xn1=xn-fxn/dfxn;   
            plot([xn,xn,xn1],[0,fxn,0],'g-');
            delete(h1);plot(xn1,0,'mp');h = findobj(gca,'Type','line');h1=h(1);
            fxn1=eval(subs(f,x,sym(xn1)));dfxn=(fxn1-fxn)/(xn1-xn);
            xn=xn1;
            fxn=fxn1;
        else, fprintf('neaprasytas metodas \n');
        end
     
%         pause(1)
        input('Press Enter'), figure(1);
        
    fxn=eval(subs(f,x,sym(xn)));prec=abs(fxn);
    fprintf(1,'iteracija %d  x= %g  prec= %g \n',nit,xn,prec);
end
plot(xn,fxn,'k*');plot(xn,fxn,'ko');
xn
nit

end


