function toolMarkCB(varargin)
hpoly=evalin('base','hpoly');
h1=evalin('base','h1');
h2=evalin('base','h2');
h1.clearpoints();
h2.clearpoints();
delete(hpoly);
hp=impoly;
assignin('base','hpoly',hp);
end

