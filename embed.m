function [embed, bit] = embed(inputFile, secret)
    image = imread(inputFile);
    [imageEmbed, bitEmbed] = embedSecret(image, secret);
    embed = imageEmbed;
    bit = bitEmbed;
end

