function maxBit = getMaxEmbed(image, method)
    [w, h, d] = size(image);
    
    if d ~= 3 || w < 3 || h < 3
        disp('Error embed');
        exit;
    end
    
    result = 0;
    for i = 2:2:w-1
        for j = 2:2:h-1
            pUpper = image(i, j - 1, :);
            pLeft = image(i - 1, j, :);
            pRight = image(i + 1, j, :);
            pBottom = image(i, j + 1, :);
            pUpperLeft = image(i - 1, j - 1, :);
            pUpperRight = image(i + 1, j - 1, :);
            pBottomLeft = image(i - 1, j + 1, :);
            pBottomRight = image(i + 1, j + 1, :);
            
            n = 0;
            if method == 5
                n = getCapacity(pUpper, pLeft, pRight, pBottom, pUpperRight);
            elseif method == 6
                n = getCapacity(pUpper, pLeft, pRight, pBottom, pUpperLeft, pUpperRight);
            elseif method == 7
                n = getCapacity(pUpper, pLeft, pRight, pBottom, pUpperLeft, pUpperRight, pBottomLeft);
            elseif method == 8
                n = getCapacity(pUpper, pLeft, pRight, pBottom, pUpperLeft, pUpperRight, pBottomLeft, pBottomRight);
            end
            result = result + n;
        end
    end
    
    maxBit = result - 48;
end

