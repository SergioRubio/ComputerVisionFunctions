function [exp1, exp2] = checkgradientfilter(im, filterType)

    exp1 = [];
    exp2 = [];

    if strcmpi(filterType, 'roberts')
        filtH = [1 0;0 -1];
        filtV = [0 1;-1 0];

    elseif strcmpi(filterType, 'prewitt')
        filtH = [-1 -1 -1;0 0 0;1 1 1];
        filtV = [-1 0 1;-1 0 1;-1 0 1];
        
    elseif strcmpi(filterType, 'sobel')
        filtH = [-1 -2 -1;0 0 0;1 2 1];
        filtV = [-1 0 1;-2 0 2;-1 0 1];
    end;

    pos = 1;

    for ang=0:-10:-180
        imR = imrotate(im, ang, 'bilinear');

        imRGH = imfilter(imR, filtH);
        imRGV = imfilter(imR, filtV);

        imRGH = imcrop(imRGH, [128-20, 128-20, 100, 100]);
        imRGV = imcrop(imRGV, [128-20, 128-20, 100, 100]);

        imRGH = double(imRGH.^2);
        imRGV = double(imRGV.^2);
        imRG = sqrt(imRGH+imRGV);

        imRA = atan2(imRGH, imRGV);

        exp1(pos) = max(max(imRG)); 
        exp2(pos) = (max(max(imRA)))*(180/pi); 
        pos = pos+1;
    end;
