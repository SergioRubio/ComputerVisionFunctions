function [fobr, imageHM] = characterdetection(image, pattern)

    gTh = graythresh(image);
    imageBW = im2bw(image, gTh);

    fo = imopen(imageBW, pattern);
    fobr = imreconstruct(fo, imageBW);

    imageHM = imerode(imageBW, pattern)&imerode(~imageBW, ~pattern);

