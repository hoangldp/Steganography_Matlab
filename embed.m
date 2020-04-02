function embed(inputFile, secret, outputFile)
    image = imread(inputFile);
    imageEmbed = embedSecret(image, secret);
    imwrite(imageEmbed, outputFile);
end

