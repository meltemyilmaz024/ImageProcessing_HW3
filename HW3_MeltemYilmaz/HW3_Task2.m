%   Meltem YILMAZ
%   Task 2 – Image Restoration in the Frequency Domain
I = imread('cameraman.tif');

%% add periodic noise to the image
[x,y]=meshgrid(1:size(I,2),1:size(I,1));
p = 1+sin(x+y/1.5);
Ip = (double(I)/128+p)/4;

%% Determine good padding for Fourier transform
PQ = paddedsize(size(Ip));

%% remove noise by frequency domain filtering
%Create a Gaussian Lowpass filter 5% the width of the Fourier transform
D0 = 0.20*PQ(1);
H2 = lpfilter('gaussian', PQ(1), PQ(2), D0);
H = bandreject('gaussian', PQ(1), PQ(2), D0, 50);
% Calculate the discrete Fourier transform of the image
F = fft2(double(Ip),size(H,1),size(H,2));
% Apply the highpass filter to the Fourier spectrum of the image
LPFS_cameraman = H.* F;
% convert the result to the spacial domain.
LPF_cameraman=real(ifft2(LPFS_cameraman));
% Crop the image to undo padding
LPF_cameraman=LPF_cameraman(1:size(Ip,1), 1:size(Ip,2));
% Display the blurred image : imshow(LPF_cameraman, []);
% Display the Fourier Spectrum 
% Move the origin of the transform to the center of the frequency rectangle.
Fc=fftshift(F);
Fcf=fftshift(LPFS_cameraman);
% use abs to compute the magnitude and use log to brighten display
S1=log(1+abs(Fc)); 
S2=log(1+abs(Fcf));

%% Inverse FFT
G = real(ifft2(LPFS_cameraman));
G = G(1:size(Ip, 1), 1:size(Ip, 2));

%%
figure();
subplot(2,2,1); imshow(Ip);     title('Noisy image  ');
subplot(2,2,2); imshow(S1 ,[]); title('FFT of noisy image  ');
subplot(2,2,3); imshow(S2 ,[]); title('Bandreject filtered image ');
subplot(2,2,4); imshow(G);      title('Inverse FFT ');
