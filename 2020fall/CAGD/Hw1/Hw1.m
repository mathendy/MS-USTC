fig = figure;
h1 = animatedline('Color','r');
h2 = animatedline('Color','b');
axis([-10 10 0 5]);
hToolPoint = uipushtool('CData', reshape(repmat([1 0 0], 100, 1), [10 10 3]), 'TooltipString', 'add point', ...
                        'ClickedCallback', @toolPointAdd, 'UserData', []);
hToolCompute = uipushtool('CData', reshape(repmat([0 0 1], 100, 1), [10 10 3]), 'TooltipString', 'compute interpolation', ...
                       'ClickedCallback', @toolCompute);
hToolClearPoint = uipushtool('CData', reshape(repmat([0 1 0], 100, 1), [10 10 3]), 'TooltipString', 'clear all points', ...
                       'ClickedCallback', @toolClearPoint);
