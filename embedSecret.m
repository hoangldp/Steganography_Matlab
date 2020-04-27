function [embed, bit] = embedSecret(image, secret)
    [w, h, d] = size(image);
    
    if d ~= 3 || w < 3 || h < 3
        disp('Error embed');
        exit;
    end
    
    imageCopy = image;
    data = strcat(getData(secret), dec2bin(0, 48));
    len = length(data);
    
    pos = 1;
    stop = false;
    count = 0;
    for i = 2:2:w-1
        for j = 2:2:h-1
            p = imageCopy(i, j, :);
            
            pUpper = imageCopy(i, j - 1, :);
            pLeft = imageCopy(i - 1, j, :);
            pRight = imageCopy(i + 1, j, :);
            pBottom = imageCopy(i, j + 1, :);
            pUpperLeft = imageCopy(i - 1, j - 1, :);
            pUpperRight = imageCopy(i + 1, j - 1, :);
            pBottomLeft = imageCopy(i - 1, j + 1, :);
            pBottomRight = imageCopy(i + 1, j + 1, :);
            
            n = getCapacity(pUpper, pLeft, pRight, pBottom, pUpperLeft, pUpperRight, pBottomLeft, pBottomRight);
            
            adding = len - pos + 1 - n;
            stop = adding < 0;
            if stop
                adding = -1 * adding;
            else
                adding = 0;
            end
            
            count = count + n - adding;
            dataEmbed = extractBetween(data, pos, pos + n - 1 - adding);
            if adding > 0
                dataEmbed = strcat(dataEmbed, dec2bin(0, adding));
            end
            
            b = bin2dec(dataEmbed);
            newGray = calculateGrayEmbed(p, n, b);
            [r, g, b] = changeGray(p, newGray);
            
            imageCopy(i, j, 1) = r;
            imageCopy(i, j, 2) = g;
            imageCopy(i, j, 3) = b;
            
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
    
    embed = imageCopy;
    bit = count - 48;
end
