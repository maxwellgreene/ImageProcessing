function DemoFunc(background, im)

mask = background(:,:) - im(:,:) > 3;
mask = imfill(mask, 'holes');
mask = bwareaopen(mask, 5);
mask = medfilt2(mask, [5, 5]);
figure;

[ske, r] = skeleton(mask);
imshow(im);
hold on;
mainske = bwmorph(ske > 10, 'thin', inf);
[d, ep, jp] = skeanalysis(mainske);
skemark(mainske,ske, ep, jp, r);
hold off;
end