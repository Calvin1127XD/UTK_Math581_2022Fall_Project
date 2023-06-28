function dydt = chemostat(~,y)

x1 = y(1);
x2 = y(2);
s0 = y(3);
s1 = y(4);
s2 = y(5);

% Parameters
global phi mu1 mu2 S0 S1 S2 K10 K12 K20 K21 v01 v02 v11 v12 v21 v22

f1=mu1*s0/(K10+s0)*s2/(K12+s2);
f2=mu2*s0/(K21+s0)*s1/(K21+s1);

dx1 = (f1-phi)*x1;
dx2 = (f2-phi)*x2;
ds0 = phi*(S0-s0)+v01*f1*x1+v02*f2*x2;
ds1 = phi*(S1-s1)+v11*f1*x1+v12*f2*x2;
ds2 = phi*(S2-s2)+v21*f1*x1+v22*f2*x2;


dydt = [dx1;dx2;ds0;ds1;ds2];










