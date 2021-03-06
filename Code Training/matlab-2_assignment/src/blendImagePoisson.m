function imret = blendImagePoisson(im1, im2, roi, targetPosition)

% input: im1 (background), im2 (foreground), roi (in im2), targetPosition (in im1)
[bgHeight, bgWidth, dim] = size(im1);
deltaPosition = targetPosition(1,:)-roi(1,:);
hp2=evalin('base','hpolys(2)');
numSrc=evalin('base','numSrc');
[n,~]=size(numSrc);
A=sparse(n,n);
num=zeros(bgHeight,bgWidth);
for i = 1:n
    num(numSrc(i,1)+deltaPosition(2),numSrc(i,2)+deltaPosition(1))=i;
end

bgF = zeros(n,dim);
V = zeros(n,dim);
deltaNeighbor = [0,1;0,-1;1,0;-1,0];

for i = 1:bgHeight
    for j = 1:bgWidth
        if num(i,j)~=0
            Np=0;
            for k = 1:4
                h = i+deltaNeighbor(k,1);
                w = j+deltaNeighbor(k,2);
                if h>=1&&h<=bgHeight&&w>=1&&w<=bgWidth
                    Np=Np+1;
                    if num(h,w)~=0
                        A(num(i,j),num(h,w)) = -1;
                    else
                        for l = 1:dim
                            bgF(num(i,j),l)=bgF(num(i,j),l)+double(im1(h,w,l));
                        end
                    end
                    for l = 1:dim
                        tmpf=double(im1(i,j,l))-double(im1(h,w,l));
                        srch=numSrc(num(i,j),1)+deltaNeighbor(k,1);
                        srcw=numSrc(num(i,j),2)+deltaNeighbor(k,2);
                        tmpg=double(im2(numSrc(num(i,j),1),numSrc(num(i,j),2),l))-double(im2(srch,srcw,l));
                        if abs(tmpf)>abs(tmpg)
                            V(num(i,j),l)=V(num(i,j),l)+tmpf;
                        else
                            V(num(i,j),l)=V(num(i,j),l)+tmpg;
                        end
                    end
                end     
            end
            A(num(i,j),num(i,j)) = Np;
        end
    end
end
dA=decomposition(A,'chol');
assignin('base','A',dA);
Fp=dA\(bgF+V);
imret=im1;
for i = 1:bgHeight
    for j = 1:bgWidth
        if num(i,j)~=0
            imret(i,j,:) = floor(Fp(num(i,j),:));
        end
    end
end
addNewPositionCallback(hp2,@(p) realTimePaste(p));



%% TODO: compute blended image

