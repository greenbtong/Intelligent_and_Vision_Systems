clear all 

%% 1
% Read in image 
I = imread('lena.gif');
% %Im1_grey = rgb2gray(I1);
% 
%% 2
% % compute an image histogram
h = imhist(I);
% h1 = h(1:10:256);
% horz = 1:10:256; 
% figure, bar(horz,h1);
% title('image histogram');
% 
%% 3
% % histogram equalisation
J = histeq(I);

% figure, imshowpair(I,J,'montage');
% title('original/histogram equalisation');
% 
% J2 = imhist(J);
% h2 = J2(1:10:256);
% figure, bar(horz,h2);
% title('histogram equalisation');
% 
%% 4
% %gamma correction 
% G2 = imadjust(I);
% 
% figure, imshowpair(I,G2,'montage');
% title('original/gamma correction');
% 
% J3 = imhist(G2);
% h3 = J3(1:10:256);
% figure, bar(horz, h3)
% %figure, bar(horz,h3);
% title('Gamma correction histogram');
% 
%% 5
% K1 = imnoise(I,'gaussian');
% K2 = imnoise(I,'salt & pepper');
% figure, imshowpair(K1,K2,'montage');
% title('Gaussian/Salt & Pepper Noise');
% 
%% 6
% G1 = imgaussfilt(K1,.5);
% figure, imshowpair(K1, G1, 'montage');
% title('Gaussian Noise Image/Guassian Filtered, \sigma = .5')
% 
%% 7
% G2 = imgaussfilt(K2);
% figure, imshowpair(K2, G2, 'montage');
% title('Salt and Pepper/Guassian Filtered, \sigma = .5')
% 
%% 8
% G3 = medfilt2(K2);
% figure, imshowpair(K2, G3, 'montage');
% title('Salt and pepper/Median Filter')

%% 9
% Sobel
BW = edge(I, 'Sobel', .01 );
figure, imshowpair(I, BW, 'montage');
title('Original/Sobel')

%% 10
% Canny
BW1 = edge(I, 'Canny', .2); 
figure, imshowpair(I, BW1, 'montage');
title('Original/Canny')

%% 11
%threshhold determines the detail lower the more detail
% Prewitt
BW2 = edge(I, 'Prewitt', 0.01 ); 
figure, imshowpair(I, BW2, 'montage');
title('Original/Prewill')

% visualize
% subplot(2,2,1);
% imshow(I) 
% title('Original');
% subplot(2,2,2);
% imshow(BW) 
% title('Sobel')
% subplot(2,2,3);
% imshow(BW1) 
% title('Canny')
% subplot(2,2,4);
% imshow(BW2) 
% title('Prewill')
