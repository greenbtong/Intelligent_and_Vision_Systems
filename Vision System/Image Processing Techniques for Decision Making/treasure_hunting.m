close all;

%% Reading image
im = imread('Treasure_hard.jpg'); % change name to process other images
%imshow(im);

%% Binarisation
bin_threshold = 0.1; % parameter to vary
bin_im = im2bw(im, bin_threshold);
imshow(bin_im);
% title("im2bw")

%% Extracting connected components
con_com = bwlabel(bin_im);
%imshow(label2rgb(con_com));

%% Computing objects properties
props = regionprops(con_com);

%% Drawing bounding boxes
n_objects = numel(props);
% imshow(im);
% hold on;
% for object_id = 1 : n_objects
%    rectangle('Position', props(object_id).BoundingBox, 'EdgeColor', 'b');
% end
% hold off;

%% Arrow/non-arrow determination
% You should develop a function arrow_finder, which returns the IDs of the arror objects. 
% IDs are from the connected component analysis order. You may use any parameters for your function. 

arrow_ind = arrow_finder(props); 

%% Finding red arrow
n_arrows = numel(arrow_ind);
start_arrow_id = 0;
% check each arrow until find the red one
for arrow_num = 1 : n_arrows
    object_id = arrow_ind(arrow_num);    % determine the arrow id
    
    % extract colour of the centroid point of the current arrow
    centroid_colour = im(round(props(object_id).Centroid(2)), round(props(object_id).Centroid(1)), :); 
    if centroid_colour(:, :, 1) > 240 && centroid_colour(:, :, 2) < 10 && centroid_colour(:, :, 3) < 10
	% the centroid point is red, memorise its id and break the loop
        start_arrow_id = object_id;
        break;
    end
end

%% Hunting
cur_object = start_arrow_id; % start from the red arrow
path = cur_object;

% while the current object is an arrow, continue to search
while ismember(cur_object, arrow_ind) 
    % You should develop a function next_object_finder, which returns
    % the ID of the nearest object, which is pointed at by the current
    % arrow. You may use any other parameters for your function.

    cur_object = next_object_finder(cur_object, props, path, im);
    path(end + 1) = cur_object;
end

%% visualisation of the path
imshow(im);
hold on;
for path_element = 1 : numel(path) - 1
    object_id = path(path_element); % determine the object id
    rectangle('Position', props(object_id).BoundingBox, 'EdgeColor', 'y');
    str = num2str(path_element);
    text(props(object_id).BoundingBox(1), props(object_id).BoundingBox(2), str, 'Color', 'r', 'FontWeight', 'bold', 'FontSize', 14);
end

% visualisation of the treasure
treasure_id = path(end);
rectangle('Position', props(treasure_id).BoundingBox, 'EdgeColor', 'g');

%% test=(props(1).Centroid-props(2).Centroid);
% test = {};
% for y = round(props(1).BoundingBox(2)) : round(props(1).BoundingBox(2)+props(1).BoundingBox(4))
%     for x = round(props(1).BoundingBox(1)) : round(props(1).BoundingBox(1)+props(1).BoundingBox(3))
%         %test = [test, {i, j}]; 
%         fprintf( "%3d " , im(y, x))
%     end
%     fprintf("\n")
% end
% props(1).BoundingBox

%% mine  
%iValue = [];
% for ii = 1 : size(props)
%     p1 = round(props(ii).BoundingBox(1));
%     p2 = round(props(ii).BoundingBox(2));
%     p3 = round(props(ii).BoundingBox(3));
%     p4 = round(props(ii).BoundingBox(4));
%     %index = find(c(:,1) >= p2 & c(:,1) <= p2+p4 & c(:,2) >= p1 & c(:,2) <= p1+p3);
%     index = find(c(:,1) >= p1 & c(:,1) <= p1+p4 & c(:,2) >= p2 & c(:,2) <= p2+p3);
%     iValue = [iValue; round(median(index))];
%     
% end

% %visualise the results
% figure;
% imshow(im); % plot the image
% hold on;
% for i = 1 : size(props) 
%     if ~isnan(iValue(i))
%         scatter(j_yellow(iValue(i)), i_yellow(iValue(i))) % highlighted the yellow pixels
%     end
% end

 %% hamdi (GOOD)
