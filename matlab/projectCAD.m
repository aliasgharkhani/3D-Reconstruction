load("../data/PnP.mat", 'X', 'cad', 'image', 'x');
P = estimate_pose(x, X);
[K, R, t] = estimate_params(P);
estimated_x = P * [X;ones(1, size(X, 2))];
estimated_x = estimated_x ./ estimated_x(3, :);
imshow(image);
hold on;
plot(estimated_x(1, :)', estimated_x(2, :)', '.g');
plot(x(1, :)', x(2, :)', 'ob');
hold off;
figure;
vertices = (R*cad.vertices');
trimesh(cad.faces, vertices(1, :), vertices(2, :), vertices(3, :));



verts = [cad.vertices ones(size(cad.vertices, 1), 1)];
verts = verts * P';
verts = verts(:, 1:2) ./ verts(:, 3);
figure;
ax = axes;
imshow(image);
hold on;
patch(ax, 'Faces', cad.faces, 'Vertices', verts, 'FaceColor', 'r', 'FaceAlpha', 0.25, 'EdgeColor', 'none'); 
