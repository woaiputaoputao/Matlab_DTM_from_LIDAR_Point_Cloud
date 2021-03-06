function [new_points, avg_error] = filter_by_surf(old_points,surface,tol_positive,tol_negative)

agg_error = 0;

for ii = 1:size(old_points,1)

    x = old_points(ii,1);
    y = old_points(ii,2);
    z = old_points(ii,3);
    
    z_surf = surface([x,y]);
    
    error = z_surf - z;
    
    if error > tol_negative || error < -tol_positive
        old_points(ii,:) = NaN;
    else
        agg_error = agg_error + abs(error);
    end

end

old_points(isnan(old_points(:,3)),:) = [];
new_points = old_points;

avg_error = agg_error / size(new_points,1);

end
