function toolCompute(varargin)
hpoints = evalin('base','hToolPoint.UserData');
h1=evalin('base','h1');
h2=evalin('base','h2');
clearpoints(h1);
clearpoints(h2);
drawnow
points = zeros(numel(hpoints),2);
for i = 1:numel(hpoints)
    set(hpoints(i),'Visible','on');
    points(i,:)=hpoints(i).getPosition();
end
[n,~]=size(points);
coef1=polyInterpolation(points);
coef2=gaussInterpolation(points);

x=(-10:0.05:10)';
[~,k]=size(x);

y1=(x.^(0:n-1))*coef1;
A=repmat(x,1,n)-repmat(points(:,1)',k,1);
y2=exp(-A.*A/2)*coef2+mean(points(:,2));
hold on
axis auto
addpoints(h1,x,y1);
addpoints(h2,x,y2);
drawnow limitrate

legend('poly\_interpolation','gauss\_interpolation');
hold off

end

