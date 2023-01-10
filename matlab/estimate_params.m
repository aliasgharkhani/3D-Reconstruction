function [K, R, t] = estimate_params(P)
    [~, ~, V] = svd(P);
    c = V(1:3,4);
    [K, R] = rq(P(:, 1:3));
    T = diag(sign(diag(K)));
    K = K * T;
    R = T * R;
    t = -R*c;
end

