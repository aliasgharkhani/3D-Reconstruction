function [pts2] = epipolarCorrespondence(im1, im2, F, pts1)
% epipolarCorrespondence:
%   Args:
%       im1:    Image 1
%       im2:    Image 2
%       F:      Fundamental Matrix from im1 to im2
%       pts1:   coordinates of points in image 1
%   Returns:
%       pts2:   coordinates of points in image 2
%
pts1 = [pts1, ones(size(pts1, 1), 1)];
epipole_lines = F*pts1';
patch_size = 60;
[height, width, ~] = size(im1);
pts2 = zeros(size(pts1));
for i=1:size(pts1, 1)
    epipole_line = epipole_lines(:, i);
    point_is_found = false;
    x = round(pts1(i, 1));
    y = round(pts1(i, 2));
    source_patch = im1(max(0, y-(patch_size/2)):min(height, y+(patch_size/2)), max(0, x-(patch_size/2)):min(width, x+(patch_size/2)), :);
    counter = 0;
    while ~point_is_found
        predicted_y = round((-epipole_line(3)-epipole_line(1)*x)/epipole_line(2));
        target_patch = im2(max(0, predicted_y-(patch_size/2)):min(height, predicted_y+(patch_size/2)), max(0, x-(patch_size/2)):min(width, x+(patch_size/2)), :);
        distance = sqrt(sum((target_patch - source_patch) .^ 2, "All"));
        predicted_y_1 = round((-epipole_line(3)-epipole_line(1)*(x+1))/epipole_line(2));
        target_patch_1 = im2(max(0, predicted_y_1-(patch_size/2)):min(height, predicted_y_1+(patch_size/2)), max(0, 1+x-(patch_size/2)):min(width, 1+x+(patch_size/2)), :);
        distance_1 = sqrt(sum((target_patch_1 - source_patch) .^ 2, "All"));
        predicted_y_0 = round((-epipole_line(3)-epipole_line(1)*(x-1))/epipole_line(2));
        target_patch_0 = im2(max(0, predicted_y_0-(patch_size/2)):min(height, predicted_y_0+(patch_size/2)), max(0, 1+x-(patch_size/2)):min(width, 1+x+(patch_size/2)), :);
        distance_0 = sqrt(sum((target_patch_0 - source_patch) .^ 2, "All"));
        if (distance_0 < distance)
            if (distance_0 < distance_1)
                x = x-1;
            elseif (distance_1 < distance_0)
                x = x+1;
            else
                x = x-1;
            end
        elseif (distance_1 < distance)
            if (distance_1 < distance_0)
                x = x+1;
            elseif (distance_0 < distance_1)
                x = x-1;
            else
                x = x+1;
            end
        else
            point_is_found = true;
            pts2(i, 1) = x;
            pts2(i, 2) = predicted_y;
        end
        counter = counter + 1;
        if counter == 40    
            point_is_found = true;
            pts2(i, 1) = x;
            pts2(i, 2) = predicted_y;
        end
    end
    
end