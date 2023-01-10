function dispM = get_disparity(im1, im2, maxDisp, windowSize)
% GET_DISPARITY creates a disparity map from a pair of rectified images im1 and
%   im2, given the maximum disparity MAXDISP and the window size WINDOWSIZE.
dispM = zeros(size(im1));
[height, width] = size(im1);
w = round((windowSize-1)/2);
for y=1:height
    for x=1:width
        min_dist = inf;
        for d=0:min(max(x-w-1, 0), min(max(width-x-w, 0), maxDisp))
            distance = dist(im1, im2, [x, y], [x-d, y], w);
            if distance < min_dist
                min_dist = distance;
                best_d = d;
            end
        end
        dispM(y, x) = best_d;
    end

end