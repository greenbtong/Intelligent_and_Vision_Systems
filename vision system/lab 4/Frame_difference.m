clear all
close all

% read the video
source = VideoReader('car-tracking.mp4');  

% create and open the object to write the results
output = VideoWriter('frame_difference_outputss.mp4', 'MPEG-4');
open(output);

% 0 thresh hold would mean that the smallest changes from the previous 
% image will be considered a move in object
% i believe this program determines the frame difference by looking at 
% the previous to the current image and determines the difference between
% both of them
thresh = 25;      % A parameter to vary     
% the higher the thresher hold the higher the pixel difference has to be
% so im assuming if the pixel moves fast enough it will be considered a forground object

% read the first frame of the video as a background model
bg = readFrame(source);
bg_bw = rgb2gray(bg);           % convert background to greyscale

% --------------------- process frames -----------------------------------
% loop all the frames
while hasFrame(source)
    fr = readFrame(source);     % read in frame
    fr_bw = rgb2gray(fr);       % convert frame to grayscale
    fr_diff = abs(double(fr_bw) - double(bg_bw));  % cast operands as double to avoid negative overflow
    
    % if fr_diff > thresh pixel in foreground
    fg = uint8(zeros(size(bg_bw)));
    fg(fr_diff > thresh) = 255;
    
    % update the background model
    bg_bw = fr_bw;
    
    % visualise the results
    hh = figure(1); 
    subplot(3,1,1), imshow(fr), title('Original Video')
    subplot(3,1,2), imshow(fr_bw), title('Greyscale')
    subplot(3,1,3), imshow(fg), title('Frame Differencing Approach')
    drawnow
    
    FF = getframe(hh);
    writeVideo(output, FF);           % save frame into the output video
end

%%

close(output); % save video
