function [embed, bit] = embed(inputFile, method, secret)
    image = imread(inputFile);
    [imageEmbed, bitEmbed] = embedSecret(image, method, secret);
    embed = imageEmbed;
    bit = bitEmbed;
end

