function pts3d = triangulate(P1, pts1, P2, pts2 )
% triangulate estimate the 3D positions of points from 2d correspondence
%   Args:
%       P1:     projection matrix with shape 3 x 4 for image 1
%       pts1:   coordinates of points with shape N x 2 on image 1
%       P2:     projection matrix with shape 3 x 4 for image 2
%       pts2:   coordinates of points with shape N x 2 on image 2
%
%   Returns:
%       Pts3d:  coordinates of 3D points with shape N x 3
%
pts3d = ones(size(pts1, 1), 3);
for i=1:size(pts1, 1)
    x1 = pts1(i, 1);
    y1 = pts1(i, 2);
    x2 = pts2(i, 1);
    y2 = pts2(i, 2);
    rowx1 = x1*P1(3, :);
    rowy1 = y1*P1(3, :);
    rowx2 = x2*P2(3, :);
    rowy2 = y2*P2(3, :);
    
    A = [rowx1 - P1(1, :);rowy1 - P1(2, :);rowx2 - P2(1, :);rowy2 - P2(2, :)];
    
    [~, ~, V] = svd(A);    
    three_d = V(:,4);
    three_d = three_d/three_d(4);
    pts3d(i, 1) = three_d(1);
    pts3d(i, 2) = three_d(2);
    pts3d(i, 3) = three_d(3);


end

