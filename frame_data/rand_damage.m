function [dam_name,dam_val] = rand_damage(num, dof)

pos_num = randi(dof);
pos = randperm(dof);
pos = pos(1:pos_num);

dam_name = num2str(num) + "-";
dam_val = [];
for j =1:1:length(pos)
    if pos(j)<=dof
        dam_name = dam_name + "k" + num2str(pos(j)) + ",";
        val_temp = randi([700,999],1)/1000;
        dam_val = [dam_val,val_temp];
    else
        dam_name = dam_name + "m" + num2str(pos(j)+dof) + ",";
        val_temp = randi([700,999],1)/1000;
        while val_temp==1.0
            val_temp = randi([700,999],1)/1000;
        end
        dam_val = [dam_val,val_temp];
    end
end
dam_name = strip(dam_name,',');

end