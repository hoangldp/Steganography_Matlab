function [red, green, blue] = changeGray(pixel, newGray)
    r = double(pixel(1, 1, 1));
    g = double(pixel(1, 1, 2));
    b = double(pixel(1, 1, 3));
    
    grayPixel = getGray(pixel);
    rate = double(grayPixel) / double(newGray);
    
    r = round(r / rate);
    g = round(g / rate);
    b = round(b / rate);
    
    pixel(1, 1, 1) = r;
    pixel(1, 1, 2) = g;
    pixel(1, 1, 3) = b;
    
    grayAfter = getGray(pixel);
    if grayAfter == newGray
        red = r;
        green = g;
        blue = b;
    else
        diff = newGray - grayAfter;
        
        newG = g + diff;
        newR = r + diff * 2;
        newB = b + diff * 5;
        if newG >= 0 && newG <= 255
            red = r;
            green = newG;
            blue = b;
        elseif newR >= 0 && newR <= 255
            red = newR;
            green = g;
            blue = b;
        elseif newB >= 0 && newB <= 255
            red = r;
            green = g;
            blue = newB;
        else
            disp('Error change gray');
            exit;
        end
    end
end
