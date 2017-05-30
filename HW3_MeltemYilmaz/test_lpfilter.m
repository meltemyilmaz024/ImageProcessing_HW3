footBall=imread('football.jpg');
%Convert to grayscale
footBall=rgb2gray(footBall); 
subplot(2,2,1);
imshow(footBall)

%Determine good padding for Fourier transform
PQ = paddedsize(size(footBall));

%Create a Gaussian Lowpass filter 5% the width of the Fourier transform
D0 = 0.05*PQ(1);
H = lpfilter('btw', PQ(1), PQ(2), D0);
H2 = bandreject();
%imshow(H);

% Calculate the discrete Fourier transform of the image
F=fft2(double(footBall),size(H,1),size(H,2));

% Apply the highpass filter to the Fourier spectrum of the image
LPFS_football = H.*F;

% convert the result to the spacial domain.
LPF_football=real(ifft2(LPFS_football)); 

% Crop the image to undo padding
LPF_football=LPF_football(1:size(footBall,1), 1:size(footBall,2));

%Display the blurred image
subplot(2,2,2);
imshow(LPF_football, [])

% Display the Fourier Spectrum 
% Move the origin of the transform to the center of the frequency rectangle.
Fc=fftshift(F);
Fcf=fftshift(LPFS_football);
% use abs to compute the magnitude and use log to brighten display
S1=log(1+abs(Fc)); 
S2=log(1+abs(Fcf));

subplot(2,2,3); 
imshow(S1,[]);
subplot(2,2,4);
imshow(S2,[]);