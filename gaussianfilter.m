function filter = gaussianfilter(xSize, ySize, xSigma, ySigma, angle)

    xMu = round(xSize/2);
    yMu = round(ySize/2);

    angle = (-angle+90)*(pi/180);
    rotationMatrix = [cos(angle), -sin(angle); sin(angle), cos(angle)];

    filter = zeros(xSize, ySize);

    for x=1:xSize
        for y=1:ySize
            pointR = rotationMatrix*[x - xMu; y - yMu];
            xR = pointR(1);
            yR = pointR(2);

            xValue = (1/(xSigma*sqrt(2*pi)))*(exp(-((xR)^2)/(2*(xSigma)^2)));
            yValue = (1/(ySigma*sqrt(2*pi)))*(exp(-((yR)^2)/(2*(ySigma)^2)));

            filter(x, y) = xValue*yValue;
        end;
    end;

    total = sum(sum(filter));
    filter = (filter./total);
