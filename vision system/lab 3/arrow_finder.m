%% You should develop a function arrow_finder, which returns the IDs of the arror objects. 
% IDs are from the connected component analysis order. You may use any parameters for your function. 
function x = arrow_finder(y)
x = [];

% using arrow area to determine if the area is an arrow or not
for i = 1 : size(y)
    if (y(i).Area) < 2000
        x = [x, i];
    end
end

end