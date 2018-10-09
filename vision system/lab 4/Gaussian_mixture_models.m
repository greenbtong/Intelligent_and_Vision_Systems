clear all
close all

% read the video
source = VideoReader('car-tracking.mp4');  

% create and open the object to write the results
output = VideoWriter('gmm_outputss.mp4', 'MPEG-4');
open(output);

% create foreground detector object
n_frames = 10;   % a parameter to vary
n_gaussians = 40;   % a parameter to vary
% gaussian 10 the higher the guassian the higher the change of fram has to be.
% changes like shadow, shade of color (it looks like)
% if gaussian is 1 or small the foregorunddetector will not pick up the
% difference
% frame = 1 and gaussian = 10 looks pretty good 20 too
% im guessing frame is the test (intiative frames to compare with) and
% gaussian is the sensetivitiy of the differences

detector = vision.ForegroundDetector('NumTrainingFrames', n_frames, 'NumGaussians', n_gaussians);

% --------------------- process frames -----------------------------------
% loop all the frames
while hasFrame(source)
    fr = readFrame(source);     % read in frame
    
    fgMask = step(detector, fr);    % compute the foreground mask by Gaussian mixture models
    
    % create frame with foreground detection
    fg = uint8(zeros(size(fr, 1), size(fr, 2)));
    fg(fgMask) = 255;
    
    % visualise the results
    figure(1),subplot(2,1,1), imshow(fr)
    subplot(2,1,2), imshow(fg)
    drawnow
    
    writeVideo(output, fg);           % save frame into the output video
end


close(output); % save video
