function imTh = imthresholding(imOriginal, alpha)

    imTh = imOriginal;
    alpha = alpha/100;
    
    iMax = max(max(imOriginal));
    iMin = min(min(imOriginal));
    level = alpha*(iMax - iMin) + iMin;

    imSize = size(imOriginal);
    imSize = imSize(1)*imSize(2);
   
    for x = 1:imSize
        if imOriginal(x) <= level
            imTh(x) = level;
        end;
    end;
