function P = estimate_pose(x,X)
%  x is 2 × N matrix denoting the (x, y) coordinates of the N points on the image
%  plane and X is 3 × N matrix denoting the (x, y, z) coordinates of the corresponding points in the 3D world.
%  P is a 3 x 4 matrix
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

