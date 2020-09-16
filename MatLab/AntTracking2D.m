close all;
clear all;
mark = 1;

%Thresholds
backDif    = 100; %Background difference
noiseSize  = 5; %Size of particles to keep
medFiltRad = 5; %Radius to evaluate median filter
skelSize   = 50; %Size to evaluate skeleton

video = VideoReader('Data/ant3.mp4');
background = imread('Data/ant3back.jpg');
numFrames = ceil(video.FrameRate*video.Duration);
duration = 10;

endpoints = zeros(9,2,duration);

figure(); imshow(background); hold on;
for i = 20:20+duration
    disp(num2str(i));
    
    %Sets image to subsequent video frame of 'video'
    im = read(video,i);
    
    %Subtracts image from background
    mask = background(:,:) - im(:,:) > backDif;
    
    %Fills in 'holes' in objects, if there are any
    mask = imfill(mask, 'holes');
    
    %Removes small objects of threshold size 5
    mask = bwareaopen(mask, noiseSize);
    
    %Runs median filter over 5x5 neighbors
    mask = medfilt2(mask, [medFiltRad, medFiltRad]);
    
    %Marks out skeleton
    [ske, r] = skeleton(mask);
    
    %Makes thin objects into lines
    mainske = bwmorph(ske > skelSize, 'thin', inf);
    [d, ep, jp] = skeanalysis(mainske);
    %disp('EP:');
    %disp(num2str(ep));
    %Marks out skeleton
    if mark
        %Show Original Image
        figure(); imshow(im); hold on;
        skemark(mainske, ske, ep, jp, r);
    end
        temp =  skevar (mainske, ske, ep, jp, r);
        %disp('Temps:');
        %disp(num2str(temp));
        endpoints(:,:,i) = temp;
    %end
    %hold off;
end

   figure(); hold on;
   axis([0 1920 0 1080]);
for i = 1:duration
    plot(endpoints(1,1,i),endpoints(1,2,i),'*r','MarkerSize',10);
    text(endpoints(1,1,i),endpoints(1,2,i),num2str(i));
    
    plot(endpoints(4,1,i),endpoints(4,2,i),'*y','MarkerSize',10);
    text(endpoints(4,1,i),endpoints(4,2,i),num2str(i));
    
    plot(endpoints(7,1,i),endpoints(7,2,i),'*g','MarkerSize',10);
    text(endpoints(7,1,i),endpoints(7,2,i),num2str(i));
end