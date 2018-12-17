function [returnvar] = skevar(mainske, ske, ep, jp, r)    
    mainske = bwareaopen(mainske, 5);
    
    %Sets reg to values of grouped pixels in mainske
    reg = bwlabel(mainske);
    
    %Gets Area, Centroid & Bounding Box  of image
    stats = regionprops(reg);
    
    headpoints = zeros(3,2);%length(stats),2);
    centerpoints = zeros(3,2);%length(stats),2);
    tailpoints = zeros(3,2);%length(stats),2);
    
    for i = 1 : 3%length(stats)
        if(stats(i).Area > 170)
            continue;
        end
        [rows, cols] = find(reg == i);
        %Object is the row and column locations of the pixels the current
        %'stats' are relating to
        obj = [cols, rows];
        
        if (isempty(jp))
        elseif (ismember(jp',obj,'rows'))
           continue
        end  
        
        %Sets endpoints to the coordinates where the current array object
        %and 'ep' intersect
        endpoint = intersect(obj, ep', 'rows');
        disp('Endpoints: ');
        disp(num2str(endpoint));
        width = ske .* (reg == i);
        [x y] = find(width == max(max(width)));
        centerpoint = [y(1,1), x(1,1)];
        
        %Divides the shape into 2, so that they will be seperated in
        %bwlabel
        reg(centerpoint(2), centerpoint(1)) = 0;
        temp = (reg == i);
        temp = bwlabel(temp);
        
        stats1 = regionprops(temp);
        width1 = mean(r(temp == 1));
        width2 = mean(r(temp == 2)); 
        if temp(endpoint(1, 2), endpoint(1, 1)) == 1
           endpoint1 = endpoint(1, :);
           endpoint2 = endpoint(2, :);
        else
           endpoint1 = endpoint(2, :);
           endpoint2 = endpoint(1, :);
        end
        if width1 >= width2
           headpoint = endpoint1;
           tailpoint = endpoint2;
        else
           headpoint = endpoint2;
           tailpoint = endpoint1;
        end
        headpoints(i,:) = headpoint;
        centerpoints(i,:) = centerpoint;
        tailpoints(i,:) = tailpoint;
    end
    returnvar = [headpoints;centerpoints;tailpoints];
    clear endpoint;
end