function n = getCapacity(upper, left, right, bottom, upperLeft, upperRight, bottomLeft, bottomRight)
    gUpper = getGray(upper);
    gLeft = getGray(left);
    gRight = getGray(right);
    gBottom = getGray(bottom);
    gUpperLeft = getGray(upperLeft);
    gUpperRight = getGray(upperRight);
    gBottomLeft = getGray(bottomLeft);
    gBottomRight = getGray(bottomRight);
    
    gMax = max([gUpper gLeft gRight gBottom gUpperLeft gUpperRight gBottomLeft gBottomRight]);
    gMin = min([gUpper gLeft gRight gBottom gUpperLeft gUpperRight gBottomLeft gBottomRight]);
    
    d = gMax - gMin;
    
    if d <= 1
        n = 1;
    else
        result = floor(log2(d));
        if result > 4
            n = 4;
        else
            n = result;
        end
    end
end

