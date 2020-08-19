

%% Load in data
% within the 32 rows, 1-16 is 'autumn' or 'hot'color scale (depending on exp), 17-32 is 'viridis' color scale. 
    % within each color scale, 1-8 is dark in the hotspot, 9-16 is light in the
    % hot spot (for concentric, for grid it is scrambled versions of the same colors).
    % within each hotspot, the 1-4 is dark on the left, 5-8 is dark on the right.
    % within each lighntess side, 1-2 the scale is oreinted so dark high, 3-4 is dark low 
    % within each scale orientation, 1 is greater high, 2 is greater low.    
% columns are repititons (with different images). 
% 3rd dimension is participants 


load Exp1_ColormapSpace.mat %Exp 1: unreliable hotspot, with autumn and viridis color scales
load Exp2_ColormapSpaceHS.mat %Exp 2: reliable hotspot, with autumn and viridis color scales
load Exp3_ColormapSpaceHHS.mat %Exp 3: reliable hotspot, with hot and viridis color scales
load Exp4_ColormapSpaceHSSmall.mat %Exp 4: reliable hotspot, small, with hot and viridis color scales



   
%% Organize and plot data
    Exp1_OrganizeColormapSpace
    Exp2_OrganizeColormapHS
    Exp3_OrganizeColormapHHS
    Exp4_OrganizeColormapHSSmall
    
  %% Functions needed
    
    % PruneRTs 
    % PruneRTs_HSLoc
    % PruneRTs_HS
    
    % PlotColormaps
    % PlotColormapsHS
    % PlotHSlocation













