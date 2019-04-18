function test1 = test_one(interesting_points, bbox)
%% test 1 in the box
test1 = [];
for i = 1 :size(interesting_points,1)
    if (interesting_points(i,2) >= bbox(2) && interesting_points(i,2) <= bbox(2)+bbox(4))
        if (interesting_points(i,1) >= bbox(1) && interesting_points(i,1) <= bbox(1)+bbox(3))
            test1 = [test1; interesting_points(i,:)];
        end
    end
end
end