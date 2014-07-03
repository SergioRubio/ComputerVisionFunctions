function [count, rectCoefs, circCoefs] = countobjects1(image, clearBorder) 

    gTh = graythresh(image);
    imageBW = im2bw(image, gTh);
    imageBWN = 1-imageBW;

    if clearBorder
        imageBWN = imclearborder(imageBWN, 4);
    end;

    stE = strel('disk', 7);
    imageBWNE = imerode(imageBWN, stE);

    stD = strel('disk', 10);
    imageBWNED = imdilate(imageBWNE, stD);

    imageFinal = imfill(imageBWNED, 'holes');

    [L, count] = bwlabel(imageFinal);

    imCentroids = regionprops(L, 'centroid');
    imBox = regionprops(L, 'boundingbox');
    area = regionprops(L, 'area');

    rectCoefs = zeros(1, count);
    circCoefs = zeros(1, count);

    imshow(L);
    hold on;

    for k=1:numel(imCentroids)
        rectCoefs(k) = (area(k).Area)/(imBox(k).BoundingBox(3)*imBox(k).BoundingBox(4));

        diam = max(imBox(k).BoundingBox(3), imBox(k).BoundingBox(4));
        perim = pi*diam;

        circCoefs(k) = (perim^2)/(area(k).Area);

        c = imCentroids(k).Centroid;
        plot(c(1), c(2), 'Marker', '*', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 10);  
    end;




