clc
clear all
E0=0;
L1=0;
L2=0;
L12=0;
B=0;

%Global parameter
global phi mu1 mu2 S0 S1 S2 K10 K12 K20 K21 v01 v02 v11 v12 v21 v22

epsilon=0.00000001;
Etime=20;
cou=Etime/20;
stroke=0;
fprintf('Progress: [                    ]\n')
stroke=0;
%We introduce the duration of the simulation.
T=500;
for jj=1:Etime
    cou=cou-1;
    if cou==0;
        stroke=stroke+1;
        cou=Etime/20;
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

E0i=0;
L1i=0;
L2i=0;
L12i=0;

inner=0;
needinner=10;
while inner<needinner
%We introduce the initial variable here.
x1_0=99.9*rand(1)+0.1;
x2_0=99.9*rand(1)+0.1;
s0_0=4995*rand(1)+5;
s1_0=99.9*rand(1)+0.1;
s2_0=99.9*rand(1)+0.1;

%ODE solving
y0 = [x1_0;x2_0;s0_0;s1_0;s2_0];

[t,y] = ode45(@chemostat, [0 T], y0);
x_1a = y(:,1);
x_2a = y(:,2);

newx_1=x_1a(length(x_1a));
newx_2=x_2a(length(x_2a));

inner=inner+1;

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
v=[E0i L1i L2i L12i];
v=sort(v);
if v(3)~=0
    B=B+1;
    continue;
end
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





