function [label, clabel] = get_label(dof, dam_pos, dam_vals)
k_label = ones(1,dof);
m_label = ones(1,dof);
clabel = 0;
dam_num = size(dam_vals,2);
if dam_num>0
    xx = split(dam_pos, '-');
    dam_k_or_m = split(xx(2), ',');
    for i=1:1:dam_num
        p = dam_k_or_m(i);
        p = char(p);
        if p(1) == 'k'
            k_num = str2num(p(2));
            k_label(k_num) = dam_vals(i);
            clabel = 1;
        elseif p(1) == 'm'
            m_num = str2num(p(2));
            m_label(m_num) = dam_vals(i);
            clabel = 1;
        else
            error("damage is wrong");
        end
    end
end
label = [k_label,m_label];
end