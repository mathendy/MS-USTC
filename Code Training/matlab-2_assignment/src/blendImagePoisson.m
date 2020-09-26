function imret = blendImagePoisson(im1, im2, roi, targetPosition)

% input: im1 (background), im2 (foreground), roi (in im2), targetPosition (in im1)

[srcHeight, srcWidth, dim] = size(im2);
[bgHeight, bgWidth, ~] = size(im1);
deltaPosition = targetPosition(1,:)-roi(1,:);

mask = false(bgHeight,bgWidth);
for i = 1:bgHeight
    for j = 1:bgWidth
        in = inpolygon(j,i,targetPosition(:,1),targetPosition(:,2));
        if(in==1)
            mask(i,j)=true;
        end
    end
end

num=zeros(bgHeight,bgWidth);
n = 0;
for i = 1:bgHeight
    for j = 1:bgWidth
        if mask(i,j)
            n=n+1;
            num(i,j)=n;
        end
    end
end

A = sparse(n,n);
bgF = zeros(n,dim);
V = zeros(n,dim);
deltaNeighbor = [0,1;0,-1;1,0;-1,0];

for i = 1:bgHeight
    for j = 1:bgWidth
        if mask(i,j)
            Np=0;
            for k = 1:4
                h = i+deltaNeighbor(k,1);
                w = j+deltaNeighbor(k,2);
                if h>=1&&h<=bgHeight&&w>=1&&w<=bgWidth
                    Np=Np+1;
                    if mask(h,w)
                        A(num(i,j),num(h,w)) = -1;
                    else
                        for l = 1:dim
                            bgF(num(i,j),l)=bgF(num(i,j),l)+double(im1(h,w,l));
                        end
                    end
                    srch=h-deltaPosition(2);
                    srcw=w-deltaPosition(1);
                    srci=i-deltaPosition(2);
                    srcj=j-deltaPosition(1);
                    if srch>=1&&srch<=srcHeight&&srcw>=1&&srcw<=srcWidth
                        for l = 1:dim
                            tmpf=double(im1(i,j,l))-double(im1(h,w,l));
                            tmpg=double(im2(srci,srcj,l))-double(im2(srch,srcw,l));
                            if abs(tmpf)>abs(tmpg)
                                V(num(i,j),l)=V(num(i,j),l)+tmpf;
                            else
                                V(num(i,j),l)=V(num(i,j),l)+tmpg;
                            end
                        end
                    end
                end     
            end
            A(num(i,j),num(i,j)) = Np;
        end
    end
end

Fp=A\(bgF+V);
imret=im1;
for i = 1:bgHeight
    for j = 1:bgWidth
        if mask(i,j)
            imret(i,j,:) = floor(Fp(num(i,j),:));
        end
    end
end



%% TODO: compute blended image

