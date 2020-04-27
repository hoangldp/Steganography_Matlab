function psnr = getPeakSignalNoiseRatio(imageOrigin, imageSteganography)
    gOrigin = grayImage(imageOrigin);
    gSteganography = grayImage(imageSteganography);
    
    [w, h] = size(gOrigin);
    
    d = gOrigin - gSteganography;
    mse = sum(sum(d.^2)) / w / h;
    psnr = 10 * log10(255^2 / mse);
end

