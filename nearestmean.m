function clusters = nearestmean(tr1, tr2, newData, distanceFunction, normalization)
    
    if normalization
        if strcmp(distanceFunction, 'euclidean')
            tr1(:,1) = tr1(:,1)./30;
            tr1(:,2) = tr1(:,2)./250;
            
            tr2(:,1) = tr2(:,1)./40;
            tr2(:,2) = tr2(:,2)./350;
            
            newData(:,1) = newData(:,1)./35;
            newData(:,2) = newData(:,2)./300;
        end;
    end;

    tr1Len = size(tr1);
    tr1Len = tr1Len(1);
    
    tr1Means = [0, 0];
    tr1Means = [(sum(tr1(:,1)))/tr1Len, (sum(tr1(:,2)))/tr1Len];
    
    tr2Len = size(tr2);
    tr2Len = tr2Len(1);
    
    tr2Means = [0, 0];
    tr2Means = [(sum(tr2(:,1)))/tr2Len, (sum(tr2(:,2)))/tr2Len];
    
    newLength = size(newData);
    newLength = newLength(1);

    clusters = zeros(1, newLength);
    
    if strcmp(distanceFunction, 'euclidean')
        distance1 = sum((tr1Means-newData).^2).^0.5;
        distance2 = sum((tr2Means-newData).^2).^0.5;
        
        if distance1 <= distance2
            clusters(1) = 1;

        else
            clusters(1) = 2;
        end;
    elseif strcmp(distanceFunction, 'mahalanobis')
        distance1 = mahal(newData, tr1);
        distance2 = mahal(newData, tr2);
        
        if distance1 <= distance2
            clusters(1) = 1;
        
        else
            clusters(1) = 2;
        end;
    end;
