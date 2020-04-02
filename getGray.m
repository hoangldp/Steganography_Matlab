function grayValue = getGray(pixel)
    r = double(pixel(1, 1, 1));
    g = double(pixel(1, 1, 2));
    b = double(pixel(1, 1, 3));
    
    g = r * 0.299 + g * 0.587 + b * 0.114;
    grayValue = round(g);
end
