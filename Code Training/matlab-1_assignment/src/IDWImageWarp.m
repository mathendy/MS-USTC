function im3 = IDWImageWarp(im, psrc, pdst)
% input: im, psrc, pdst

%% basic image manipulations
% get image (matrix) size
[height, width, ~] = size(im);
[contrp_num,~] = size(psrc);
im3 = im*0;

%% compute wrapped image through the IDW method
u = 2;
%calculate T_i in f_i
T = zeros(2,2,contrp_num);
for j = 1:contrp_num
   delta_psrc=zeros(contrp_num,1);
   p = repmat(psrc(j,:),[contrp_num,1]);
   q = repmat(pdst(j,:),[contrp_num,1]);
   for k = 1:contrp_num
       if k~=j
           delta_psrc(k)=1/(norm(psrc(j,:)-psrc(k,:)))^u;
       end
   end
   w = diag(delta_psrc);
   T(:,:,j)=(((psrc-p)'*w*(psrc-p))\((psrc-p)'*w*(pdst-q)))';
end

%get the wrapped image
for ySrc = 0:height-1
    for xSrc = 0:width-1
        wt =Weight([xSrc,ySrc],psrc);
        fp=zeros(contrp_num,2);
        for j = 1:contrp_num
            fp(j,:)=pdst(j,:)+([xSrc,ySrc]-psrc(j,:))*T(:,:,j)';
        end
        xDst=dot(wt,fp(:,1));
        yDst=dot(wt,fp(:,2));
        if(floor(yDst)+1 > 0 && floor(yDst)+1<height && floor(xDst)+1>0 && floor(xDst)+1<width)
            im3(floor(yDst)+1,floor(xDst)+1,:)=im(ySrc+1,xSrc+1,:);
        end
    end
end


%% weight function
%choose the weight function proposed by Shepard
    function wt = Weight(p,psrc)
        [num,~] = size(psrc);
        wt = zeros(num,1);
        delta = zeros(num,1);
        for i = 1:num
            delta(i) = 1/(norm(psrc(i,:)-p))^u;
        end
        for i = 1:num
            wt(i) = delta(i)/sum(delta);
        end
    end
end