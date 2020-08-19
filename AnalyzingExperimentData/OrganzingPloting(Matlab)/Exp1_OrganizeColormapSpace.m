% "Conc" is the condition referred to as "hotspot" in the paper
% "Grid" is the condition referred to as "scrambled" in the paper

% "GC" refers to particpants who did trials for Grid 1st and Conc 2nd
% "CG" refers to particpants who did trials for Conc 1st and Grid 2nd

%% CHECK OVERALL ACCURACY

% combine grid and concentric conditions to check accuracy
GCacc = [Grid.LoadAcc_GC, Conc.LoadAcc_GC];
CGacc = [Grid.LoadAcc_CG, Conc.LoadAcc_CG];

% calculate overall accruacy
GCpropAcc = squeeze(mean(mean(GCacc,1),2));
CGpropAcc = squeeze(mean(mean(CGacc,1),2));

% check if accuracy is > 90%
GChigh = find(GCpropAcc > .9);
CGhigh = find(CGpropAcc > .9);

% Grab RT data from people who were greater that 90% accurate
Grid.RT_GC = Grid.LoadRT_GC(:,:,GChigh);    
Grid.RT_CG = Grid.LoadRT_CG(:,:,CGhigh);   

Conc.RT_GC = Conc.LoadRT_GC(:,:,GChigh);    
Conc.RT_CG = Conc.LoadRT_CG(:,:,CGhigh);   

% Grab accuracy data from people who were greater that 90% accurate
Grid.Acc_GC = Grid.LoadAcc_GC(:,:,GChigh);    
Grid.Acc_CG = Grid.LoadAcc_CG(:,:,CGhigh);   

Conc.Acc_GC = Conc.LoadAcc_GC(:,:,GChigh);    
Conc.Acc_CG = Conc.LoadAcc_CG(:,:,CGhigh);  


%% PRUNE RTs

[Grid.AvgRTsubj_GC, Conc.AvgRTsubj_GC] = PruneRTs(Grid.RT_GC, Conc.RT_GC, Grid.Acc_GC, Conc.Acc_GC);
[Grid.AvgRTsubj_CG, Conc.AvgRTsubj_CG] = PruneRTs(Grid.RT_CG, Conc.RT_CG, Grid.Acc_CG, Conc.Acc_CG);

%% MAKE FIGURES FOR COLORMAP TASK

[Grid.output_GC] = PlotColormaps( Grid.AvgRTsubj_GC, 'Grid (1st)', 'Autumn', 'Viridis', 1, 800, 1300);
[Grid.output_CG] = PlotColormaps( Grid.AvgRTsubj_CG, 'Grid (2nd)', 'Autumn', 'Viridis', 11,800, 1300);
[Conc.output_GC] = PlotColormaps( Conc.AvgRTsubj_GC, 'Conc. (2nd)', 'Autumn', 'Viridis', 111, 800, 1300);
[Conc.output_CG] = PlotColormaps( Conc.AvgRTsubj_CG, 'Conc. (1st)', 'Autumn', 'Viridis', 1111, 800, 1300);

%including data from both blocks in a single figure
PlotColormaps([Grid.AvgRTsubj_GC, Grid.AvgRTsubj_CG], 'Grid (both)', 'Autumn', 'Viridis', 101, 950, 1100);
PlotColormaps([Conc.AvgRTsubj_GC, Conc.AvgRTsubj_CG], 'Conc (both)', 'Autumn', 'Viridis', 1011, 950, 1100);

Grid_out = [Grid.output_GC; Grid.output_CG]; %60 subjects x 16 conditions
Conc_out = [Conc.output_CG; Conc.output_GC]; %60 subjects x 16 conditions

dlmwrite('Exp1_Scrambled_out.csv', Grid_out)
dlmwrite('Exp1_Hotspot_out.csv', Conc_out)
