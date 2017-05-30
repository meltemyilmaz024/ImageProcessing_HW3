%   Meltem YILMAZ
%   Task 1 – Image Restoration in the Spatial Domain

clc;
close all;

I = imread('pout.tif');

G = imnoise(I,'gaussian', 0.05);

% Apply a 7-by-7 average filter.
intImage = integralImage(G);
avgH = integralKernel([1 1 7 7], 1/49);
Av_7 = integralFilter(intImage, avgH);
Av_7 = uint8(Av_7);

% Apply a 3-by-3 average filter.
intImage = integralImage(G);
avgH = integralKernel([1 1 3 3], 1/9);
Av_3 = integralFilter(intImage, avgH);
Av_3 = uint8(Av_3);

% medfilt2(A, [m n])
Med_3 = medfilt2(G, [3 3]);
% medfilt2(A, [m n])
Med_7 = medfilt2(G, [7 7]);

figure();
subplot(3,2,1); imshow(I); title('Input image  ');
subplot(3,2,2); imshow(G); title('Gaussian Noise  ');
subplot(3,2,3); imshow(Av_3); title('Average Filter size 3x3 ');
subplot(3,2,4); imshow(Av_7); title('Average Filter size 7x7 ');
subplot(3,2,5); imshow(Med_3); title('Median Filter size 3x3 ');
subplot(3,2,6); imshow(Med_7); title('Median Filter size 7x7 ');

% -----------------------------------------------------------------------------------------------

S = imnoise(I,'salt & pepper',0.02);

% Apply a 7-by-7 average filter.
intImage = integralImage(S);
avgH = integralKernel([1 1 7 7], 1/49);
Av_7 = integralFilter(intImage, avgH);
Av_7 = uint8(Av_7);

% Apply a 3-by-3 average filter.
intImage = integralImage(S);
avgH = integralKernel([1 1 3 3], 1/9);
Av_3 = integralFilter(intImage, avgH);
Av_3 = uint8(Av_3);

% medfilt2(A, [m n])
Med_3 = medfilt2(S, [3 3]);
% medfilt2(A, [m n])
Med_7 = medfilt2(S, [7 7]);

figure();
subplot(3,2,1); imshow(I); title('Input image  ');
subplot(3,2,2); imshow(S); title('Salt-Pepper Noise  ');
subplot(3,2,3); imshow(Av_3); title('Average Filter size 3x3 ');
subplot(3,2,4); imshow(Av_7); title('Average Filter size 7x7 ');
subplot(3,2,5); imshow(Med_3); title('Median Filter size 3x3 ');
subplot(3,2,6); imshow(Med_7); title('Median Filter size 7x7 ');



