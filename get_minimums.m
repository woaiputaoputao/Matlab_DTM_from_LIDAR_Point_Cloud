function min_pts = get_minimums(ptCloudIn, square_length)

x_spread = ptCloudIn.XLimits(2); % assuming ptCloud starts at 0,0,0
y_spread = ptCloudIn.YLimits(2);

num_x_boxes = ceil(x_spread / square_length);
num_y_boxes = ceil(y_spread / square_length);

minimums_list = zeros(num_x_boxes*num_y_boxes, 3);
mins_index = 1;

for i_x = 1:num_x_boxes
    for i_y = 1:num_y_boxes
        box_x_min = i_x*square_length;
        box_y_min = i_y*square_length;
        
        roi = [box_x_min, box_x_min+square_length; box_y_min, box_y_min+square_length; 0, inf];
        roi_indices = findPointsInROI(ptCloudIn, roi);
        
        boxPointCloud = select(ptCloudIn, roi_indices);
        
        if boxPointCloud.Count > 0
        
            box_z_min = boxPointCloud.ZLimits(1); % should be the minimum z in the box

            box_x_mid = box_x_min + square_length / 2;
            box_y_mid = box_y_min + square_length / 2;

            minimums_list(mins_index,:) = [box_x_mid, box_y_mid, box_z_min];
            mins_index = mins_index +1;
        end
        
    end
    
end

min_pts = minimums_list(1:mins_index-1, :);

end
