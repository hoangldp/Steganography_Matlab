function n = getCapacity(upper, left, right, bottom, upper1, upper2, bottomLeft, bottomRight)
    gUpper = getGray(upper);
    gLeft = getGray(left);
    gRight = getGray(right);
    gBottom = getGray(bottom);
    
    switch nargin
        case 5
            g = [gUpper gLeft gRight gBottom getGray(upper1)];
        case 6
            g = [gUpper gLeft gRight gBottom getGray(upper1) getGray(upper2)];
        case 7
            g = [gUpper gLeft gRight gBottom getGray(upper1) getGray(upper2) getGray(bottomLeft)];
        case 8
            g = [gUpper gLeft gRight gBottom getGray(upper1) getGray(upper2) getGray(bottomLeft) getGray(bottomRight)];
        otherwise
            g = [gUpper gLeft gRight gBottom getGray(upper1) getGray(upper2) getGray(bottomLeft) getGray(bottomRight)];
    end
    
    gMax = max(g);
    gMin = min(g);
    
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

