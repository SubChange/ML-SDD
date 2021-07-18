clear all
clc

k = [9.0e5, 9.0e5, 9.0e5, 9.0e5];
m = [1.0e4, 1.0e4, 1.0e4, 1.0e4];


n = 4;
nom = 4;
dt = 0.02;
F = 100*[1;0;0;0];

t = 0:dt:60;
ft = zeros(1,size(t,2));

fw = 5.0;
Tft = 2.5;

ft0 = sin(2*pi/fw.*t(1:floor(Tft/dt)+1));
ft(1:floor(Tft/dt)+1) = ft0;

zet = 1;

dam_name_all = [];
dam_vals_all = {};
label = [];
clabel = [];
data_num = 3000;
acc_data = zeros(data_num,n,length(ft));


dam_num = 0;
while dam_num<data_num
    if dam_num==0
        dam_name = "";
        dam_vals = [];
    else
        [dam_name,dam_vals] = rand_damage(dam_num, n);
    end
    
    [dk,dm] = get_damaged_k_m(k, m, dam_name, dam_vals);
    dam_num = dam_num + 1;
    [phi,omega2] = eig(dk,dm);
    [~,~,acc_tmp,~] = NM(n,nom,dt,F,ft,dm,dk,zet,omega2,phi);

    % record damage condition
    if length(dam_vals)>0
        dam_name_all = [dam_name_all;dam_name];
        dam_vals_all = [dam_vals_all;dam_vals];
    else
        dam_name_all = [dam_name_all;dam_name];
        dam_vals_all = [dam_vals_all;-1];
    end
    
    % data
    acc_data(dam_num,:,:) = acc_tmp';

    % data label
    [label_tmp, clabel_tmp] = get_label(n, dam_name, dam_vals);
    label = [label;label_tmp];
    clabel = [clabel;clabel_tmp];
end

save('./data/frame_data_sets_3000.mat','acc_data','label');


% csvwrite('./data/frame_data_sets_acc.csv',acc_data);
% csvwrite('./data/frame_data_sets_label.csv',label);

figure()
plot(t,reshape(acc_data(1,1,:),1,[]));
hold on
plot(t,reshape(acc_data(1,2,:),1,[]));
plot(t,reshape(acc_data(1,3,:),1,[]));
plot(t,reshape(acc_data(1,4,:),1,[]));
[d1max,d1index] = max(acc_data(1,4,:));
scatter(t(d1index),d1max)
text(t(d1index),d1max,num2str(d1max));
xlabel("Time(s)");
ylabel("Displacement(m)");
title("(a) Displacement");
