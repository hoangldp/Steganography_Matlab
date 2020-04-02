function test(secret)
    intput = 'test.jpg';
    output = 'test_steganography.bmp';
    
    imageEmbed = embed(intput, secret);
    imwrite(imageEmbed, output);
    
    secret = extract(output);
    disp(secret);
end

