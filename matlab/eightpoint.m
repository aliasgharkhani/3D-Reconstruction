function F = eightpoint(pts1, pts2, M)
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)
% % mean_xy_1 = mean(pts1, 1);
% % mean_xy_2 = mean(pts2, 1);
% % std_xy_1 = std(pts1, 1);
% % std_xy_2 = std(pts2, 1);
% % normalized_pts1 = (pts1 - mean_xy_1)./std_xy_1;
% % normalized_pts2 = (pts2 - mean_xy_2)./std_xy_2;



% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from correspondence '../data/some_corresp.mat'
s = length(pts1);
m1=[pts1(:,1) pts1(:,2) ones(s,1)];
m2=[pts2(:,1) pts2(:,2) ones(s,1)];
N=[1/M   0    0;
    0   1/M   0;
    0    0    1];

%%
% Data Centroid
x1=N*m1'; x2=N*m2';
x1=[x1(1,:)' x1(2,:)'];  
x2=[x2(1,:)' x2(2,:)']; 

% Af=0 
A=[x1(:,1).*x2(:,1) x1(:,2).*x2(:,1) x2(:,1) x1(:,1).*x2(:,2) x1(:,2).*x2(:,2) x2(:,2) x1(:,1) x1(:,2), ones(s,1)];

% Get F matrix
[~, ~, V] = svd(A);
F=reshape(V(:,9), 3, 3)';
% make rank 2 
[U, D, V] = svd(F);
F=U*diag([D(1,1) D(2,2) 0])*V';

% Denormalize
F = N'*F*N;