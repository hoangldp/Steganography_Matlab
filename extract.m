function secret = extract(inputFile, method)
    image = imread(inputFile);
    secret = extractSecret(image, method);
end