% ci = [];
% cj = [];
% angles = [];
% for indeex = 1 : size(props)
%     xx = imcrop(im, props(indeex).BoundingBox);
%     % imshow(xx)
%     
%     red_channel = xx(:, :, 1);
%     green_channel = xx(:, :, 2);
%     blue_channel = xx(:, :, 3);
%     % label pixels of yellow colour
%     yellow_map = green_channel > 150 & red_channel > 150 & blue_channel < 50;
%     % extract pixels indexes
%     [i_yellow, j_yellow] = find(yellow_map > 0);
%     
%     p1 = props(indeex).BoundingBox(1);
%     p2 = props(indeex).BoundingBox(2);
%    
%     ci = [ci; p2 + mean(i_yellow)]; % y
%     cj = [cj; p1 + mean(j_yellow)]; % x
%    
% end
% temp = []; 
% y = 3;
% mh1 = ci(y)- props(y).Centroid(2);
% mh2 = cj(y)- props(y).Centroid(1);
% %checkA = (atan2d(mh1,mh2)+ 360*(mh1<0));
% checkA = (atan(mh1/mh2));
% 
% for i = 1 : size(props)
%     if ~isnan(ci(i)) 
%         diff1 = -ci(y) + ci(i);
%         diff2 = -cj(y) + cj(i);
%     else
%         diff1 = -ci(y) + props(i).Centroid(2); % y
%         diff2 = -cj(y) + props(i).Centroid(1); % x
%     end
%     %angles = [angles; atan2d(diff1,diff2)+ 360*(diff1<0)];
%     angles = [angles; atan(diff1/diff2)];
%     %diff = props(y).Centroid-props(i).Centroid;
%     %if abs(angles(i) - checkA) <= 30
%         if diff1 == 0 && diff2 == 0
%             temp = [temp, 500];
%         else
%             temp = [temp, sqrt(diff1^2 + diff2^2)];
%         end
%    % else
%        % temp = [temp, 500];
%   %  end 
% end
% 
% % 
% % 
% %xma = imcrop(im, props(10).BoundingBox);
% %imshow(xma)
% % ym = y;
% % radtodeg(angles)
% % radtodeg(checkA)
% % for ikj = 1 : size(props)
% %     if radtodeg(abs(abs(checkA) - abs(angles(ikj)))) < 20
% %         ikj
% %     end
% % end
% %temp(9)
% %radtodeg(atan2d(mh1,mh2))
% % testtt = [1; 2];
% % min(testtt)
% % testtt = [testt, nan] ;
% % min(testtt)
% 
% 
% %testtt = zeros(numel(props),1)
% 
% 
% %(atan2d(mh1,mh2)+ 360*(mh1<0))
% % figure;
% % imshow(im); % plot the image
% % hold on;
% % scatter(cj, ci, 5, 'filled') % highlighted the yellow pixels
% % % 
% % figure;
% % imshow(im); % plot the image
% % hold on;
% % scatter(props(10).Centroid(1), props(10).Centroid(2), 5, 'filled') % highlighted the yellow pixels
% 
% %% test 1
% % indeex = 10;
% % xx = imcrop(im, props(indeex).BoundingBox);
% % % imshow(xx)
% % 
% % 
% % red_channel = xx(:, :, 1); 
% % green_channel = xx(:, :, 2); 
% % blue_channel = xx(:, :, 3); 
% % % label pixels of yellow colour
% % yellow_map = green_channel > 150 & red_channel > 150 & blue_channel < 50; 
% % % extract pixels indexes
% % [i_yellow, j_yellow] = find(yellow_map > 0);
% % 
% % p1 = round(props(indeex).BoundingBox(1));
% % p2 = round(props(indeex).BoundingBox(2));
% % p3 = round(props(indeex).BoundingBox(3));
% % p4 = round(props(indeex).BoundingBox(4));
% % 
% % ci = round(p1 + mean(i_yellow));
% % cj = round(p2 + mean(j_yellow));
% % 
% % % c = [i_yellow j_yellow];
% % % round(mean(c))
% % 
% % 
% % % index = find(c(:,1) >= p2 & c(:,1) <= p2+p4 & c(:,2) >= p1 & c(:,2) <= p1+p3);
% % 
% % % % props(1).BoundingBox
% % figure;
% % imshow(im); % plot the image
% % hold on;
% % scatter(ci, cj, 5, 'filled') % highlighted the yellow pixels
% 
% 
% % stus = round(median(index));
% % index(end)
% % % visualise the results
% % figure;
% % imshow(im); % plot the image
% % hold on;
% % scatter(j_yellow(529), i_yellow(529), 5, 'filled') % highlighted the yellow pixels
% % % 
% % props(10).BoundingBox
% % props(8).BoundingBox
% 
% %% test 2
% % iValue = [];
% % 
% % red_channel = im(:, :, 1);
% % green_channel = im(:, :, 2);
% % blue_channel = im(:, :, 3);
% % 
% % % label pixels of yellow colour
% % yellow_map = green_channel > 150 & red_channel > 150 & blue_channel < 50;
% % 
% % % extract pixels indexes
% % [i_yellow, j_yellow] = find(yellow_map > 0);
% % c = [i_yellow j_yellow];
% % 
% % for ii = 1 : size(props)
% %     p1 = round(props(ii).BoundingBox(1));
% %     p2 = round(props(ii).BoundingBox(2));
% %     p3 = round(props(ii).BoundingBox(3));
% %     p4 = round(props(ii).BoundingBox(4));
% %     %index = find(c(:,1) >= p2 & c(:,1) <= p2+p4 & c(:,2) >= p1 & c(:,2) <= p1+p3);
% %     inin = [];
% %     for iii = 1 : size(i_yellow)
% %         if c(iii,2) >= p1 && c(iii,2) <= p1+p3
% %             if c(iii,1) >= p2 && c(iii,1) <= p2+p4
% %                 inin = iii
% %             end
% %         end
% %     end
% %     iValue = [iValue; round(median(inin))];
% % end
% % 
% % %visualise the results
% % figure;
% % imshow(im); % plot the image
% % hold on;
% % for i = 1 : size(props) 
% %     if ~isnan(iValue(i))
% %         scatter(j_yellow(iValue(i)), i_yellow(iValue(i))) % highlighted the yellow pixels
% %     end
% % end
%%
% % figure;
% imshow(im); % plot the image
% hold on;
% scatter(iY, jY, 5, 'filled') % highlighted the yellow pixels

im1 = imread('untitled1.jpg');
im2 = imread('untitled2.jpg');
im3 = imread('untitled3.jpg');
im4 = imread('untitled4.jpg');

% visualize
subplot(2,2,1);
imshow(im1) 
title('Black and White of Hard');
subplot(2,2,2);
imshow(im2) 
title('Easy')
subplot(2,2,3);
imshow(im3) 
title('Medium')
subplot(2,2,4);
imshow(im4) 
title('Hard')


