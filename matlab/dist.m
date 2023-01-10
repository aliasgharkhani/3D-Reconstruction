function disparsity = dist(im1, im2, position1, position2, w)
%     position1 -> (x1, y1)
%     position2 -> (x2, y2)
    [height, width] = size(im1);
    patch1 = im1(max(1, position1(2)-w):min(height, position1(2)+w), max(1, position1(1)-w):min(width, position1(1)+w));
    patch2 = im2(max(1, position2(2)-w):min(height, position2(2)+w), max(1, position2(1)-w):min(width, position2(1)+w));
    disparsity = conv2((patch1-patch2).^2, ones(size(patch2)), 'valid');
    
    
end

