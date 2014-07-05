function he = histequalization2(imOriginal)

    he = imOriginal;
    newMap = containers.Map('KeyType','int32','ValueType','double');

    for x = 1:numel(imOriginal)
        x1 = imOriginal(x);

        if isKey(newMap,x1) == 0
            newMap(x1) = 0;
        end;
    end;

    keys = newMap.keys();
    keys2 = cell2mat(keys);
    num = 255/length(keys2);

    sep = (num+1)*(0.7*length(keys2));

    for x = 1:length(keys2)
        
        if ne(x,1)

            if x <= 0.7*length(keys2)
                newMap(keys2(x)) = newMap(keys2(x-1)) + num + 1;
            else
                newMap(keys2(x)) = newMap(keys2(x-1)) + (255-sep)/(0.3*length(keys2));
            end;
        end;
    end;

    for x = 1:numel(imOriginal)
        he(x) = newMap(imOriginal(x));
    end;

