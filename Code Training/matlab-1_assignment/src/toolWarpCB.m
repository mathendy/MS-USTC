function toolWarpCB(varargin)

hlines = evalin('base', 'hToolPoint.UserData');
im = evalin('base', 'im');
himg = evalin('base', 'himg');

p2p = zeros(numel(hlines)*2,2); 
for i=1:numel(hlines)
    p2p(i*2+(-1:0),:) = hlines(i).getPosition();
end
tic
im2 = IDWImageWarp(im, p2p(1:2:end,:), p2p(2:2:end,:));
toc
set(himg, 'CData', im2);