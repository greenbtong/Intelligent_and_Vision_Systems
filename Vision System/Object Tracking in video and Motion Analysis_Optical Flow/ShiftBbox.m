function shifted_bbox = ShiftBbox(input_bbox, new_center)

bbox_corner = int32(new_center) - int32(input_bbox(3:4) / 2);

shifted_bbox = [bbox_corner, input_bbox(3:4)];

end