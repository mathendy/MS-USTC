function coef = polyInterpolation(points)
%input: coordinates of points
%output: coeficients of poly
[num,~] = size(points);
A = points(:,1).^(0:num-1);
coef = A\points(:,2);
end

