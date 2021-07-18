function ak = get_k(k)
ak = diag(k);
n = size(ak,1);
for i=1:1:n
    if i~=n
        ak(i,i) = ak(i,i) + k(i+1);
        ak(i+1,i) = -k(i+1);
        ak(i,i+1) = -k(i+1);
    end
end
end