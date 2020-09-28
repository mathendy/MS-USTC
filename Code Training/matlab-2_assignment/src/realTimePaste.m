function realTimePaste(p)
im1 = evalin('base', 'im1');
im2 = evalin('base', 'im2');
hpolys = evalin('base', 'hpolys');
himg = evalin('base', 'himg');
[bgHeight, bgWidth, dim] = size(im1);
roi= hpolys(1).getPosition();
deltaPosition = ceil(p(1,:)-roi(1,:));

num=zeros(bgHeight,bgWidth);
A=evalin('base','A');
numSrc=evalin('base','numSrc');
[n,~]=size(numSrc);

for i = 1:n
    num(numSrc(i,1)+deltaPosition(2),numSrc(i,2)+deltaPosition(1))=i;
end

bgF = zeros(n,dim);
V = zeros(n,dim);
deltaNeighbor = [0,1;0,-1;1,0;-1,0];

for i = 1:bgHeight
    for j = 1:bgWidth
        if num(i,j)~=0
            for k = 1:4
                h = i+deltaNeighbor(k,1);
                w = j+deltaNeighbor(k,2);
                if h>=1&&h<=bgHeight&&w>=1&&w<=bgWidth
                    if num(h,w)==0
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
        end
    end
end
tic
Fp=A\(bgF+V);
toc
imret=im1;
for i = 1:bgHeight
    for j = 1:bgWidth
        if num(i,j)~=0
            imret(i,j,:) = floor(Fp(num(i,j),:));
        end
    end
end
set(himg, 'CData', imret);
end

