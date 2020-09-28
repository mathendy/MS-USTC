function toolMarkCB(h, varargin)
im2 = evalin('base', 'im2');
[srcHeight, srcWidth, ~] = size(im2);
evalin('base', 'delete(hpolys);');

set(h, 'Enable', 'off');

hp1 = impoly(subplot(121));
hp1.setVerticesDraggable(false);
mask = createMask(hp1);
numSrc = zeros(sum(sum(mask)),2);
n=0;
for i = 1:srcHeight
    for j = 1:srcWidth
        if mask(i,j)
            n=n+1;
            numSrc(n,:)=[i,j];
        end
    end
end
assignin('base', 'numSrc', numSrc);


hp2 = impoly(subplot(122), hp1.getPosition);
hp2.setVerticesDraggable(false);

assignin('base', 'hpolys', [hp1; hp2]);

set(h, 'Enable', 'on');