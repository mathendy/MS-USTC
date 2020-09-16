function im2 = RBFImageWarp(im, psrc, pdst)

% input: im, psrc, pdst


%% basic image manipulations
% get image (matrix) size
[height, width, ~] = size(im);

im2 = im*0;

[contrp_num,~] = size(psrc);

%% compute the wrapped image through RBF method
u = 1;
%calculate r_i
R = diag(repelem(inf,contrp_num));
for i = 1:contrp_num
    for j = 1:contrp_num
        if i<j
            R(i,j)=norm(psrc(i,:)-psrc(j,:));
        else
            if i>j
                R(i,j)=R(j,i);
            end
        end
    end
end
r = min(R,[],2);

%simply choose A=I, a=[0;0] in Aq+a
%then calculate alpha_i
b = pdst - psrc;
G = zeros(contrp_num,contrp_num);
for i = 1:contrp_num
    for j = 1:contrp_num
        G(i,j)=sqrt(norm(psrc(i,:)-psrc(j,:))^2+r(j)^2)^u;
    end
end
alpha = G\b;

%compute wrapped image
for j = 0:height-1
    for i = 0:width-1
        g = zeros(contrp_num,1);
        for k = 1:contrp_num
            g(k) = sqrt(norm([i,j]-psrc(k,:))^2+r(k)^2)^u;
        end
        xDst=dot(alpha(:,1),g)+i;
        yDst=dot(alpha(:,2),g)+j;
        if(floor(yDst)+1 > 0 && floor(yDst)+1<height && floor(xDst)+1>0 && floor(xDst)+1<width)
            im2(floor(yDst)+1,floor(xDst)+1,:)=im(j+1,i+1,:);
        end
    end
end
