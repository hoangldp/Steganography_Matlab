function gray = grayImage(image)
    [w, h, d] = size(image);
    
    if d ~= 3 || w < 3 || h < 3
        disp('Error embed');
        exit;
    end
    
    maxtrix = zeros(h,w, 'uint8');
    for i = 1:1:w
        for j = 1:1:h
            p = image(i, j, :);
            maxtrix(i, j) = getGray(p);
        end
    end
    
    gray = maxtrix;
end

