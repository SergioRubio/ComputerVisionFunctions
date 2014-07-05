function clusters = knn(trainingData, newData, distanceFunction, k, normalization)

    trainingLength = size(trainingData);
    trainingLength = trainingLength(1);
    newLength = size(newData);
    newLength = newLength(1);
    
    if normalization
        maxX1 = 40;
        maxX2 = 350;
    else
        maxX1 = 1;
        maxX2 = 1;
    end;
    
    clusters = zeros(1, newLength);
    distances = zeros(newLength, trainingLength, 2);

    for x=1:newLength
        n = newData(x,:);
        
        if strcmp(distanceFunction, 'euclidean')
            n(1) = n(1)/maxX1;
            n(2) = n(2)/maxX2;

            for y=1:trainingLength
                t = trainingData(y,1:2);
                t(1) = t(1)/maxX1;
                t(2) = t(2)/maxX2;

                distance = sum((n-t).^2).^0.5;

                distances(x, y, 1) = distance;
                distances(x, y, 2) = trainingData(y,3:3);

            end;
            
            [minDists, origInd] = sort(distances(x,:,1));
            minInd = distances(x,origInd(1),2);

            for ind=2:k
                minInd = [minInd, distances(x,origInd(ind),2)];
            end;

            clusters(x) = mode(minInd);
        elseif strcmp(distanceFunction, 'mahalanobis')
            tr = trainingData;
            tr(:,3) = [];
            X = tr';
            Y = n';
            
            [D N] = size(X);
            [D P] = size(Y);
            A = [X Y];
            invcov = inv(cov(A'));

            for i=1:N
                diff = repmat(X(:,i), 1, P) - Y;
                dsq(i,:) = sum((invcov*diff).*diff , 1);
            end

            d = sqrt(dsq);
            
            [minDist, origInd] = sort(d);
            minInd = trainingData(origInd(1),3);
            
            for ind=2:k
                minInd = [minInd, trainingData(origInd(ind),3)];
            end;

            clusters(x) = mode(minInd);
        end;
    end;
    
    
    
    
    
    
