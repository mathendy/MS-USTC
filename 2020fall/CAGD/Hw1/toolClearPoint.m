function toolClearPoint(varargin)
h = evalin('base','hToolPoint');
h1=evalin('base','h1');
h2=evalin('base','h2');
hpoints=h.UserData;
for i = 1:numel(hpoints)
    hpoints(i).delete();
end
h.UserData=[];
clearpoints(h1);
clearpoints(h2);
drawnow
legend('off');
axis([-10 10 0 5]);
end

