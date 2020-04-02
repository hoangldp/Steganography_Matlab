function embed(inputFile, secret, outputFile)
    image = imread(inputFile);
    image = embedSecret(image, secret);
    imwrite(image, outputFile);
end

