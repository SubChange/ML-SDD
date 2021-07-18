clear all
clc

k = [10e8, 10e8, 5e8, 5e8, 5e8, 5e8, 5e8,5e8];
m = [8e6, 8e6, 8e6, 8e6, 8e6, 8e6, 8e6, 8e6];

[dk,dm] = get_damaged_k_m(k, m, "", []);

[phi,omega2] = eig(dk,dm);

n = 8;
nom = 8;
dt = 0.005;
F = 1000.*[0; 0; 0; -75; 100; 0; 0; 0];

t = 0:dt:60;
ft = zeros(1,size(t,2));

Tft = 4.93/2;

ft0 = sin(2*pi/4.93.*t(1:floor(Tft/dt)+1));
ft(1:floor(Tft/dt)+1) = ft0;

zet = 2;

[disp1,EF1] = NM(n,nom,dt,F,ft,dm,dk,zet,omega2,phi);

figure()
plot(t,1000*disp1(:,2));
hold on
plot(t,1000*disp1(:,5));
plot(t,1000*disp1(:,8));
[d1max,d1index] = max(disp1(:,8));
scatter(t(d1index),1000*d1max)
text(t(d1index),1000*d1max,num2str(1000*d1max));
xlabel("Time(s)");
ylabel("Displacement(m)");
title("(a) Displacement");
