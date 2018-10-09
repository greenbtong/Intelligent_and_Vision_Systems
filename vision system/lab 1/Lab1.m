%%
clear all % Clears the workspace in Matlab

I = imread('Dog.jpg'); % Read in file
size(I) % Gives the size of the image
imshow(I); % Visualise the image
Ig = rgb2gray(I); % Converts a colour image into a grey level image
imshow(Ig) % Show the image

imwrite(I, 'Dog1.jpg') % The string contained in filename
imfinfo Dog.jpg % Get the information about the graphics file

I_b = I - 100; 
figure, imshow(I_b)
I_s = I + 100;
figure, imshow(I_s)

I_f = flipLtRt(I); % flip image
figure, imshow(I_f)

% Color the duck yellow!
im = imread('duckMallardDrake.jpg');
imshow(im);
[nr,nc,np] = size(im);
newIm = zeros(nr,nc,np);
newIm = uint8(newIm);

for r = 1:nr
    for c = 1:nc
        if (im(r,c,1)>180 && im(r,c,2) > 180 && im(r,c,3)>180)
            % white feather of the duck; now change it to yellow
            newIm(r,c,1) = 225;
            newIm(r,c,2) = 225;
            newIm(r,c,3) = 0;
        else % the rest of the picture; no change
            for p = 1:np
                newIm(r,c,p) = im(r,c,p);
            end
        end
    end
end

figure 
imshow(newIm)

im = imread('Two_colour.jpg'); % read the image 
imshow(im);

% extract RGB channels separatelly 
red_channel = im(:, :, 1);
green_channel = im(:, :, 2);
blue_channel = im(:, :, 3);

% Label pixels of yellow colour
yellow_map = green_channel > 150 & red_channel > 150 & blue_channel < 50;
%extract pixels indexes
[i_yellow, j_yellow] = find(yellow_map > 0);

% visualize the results
figure;
imshow(im); % plot the image
hold on;
scatter(j_yellow, i_yellow, 5, 'filled') % highlighted the yellow pixels

%%
clear all;

% select image
I = imread('bear.jpg');
Ig = rgb2gray(I); % gray scale
Ih = rgb2hsv(I); % HSV Format

ax1 = subplot(1,3,1);
imshow(I)
title('Original image');
ax2 = subplot(1,3,2);
imshow(Ig)
title('Grey Format')
ax3 = subplot(1,3,3);
imshow(Ih)
title('HSV Format');

% figure, imshow(I); % Visualise the image
% title('Original image');
% %imwrite(I, 'bearI.jpg')
% 

% Converts a colour image into a grey level image
% figure, imshow(Ig) % Show the image
% title('Grey Format');

%
% figure, imshow(Ih);
% title('HSV Format');


%h = zoom;

%setAllowAxesZoom(h,ax2,false);
%setAxesZoomMotion(h,ax3,'vertical');
%setAxesZoomMotion(h,ax3,'horizontal');
%%
% 4 more formats
Ib = im2bw(I); % black and white sktch
In = rgb2ntsc(I); % NTSC color space
Ic = rgb2ycbcr(I); % YCbCr color space
Ix = rgb2xyz(I); % CIE 1931 XYZ

ax1 = subplot(1,4,1);
imshow(Ib)
title('Black and White Format');
ax2 = subplot(1,4,2);
imshow(In)
title('NTSC Color Space Format')
ax3 = subplot(1,4,3);
imshow(Ic)
title('YCbCr Color Space Format');
ax3 = subplot(1,4,4);
imshow(Ix)
title('CIE 1931 XYZ Format');
%%
% Histogram
Im_grey = rgb2gray(I);
% figure, imhist(Im_grey);
% xlabel('Number of bins')
% ylabel('Historgram counts')
%%
h = imhist(Im_grey);
h1 = h(1:10:256);
horz = 1:10:256;
figure, bar(horz,h1)
figure, plot(h)
%%
r= double(I(:,:,1));
g = double(I(:,:,2));
b = double(I(:,:,3));
% figure, hist(r(:),124)
% title('Histogram of the red colour')
% figure, hist(g(:),124) 
% title('Histogram of the green colour')
% figure, hist(b(:),124)
% title('Histogram of the blue colour')

