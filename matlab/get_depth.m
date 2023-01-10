function depthM = get_depth(dispM, K1, K2, R1, R2, t1, t2)
% GET_DEPTH creates a depth map from a disparity map (DISPM).
    c1 = -(K1*R1)\(K1*t1);
    c2 = -(K2*R2)\(K2*t2);    
    b = norm(c1-c2);
    f = K1(1, 1);
    [height, width] = size(dispM);
    depthM = zeros(height, width);
    for y=1:height
        for x=1:width
            if dispM(y, x) ~= 0
                depthM(y, x) = b*f/dispM(y, x);
            end

    
        end
    end
end

