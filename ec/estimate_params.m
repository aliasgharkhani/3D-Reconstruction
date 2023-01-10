function [K, R, t] = estimate_params(P)
% ESTIMATE_PARAMS computes the intrinsic K, rotation R and translation t from
% given camera matrix P.

    [~, ~, V] = svd(P);
    c = V(1:3,4);
    [K, R] = rq(P(:, 1:3));
    T = diag(sign(diag(K)));
    K = K * T;
    R = T * R;
    t = -R*c;
end

