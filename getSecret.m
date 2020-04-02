function secret = getSecret(data)
    len = length(data);
    
    if mod(len, 24) ~= 0
        disp('Error extract secret');
        exit;
    end
    
    result = '';
    n = len / 24;
    
    for i = 1:n
        startPos = (i - 1) * 24 + 1;
        endPos = i * 24;
        c = extractBetween(data, startPos, endPos);
        b = bin2dec(c);
        result = strcat(result, char(b));
    end
    
    secret = result;
end

