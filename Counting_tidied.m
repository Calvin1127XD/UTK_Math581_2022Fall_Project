clc
clear all
E0=0;
L1=0;
L2=0;
L12=0;
B=0;

epsilon=0.00000001;
Etime=10000;
stroke=0;
fprintf('Progress: [                    ]\n')
stroke=0;
for jj=1:Etime
    if jj>=(stroke+1)*Etime/20;
        stroke=stroke+1;
        str='';
        for jjj=1:stroke
            str=[str '-'];
        end
        for jjj=1:20-stroke
            str=[str ' '];
        end
        clc
        str=['Progress: [' str ']\n'];
        fprintf(str);
    end
phi=99.9*rand(1)+0.1;
mu1=99.9*rand(1)+0.1;
mu2=99.9*rand(1)+0.1;
S0=4995*rand(1)+5;
S1=99.9*rand(1)+0.1;
S2=99.9*rand(1)+0.1;
K10=99.9*rand(1)+0.1;
K12=99.9*rand(1)+0.1;
K20=99.9*rand(1)+0.1;
K21=99.9*rand(1)+0.1;
v01=99.9*rand(1)+0.1;
v02=99.9*rand(1)+0.1;
v11=99.9*rand(1)+0.1;
v12=99.9*rand(1)+0.1;
v21=99.9*rand(1)+0.1;
v22=99.9*rand(1)+0.1;
%We introduce the duration of the simulation.
T=15000;

E0i=0;
L1i=0;
L2i=0;
L12i=0;

inner=0;
needinner=25;

x1v=zeros(1,needinner);
x2v=zeros(1,needinner);

while inner<needinner
%We introduce the initial variable here.
x_1=99.9*rand(1)+0.1;
x_2=99.9*rand(1)+0.1;
s_0=4995*rand(1)+5;
s_1=99.9*rand(1)+0.1;
s_2=99.9*rand(1)+0.1;
%Creating array to store the function value
x_1a=[x_1 zeros(1,T)];
x_2a=[x_2 zeros(1,T)];
s_0a=[s_0 zeros(1,T)];
s_1a=[s_1 zeros(1,T)];
s_2a=[s_2 zeros(1,T)];
%Defining the function

%Iteration
h=0.005; %this is step size
for i=1:T
    currentvalue=[x_1a(i) x_2a(i) s_0a(i) s_1a(i) s_2a(i)];
    p=currentvalue(1);
    q=currentvalue(2);
    r=currentvalue(3);
    s=currentvalue(4);
    t=currentvalue(5);


    ef1=mu1*(r/(K10+r)*t/(K12+t));
    ef2=mu2*(r/(K20+r)*s/(K21+s));

F1=(ef1-phi)*p;
F2=(ef2-phi)*q;
F3=(phi*(S0-r)-v01*ef1*p-v02*ef2*q);
F4=(phi*(S1-s)+v11*ef1*p-v12*ef2*q);
F5=(phi*(S2-t)-v21*ef1*p+v22*ef2*q);

edf1=mu1*K10/(K10+S0)^2*S2/(K12+S2)+mu1*S0/(K10+S0)*K12/(K12+S2)^2;
edf2=mu2*K20/(K20+S0)^2*S1/(K21+S1)+mu2*S0/(K20+S0)*K21/(K21+S1)^2;

DF1=(ef1-phi)*F1+p*edf1;
DF2=(ef2-phi)*F2+q*edf2;
DF3=-phi*F3-v01*(ef1*F1+p*edf1)-v02*(ef2*F2+q*edf2);
DF4=-phi*F4+v11*(ef1*F1+p*edf1)-v12*(ef2*F2+q*edf2);
DF5=-phi*F5-v21*(ef1*F1+p*edf1)+v22*(ef2*F2+q*edf2);


    newx_1=max(p+h*F1+h^2/2*DF1,0);
    newx_2=max(q+h*F2+h^2/2*DF2,0);
    news_0=max(r+h*F3+h^2/2*DF3,0);
    news_1=max(s+h*F4+h^2/2*DF4,0);
    news_2=max(t+h*F5+h^2/2*DF5,0);

    x_1a(i+1)=newx_1;
    x_2a(i+1)=newx_2;
    s_0a(i+1)=news_0;
    s_1a(i+1)=news_1;
    s_2a(i+1)=news_2;


end



inner=inner+1;
x1v(inner)=newx_1;
x2v(inner)=newx_2;

if (newx_1<=epsilon)&&(newx_2<=epsilon)
    E0i=E0i+1;
end
if (newx_1>=epsilon)&&(newx_2<=epsilon)
    L1i=L1i+1;
end
if (newx_1<=epsilon)&&(newx_2>=epsilon)
    L2i=L2i+1;
end
if (newx_1>=epsilon)&&(newx_2>=epsilon)
    L12i=L12i+1;
end


end

canskip=0;

for m=1:needinner-1
    if sqrt((x1v(m)-x1v(m+1))^2+(x2v(m)-x2v(m+1))^2)>epsilon
        B=B+1;
        canskip=1;
        break;
    end
end


if canskip==1
    continue;
end

v=[E0i L1i L2i L12i];
v=sort(v);

    if E0i==max(v)
        E0=E0+1;
    end
    if L1i==max(v)
        L1=L1+1;
    end
    if L2i==max(v)
        L2=L2+1;
    end
    if L12i==max(v)
        L12=L12+1;
    end
end
