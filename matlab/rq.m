function [R, Q] = rq(M)
    [Q,R] = qr(flipud(M)');
    R = rot90(R', 2);
%     R = flipud(R');
%     R = fliplr(R);

    Q = Q';   
    Q = flipud(Q);