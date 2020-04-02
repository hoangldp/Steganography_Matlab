function embed = embed(inputFile, secret)
    image = imread(inputFile);
    imageEmbed = embedSecret(image, secret);
    embed = imageEmbed;
end

