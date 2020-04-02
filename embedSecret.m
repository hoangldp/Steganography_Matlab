function embed = embedSecret(image, secret)
    [w, h, d] = size(image);
    
    if d ~= 3 || w < 3 || h < 3
        disp('Error embed');
        exit;
    end
    
    data = strcat(getData(secret), dec2bin(0, 48));
    len = length(data);
    
    pos = 1;
    stop = false;
    for i = 2:2:w
        for j = 2:2:h
            p = image(i, j, :);
            
            pUpper = image(i, j - 1, :);
            pLeft = image(i - 1, j, :);
            pRight = image(i + 1, j, :);
            pBottom = image(i, j + 1, :);
            pUpperLeft = image(i - 1, j - 1, :);
            pUpperRight = image(i + 1, j - 1, :);
            pBottomLeft = image(i - 1, j + 1, :);
            pBottomRight = image(i + 1, j + 1, :);
            
            n = getCapacity(pUpper, pLeft, pRight, pBottom, pUpperLeft, pUpperRight, pBottomLeft, pBottomRight);
            
            adding = len - pos + 1 - n;
            stop = adding < 0;
            if stop
                adding = -1 * adding;
            else
                adding = 0;
            end
            
            dataEmbed = extractBetween(data, pos, pos + n - 1 - adding);
            if adding > 0
                dataEmbed = strcat(dataEmbed, dec2bin(0, adding));
            end
            
            b = bin2dec(dataEmbed);
            newGray = calculateGrayEmbed(p, n, b);
            [r, g, b] = changeGray(p, newGray);
            
            image(i, j, 1) = r;
            image(i, j, 2) = g;
            image(i, j, 3) = b;
            
            pos = pos + n;
            
            if stop
                break;
            else
                stop = pos > len;
            end
            
            if stop
                break;
            end
        end
            
        if stop
            break;
        end
    end
    
    if pos <= len
        disp('Error embed');
        exit;
    end
    
    embed = image;
end