%%

% get array values for hist
Im_grey = rgb2gray(I);
r= double(I(:,:,1));
g = double(I(:,:,2));
b = double(I(:,:,3));

% visualize
subplot(2,2,1);
imhist(Im_grey);
title('Grey Hist');
xlabel('Number of bins')
ylabel('Historgram counts')
subplot(2,2,2);
hist(r(:),124)
title('Red Hist')
xlabel('Number of bins')
ylabel('Historgram counts')
subplot(2,2,3);
hist(g(:),124)
title('Green Hist');
xlabel('Number of bins')
ylabel('Historgram counts')
subplot(2,2,4);
hist(b(:),124)
title('Blue Hist');
xlabel('Number of bins')
ylabel('Historgram counts')
%%
%figure, bar(colorhist(:))  
%figure, bar(colorhist(:),8)  

numbin = 8; 
binsize = 256/10;
Iinex = (r./binsize).*numbin  + (g./binsize).*numbin + (b./binsize).*numbin;
Iinex = floor(Iinex);
totalbins = numbin^3;
colorhist = hist(Iinex(:),0:1:totalbins);

%visualize
subplot(2,1,1);
bar(colorhist(:)) 
title('Grey Hist');
xlabel('Number of bins')
ylabel('Historgram counts')
xlim([0 256])
title('Histogram of all colours in the image');
subplot(2,1,2);
bar(colorhist(:),8) 
title('Red Hist')
xlabel('Number of bins')
ylabel('Historgram counts')
xlim([0 256])
title('Histogram of all colours in the image (bin = 8)');
%%
%binarisation process
BW=im2bw(I, 200/256);
figure, imshowpair(im2bw(I), BW, 'montage');
title("Binarisation process with Different threshold")

%%
clear all 
I = imread('bear.jpg');

% Display the original image.
subplot(2, 4, 1);
imshow(I, [ ]);
title('Original RGB image');
 
% Convert to HSV color space
hsvimage = rgb2hsv(I); 
 
% Extract out the individual channels.
hueImage = hsvimage(:,:,1); 
satImage = hsvimage(:,:,2); 
valueImage = hsvimage(:,:,3); 
 
% Display the individual channels.
subplot(2, 4, 2);
imshow(hueImage, [ ]);
title('Hue Image');
subplot(2, 4, 3);
imshow(satImage, [ ]);
title('Saturation Image');
subplot(2, 4, 4);
imshow(valueImage, [ ]); 
title('Value Image');
 
% Take histograms
[hCount, hValues] = imhist(hueImage(:), 18); 
[sCount, sValues] = imhist(satImage(:), 3); 
[vCount, vValues] = imhist(valueImage(:), 3); 
 
% Plot histograms.
subplot(2, 4, 5);
bar(hValues, hCount);
title('Hue Histogram');
subplot(2, 4, 6);
bar(sValues, sCount);
title('Saturation Histogram');
subplot(2, 4, 7);
bar(vValues, vCount);
title('Value Histogram');
 
% Alert user that we're done.
message = sprintf('Done processing this image.\n Maximize and check out the figure window.');
msgbox(message);

%%
clear all 

% read images
I1 = imread('One_colour.jpg');
I2 = imread('Two_colour.jpg');
Im1_grey = rgb2gray(I1);
Im2_grey = rgb2gray(I2);

% histgram it
h = imhist(Im1_grey);
h1 = h(1:5:256);
horz = 1:5:256; 
h2 = imhist(Im2_grey);
h3 = h2(1:5:256);
horz = 1:5:256; 

% visualize
subplot(2,1,1);
bar(horz, h1) 
title('One Colour Histogram');
xlabel('Number of bins')
ylabel('Historgram counts')
xlim([0 256])
ylim([0 3E4])
subplot(2,1,2);
bar(horz,h3)
title('Two Colour Histogram');
xlabel('Number of bins')
ylabel('Historgram counts')
xlim([0 256])
ylim([0 3E4])

