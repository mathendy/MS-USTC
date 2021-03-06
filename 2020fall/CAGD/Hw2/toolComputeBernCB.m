function toolComputeBernCB(varargin)
%TOOLCOMPUTECB 此处显示有关此函数的摘要
%   此处显示详细说明
hp=evalin('base','hpoly');
h1=evalin('base','h1');
h2=evalin('base','h2');
clearpoints(h1);
clearpoints(h2);
points=hp.getPosition();
tic
result=Bernstein_Basis(points);
toc
hold on
axis manual
h2.addpoints(result(:,1),result(:,2));
drawnow limitrate
end

