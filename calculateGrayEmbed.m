function newGray = calculateGrayEmbed(pixel, n, b)
    gray = getGray(pixel);
    d = 2 ^ n;
    
    result = gray - mod(gray, d) + b;
    delta = result - gray;
    
    bottom = 2 ^ (n - 1);
    upper = 2 ^ n;
    
    if result >= upper && delta > bottom && delta < upper
        newGray = result - upper;
    elseif result < 255 && delta > (-1 * upper) && delta < (-1 * bottom)
        newGray = result + upper;
    else
        newGray = result;
    end
end

