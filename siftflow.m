function [vx, vy] = siftflow(im1_path, im2_path)
padsize = 100;
scale = 0.15;
im1 = padarray(imread(im1_path), padsize);
im2 = padarray(imread(im2_path), padsize);

im1 = imresize(imfilter(im1, fspecial('gaussian',7,1.),'same','replicate'), scale, 'bicubic');
im2 = imresize(imfilter(im2, fspecial('gaussian',7,1.),'same','replicate'), scale, 'bicubic');

im1 = im2double(im1);
im2 = im2double(im2);

cellsize = 3;
gridspacing = 1;

sift1 = mexDenseSIFT(im1, cellsize, gridspacing);
sift2 = mexDenseSIFT(im2, cellsize, gridspacing);

SIFTflowpara.alpha = 2*255;
SIFTflowpara.d = 40*255;
SIFTflowpara.gamma = 0.005*255;
SIFTflowpara.nlevels = 4;
SIFTflowpara.wsize = 2;
SIFTflowpara.topwsize = 10;
SIFTflowpara.nTopIterations = 60;
SIFTflowpara.nIterations = 30;

[vx,vy,energylist] = SIFTflowc2f(sift1,sift2,SIFTflowpara);

ps = padsize * scale;

vx = vx(ps+1:end-ps, ps+1:end-ps, :);
vy = vy(ps+1:end-ps, ps+1:end-ps, :);
