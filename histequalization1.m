function he = histequalization1(imOriginal)

    imSize = size(imOriginal);
    pixels = imSize(1)*imSize(2);
    
    intFreqs = imhist(imOriginal);
    
    intCum = cumsum(intFreqs);
    
    intCumNan = intCum;
    intCumNan(intCumNan == 0) = NaN;
    intCumMin = min(min(intCumNan));
    
    intCumProb = (intCum - intCumMin)/(pixels - intCumMin);
    
    finalInt = intCumProb*255;
    
    he = imOriginal;
    
    for x=1:pixels
        he(x) = finalInt(imOriginal(x) + 1);
    end;
    
    
