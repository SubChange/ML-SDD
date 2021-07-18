function [dk,dm] = get_damaged_k_m(k, m, dam_pos, dam_vals)
ak = k;
am = m;
dam_num = size(dam_vals,2);
if dam_num>0
    xx = split(dam_pos, '-');
    dam_k_or_m = split(xx(2), ',');
    for i=1:1:dam_num
        p = dam_k_or_m(i);
        p = char(p);
        if p(1) == 'k'
            k_num = str2num(p(2));
            ak(k_num) = ak(k_num) * dam_vals(i);
        elseif p(1) == 'm'
            m_num = str2num(p(2));
            am(m_num) = am(m_num) * dam_vals(i);
        else
            error("damage is wrong");
        end
    end
end
dk = get_k(ak);
dm = get_m(am);
end