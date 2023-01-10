function P = estimate_pose(x, X)
% ESTIMATE_POSE computes the pose matrix (camera matrix) P given 2D and 3D
% points.
%   Args:
%       x: 2D points with shape [2, N]
%       X: 3D points with shape [3, N]

x = x';
X = X';
n = size(x, 1);
xs = x(:, 1); ys = x(:,2); Xs = X(:, 1); Ys = X(:, 2); Zs = X(:, 3);
rows0 = zeros(n, 4);
rowsxy = [Xs, Ys, Zs, ones(n, 1)];
hx = [rowsxy, rows0, -xs.*Xs, -xs.*Ys, -xs.*Zs, -xs];
hy = [rows0, rowsxy, -ys.*Xs, -ys.*Ys, -ys.*Zs, -ys];
A = [hx; hy];
if n == 4
    [~, ~, V] = svd(A);
else
    [~, ~, V] = svd(A, 'econ');
end
P = (reshape(V(:,12), 4, 3)).';
end

