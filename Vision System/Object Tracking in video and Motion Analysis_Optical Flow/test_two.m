function test2 = test_two(test1, frameRGB, fr, fg, fb)
%% test two
colour_threshold = 1.0e-08;
test2 = [];
for i = 1: size(test1,1)
    if (fr(frameRGB(test1(i,2),test1(i,1),1) + 1) * fg(frameRGB(test1(i,2),test1(i,1),2) + 1) * fb(frameRGB(test1(i,2),test1(i,1),3) + 1) > colour_threshold)
        test2 = [test2; test1(i,:)];
    end
end
end