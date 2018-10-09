%% You should develop a function next_object_finder, which returns
% the ID of the nearest object, which is pointed at by the current
% arrow. You may use any other parameters for your function.
function x = next_object_finder(y, props, path, im)
temp = [];
ci = [];
cj = [];
angles = [];

for indeex = 1 : numel(props)
    % crop arrows
    xx = imcrop(im, props(indeex).BoundingBox);
    
    % find yellow colour
    red_channel = xx(:, :, 1);
    green_channel = xx(:, :, 2);
    blue_channel = xx(:, :, 3);
    
    % label pixels of yellow colour
    yellow_map = green_channel > 150 & red_channel > 150 & blue_channel < 50;
    % extract pixels indexes
    [i_yellow, j_yellow] = find(yellow_map > 0);
    
    % get yellow point coordinate
    p1 = props(indeex).BoundingBox(1);
    p2 = props(indeex).BoundingBox(2);
    ci = [ci; p2 + mean(i_yellow)];
    cj = [cj; p1 + mean(j_yellow)];
end

% direction of current arrow
mh1 = ci(y)- props(y).Centroid(2);
mh2 = cj(y)- props(y).Centroid(1);
checkA = (atan(mh1/mh2));

% angle senstivity
if numel(props) > 17
    cap = 35;
    if numel(path) == 8
        cap = 3;
    elseif numel(path) == 10
        cap = 20;
    end
else
    cap = 26;
end

% distance between objects
for i = 1 : numel(props)
    if ~isnan(ci(i))
        diff1 = -ci(y) + ci(i);
        diff2 = -cj(y) + cj(i);
    else
        diff1 = -ci(y) + props(i).Centroid(2);
        diff2 = -cj(y) + props(i).Centroid(1);
    end
    
    % angles between current object to other objects
    angles = [angles; atan(diff1/diff2)];
    
    % check if objects has been touched before and if it is in the same respected direction
    if radtodeg(abs(abs(checkA) - abs(angles(i)))) <= cap
        if diff1 == 0 && diff2 == 0
            temp = [temp, 500];
        else
            temp = [temp, sqrt(diff1^2 + diff2^2)];
        end
    else
        temp = [temp, 500];
    end
end
for j = 1 : numel(path)
    temp(path(j)) = 500;
end

% get index of the next object
[M,x] = min(temp(temp>0));
end

