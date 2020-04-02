function data = getData(secret)
    len = length(secret);
    
    result = '';
    
    for i = 1:len
        c = dec2bin(secret(i), 24);
        result = strcat(result, c);
    end
    
    data = result;
end

