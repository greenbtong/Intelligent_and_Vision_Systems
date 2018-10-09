function test3 = test_three(test2)
%test 3
proximity_threshold = 3;
keep = [];
test3 = test2;
for i = size(test3,1): -1: 1
    for j = i: -1: 1
        if i > j
            diff = test3(i,:) - test3(j,:);
            dist = sqrt(diff(1)^2 + diff(2)^2);
            if dist < proximity_threshold
                test3(j,:) = [];
                break
            end
        end
    end
end
end