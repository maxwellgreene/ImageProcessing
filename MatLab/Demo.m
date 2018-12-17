close all;
clear all;

% video = VideoReader('Movie3.mp4');
% background = imread('backGround3Resize.jpg');%read(video,1);
% im = read(video,100);

background = imread('Data\backGround.jpg');
im = imread('Data\t1.jpg');

mask = background(:, :) - im(:, :) > 30;    
mask = imfill(mask, 'holes');      
mask = bwareaopen(mask, 100);
mask = medfilt2(mask, [5, 5]);  
figure;
imshow(im);
[ske, r] = skeleton(mask);
mainske = bwmorph(ske > 50, 'thin', inf);
hold on;   
[d, ep, jp] = skeanalysis(mainske);
skemark(mainske,ske, ep, jp, r);
hold off;