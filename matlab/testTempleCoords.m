% A test script using templeCoords.mat
%
% Write your code here
%
Image1 = imread("../data/im1.png");
Image2 = imread("../data/im2.png");
someCorresp = load("../data/someCorresp.mat");
F = eightpoint(someCorresp.pts1, someCorresp.pts2, someCorresp.M);
templeCoords = load("../data/templeCoords.mat");
pts2 = epipolarCorrespondence(Image1, Image2, F, templeCoords.pts1);
intrinsics = load("../data/intrinsics.mat");
E = essentialMatrix(F, intrinsics.K1, intrinsics.K2);
M2s = camera2(E);
P1 = intrinsics.K1*[eye(3), zeros(3, 1)];
max_number_of_positives = 0;
for i=1:4
    extrinsic_matrice = M2s(:, :, i);
    P2 = intrinsics.K2 * extrinsic_matrice;
    aux_Pts3d = triangulate(P1, templeCoords.pts1, P2, pts2);
    number_of_positives = sum(aux_Pts3d(:, 3)>=0);
    if number_of_positives > max_number_of_positives
        max_number_of_positives = number_of_positives;
        Pts3d = aux_Pts3d;
        R2 = extrinsic_matrice(:, 1:3);
        t2 = extrinsic_matrice(:, 4);
        best_P2 = P2;
        best_3d_points = aux_Pts3d;
    end
end
plot3(best_3d_points(:, 1), best_3d_points(:, 2), best_3d_points(:, 3), ".");
axis equal;
% save extrinsic parameters for dense reconstruction
R1 = eye(3);
t1 = zeros(3, 1);
save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');
