function skemark(mainske, ske, ep, jp, r)
    %Rids mainske of any random points
    mainske = bwareaopen(mainske, 5);
    
    %Sets reg to a grouping of pixels in mainske
    reg = bwlabel(mainske);
    
    %Gets Area, Centroid & Bounding Box  of image
    stats = regionprops(reg);
    
    for i = 1 : length(stats)
        
        %Draw bounding boxes
        thisBB = stats(i).BoundingBox;
        %rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],'EdgeColor','r','LineWidth',2 )
        
        if(stats(i).Area > 170)
            continue;
        end
        
        [rows, cols] = find(reg == i);
        obj = [cols, rows];
        if (isempty(jp))
        elseif (ismember(jp',obj,'rows'))
           continue
        end
        plot(cols, rows, '.b', 'MarkerSize',6);
        endpoint = intersect(obj, ep', 'rows');
        width = ske .* (reg == i);
        [x y] = find(width == max(max(width)));
        centerpoint = [y(1,1), x(1,1)];       
        plot(centerpoint(1), centerpoint(2), '*y', 'MarkerSize',5);            
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
        
        %Plots a green dot at the head
        plot(headpoint(1), headpoint(2), '*g', 'MarkerSize',5);
        %Plots a red dot at the tail
        plot(tailpoint(1), tailpoint(2), '*r', 'MarkerSize',5);
        
        %linemark(centerpoint, headpoint);
    end
end