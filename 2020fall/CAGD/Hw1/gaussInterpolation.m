function coef = gaussInterpolation(points)
%input: coordinates of points
%output: coeficients of gaussian
[num,~]=size(points);
A=repmat(points(:,1),1,num)-repmat(points(:,1)',num,1);
coef = exp(-A.*A/2)\(points(:,2)-mean(points(:,2)));
end

