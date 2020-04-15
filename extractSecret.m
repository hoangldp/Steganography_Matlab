function secret = extractSecret(image)
    [w, h, d] = size(image);
    
    if d ~= 3 || w < 3 || h < 3
        disp('Error embed');
        exit;
    end
    
    result = '';
    stop = false;
    strStop = dec2bin(0, 48);
    lenStop = length(strStop);
    
    for i = 2:2:w-1
        for j = 2:2:h-1
            p = image(i, j, :);
            g = getGray(p);
            
            pUpper = image(i, j - 1, :);
            pLeft = image(i - 1, j, :);
            pRight = image(i + 1, j, :);
            pBottom = image(i, j + 1, :);
            pUpperLeft = image(i - 1, j - 1, :);
            pUpperRight = image(i + 1, j - 1, :);
            pBottomLeft = image(i - 1, j + 1, :);
            pBottomRight = image(i + 1, j + 1, :);
            
            n = getCapacity(pUpper, pLeft, pRight, pBottom, pUpperLeft, pUpperRight, pBottomLeft, pBottomRight);
            
            d = 2 ^ n;
            b = mod(g, d);
            c = dec2bin(b, n);
            
            result = strcat(result, c);
            len = length(result);
            
            stop = len >= lenStop && endsWith(result, strStop);
            if stop
                break;
            end
        end
        
        if stop
            break;
        end
    end
    
    if stop == false
        disp('Error extract');
        exit;
    else
        len = length(result);
        subtracting = mod(len, 24);
        extract = extractBetween(result, 1, len - subtracting - 24);
        result = extract{1, 1};
        
        if endsWith(result, dec2bin(0, 24))
            len = length(result);
            extract = extractBetween(result, 1, len - 24);
            result = extract{1, 1};
        end
        
        secret = getSecret(result);
    end
end

