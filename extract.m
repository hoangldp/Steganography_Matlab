function secret = extract(inputFile)
    image = imread(inputFile);
    secret = extractSecret(image);
end

