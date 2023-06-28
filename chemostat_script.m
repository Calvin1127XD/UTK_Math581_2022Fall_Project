clear all
close all
clc

T = 2000;

%Global parameter testing
global phi mu1 mu2 S0 S1 S2 K10 K12 K20 K21 v01 v02 v11 v12 v21 v22
phi=2;
mu1=3000;
mu2=600;
S0=50;
S1=1;
S2=1;
K10=200;
K12=200;
K20=200;
K21=200;
v01=-1;
v02=-1;
v11=0.2;
v12=-0.1;
v21=-0.1;
v22=0.2;
%Global parameter testing

x1_0 = 20;
x2_0 = 20;
s0_0 = 50;
s1_0 = 1;
s2_0 = 1;

y0 = [x1_0;x2_0;s0_0;s1_0;s2_0];


[t,y] = ode45(@chemostat, [0 T], y0);
fig=figure
x_1a = y(:,1);
x_2a = y(:,2);
s_0a = y(:,3);
s_1a = y(:,4);
s_2a = y(:,5);


subplot(3,2,1)
plot(x_1a)
xlim([0,T])
xlabel('T (epochs)')
ylabel('X_1')
title('Subplot 1: X_1')
subplot(3,2,2)
plot(x_2a)
xlim([0,T])
xlabel('T (epochs)')
ylabel('X_2')
title('Subplot 2: X_2')
subplot(3,2,3)
plot(s_1a)
xlim([0,T])
xlabel('T (epochs)')
ylabel('S_1')
title('Subplot 3: s_1')
subplot(3,2,4)
plot(s_2a)
xlim([0,T])
xlabel('T (epochs)')
ylabel('S_2')
title('Subplot 4: s_2')
subplot(3,2,5)
plot(s_0a)
xlim([0,T])
xlabel('T (epochs)')
ylabel('S_0')
title('Subplot 5: S_0')







