function plotclusteringspace(classAlg, distanceFunction, k, normalization)

    space = zeros(25, 30);
    training = [[10,100,1];[10,200,1];[10,250,1];[10,350,2];[15,150,1];[15,350,2];[20,100,1];[20,250,1];[25,100,1];[25,200,1];[25,350,2];[30,150,1];[30,300,2];[35,150,2];[35,250,2];[35,350,2];[40,150,2];[40,250,2];[40,300,2]];
    tr1 = [[10,100];[10,200];[10,250];[15,150];[20,100];[20,250];[25,100];[25,200];[30,150]];
    tr2 = [[10,350];[15,350];[25,350];[30,300];[35,150];[35,250];[35,350];[40,150];[40,250];[40,300]];
    
    for n=100:350
        for m=10:40
            
            if strcmp(classAlg, 'nearestMean')
                c = nearestMean(tr1, tr2, [m,n], distanceFunction, normalization);

            elseif strcmp(classAlg, 'knn')
                c = knn(training, [m,n], distanceFunction, k, normalization);
            end;
            
            if c == 1
                space(fix((n-100)/10)+1, fix(m-10)+1) = 1;

            elseif c == 2
                space(fix((n-100)/10)+1, fix(m-10)+1) = 2;
            end;
        end;
    end;
    
    clusters1 = [];
    clusters2 = [];
    
    for nSpace=1:26
        for mSpace=1:31
            if space(nSpace, mSpace) == 1
                clusters1 = [clusters1; [mSpace+10-1, ((nSpace-1)*10)+100]];
            
            else
                clusters2 = [clusters2; [mSpace+10-1, ((nSpace-1)*10)+100]];
            end;
        end;
    end;
    
    plot(clusters1(:,1), clusters1(:,2), 'b.', 'markersize', 25); hold on;
    plot(clusters2(:,1), clusters2(:,2), 'r.', 'markersize', 25); hold on;
    
    plot(tr1(:,1), tr1(:,2), 'w.', 'markersize', 30); hold on;
    plot(tr2(:,1), tr2(:,2), 'w.', 'markersize', 30); hold on;
    
    plot(tr1(:,1), tr1(:,2), 'b*', 'markersize', 20); hold on;
    plot(tr1(:,1), tr1(:,2), 'bd', 'markersize', 10); hold on;
    
    plot(tr2(:,1), tr2(:,2), 'r*', 'markersize', 20);
    plot(tr2(:,1), tr2(:,2), 'rd', 'markersize', 10);
    
    xlabel('x1');
    ylabel('x2');
    
