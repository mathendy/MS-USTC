fig = figure;
h1 = animatedline('Color','r','LineWidth',3);
h2 = animatedline('Color','g','LineWidth',3);
axis([-10 10 0 5]);
title({'Red button: add control points','Blue button: De Casteljau Algorithm','Green button: Bernstein Basis'});
hpoly=[];
hToolMark = uipushtool('CData', reshape(repmat([1 0 0], 100, 1), [10 10 3])...
    , 'TooltipString', 'define control points', 'ClickedCallback', @toolMarkCB);
hToolComputeDe = uipushtool('CData', reshape(repmat([0 0 1], 100, 1), [10 10 3])...
    , 'TooltipString', 'De Casteljau', 'ClickedCallback', @toolComputeDeCB);
hToolComputeBern= uipushtool('CData', reshape(repmat([0 1 0], 100, 1), [10 10 3])...
    , 'TooltipString', 'Bernstein Basis', 'ClickedCallback', @toolComputeBernCB);

