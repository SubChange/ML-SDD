clear all
close all
clc

k = [9.0e5, 9.0e5, 9.0e5, 9.0e5];
m = [1.0e4, 1.0e4, 1.0e4, 1.0e4];


n = 4;
nom = 4;
dt = 0.005;
F = 100*[1;0;0;0];

t = 0:dt:60;
ft = zeros(1,size(t,2));

fw = 5.0;
Tft = 2.5;

ft0 = sin(2*pi/fw.*t(1:floor(Tft/dt)+1));
ft(1:floor(Tft/dt)+1) = ft0;

zet = 2;
dam_num = 1;
[dam_name,dam_vals] = rand_damage(dam_num, n);
[dk,dm] = get_damaged_k_m(k, m, dam_name, dam_vals);
[phi,omega2] = eig(dk,dm);
[disp,~,acc_tmp,~] = NM(n,nom,dt,F,ft,dm,dk,zet,omega2,phi);


figure()
plot(t,acc_tmp(:,1));
hold on
plot(t,acc_tmp(:,2));
plot(t,acc_tmp(:,3));
plot(t,acc_tmp(:,4));
[d1max,d1index] = max(acc_tmp(:,4));
scatter(t(d1index),d1max)
text(t(d1index),d1max,num2str(d1max));
xlabel("Time(s)");
ylabel("Displacement(m)");
title("(a) Displacement");
legend('acc1','acc2','acc3','acc4');
