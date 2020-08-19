function [ColormapOut] = PlotColormaps( Data,  Condition, S1name, S2name, figNum, yminimum, ymaximum )

% Data has the following strucutre:
%within the 32 rows, 1-16 is color scale 1, 17-32 is color scale 2. 
%within each color scale, 1-8 is dark hotspot, 9-16 is light hotspot 
%within each hotspot, 1-4 is dark on the left, 5-8 is dark on the right.
%within each lighntess side, 1-2 the scale is oreinted so dark high, 3-4 is dark low 
%within each scale orientation, 1 is greater high, 2 is greater low.    
%columns are subjects (data has already been aggregated across images)

n = size(Data,2);

%separate color scales
S1Data = Data(1:16,:);
S2Data = Data(17:32,:); 

%combine whether darker was on the left or right for each color scale
S1LR(1:4,:) =  (S1Data(1:4,:) + S1Data(5:8,:))/2; %hotspot is dark
S1LR(5:8,:) =  (S1Data(9:12,:) + S1Data(13:16,:))/2; %hotspot is light

S2LR(1:4,:) =  (S2Data(1:4,:) + S2Data(5:8,:))/2; %hotspot is dark
S2LR(5:8,:) =  (S2Data(9:12,:) + S2Data(13:16,:))/2; %hotspot is light

%rows are currently dark hotspot(1-4) light hot spot (5-8)
%within those, scale orientation goes dark high (1-2) dark low(3-4)
%with in those, legend text is greater-high (1), greater low (2)

%we want to make it so that the order within each hotspot is
%D+, L+ when greater is high, and D+, l+ when greater is low. 
Ord = [1 3 4 2   5 7 8 6]; 

S1Ord = S1LR(Ord,:); 
S2Ord = S2LR(Ord,:); 

ColormapOut = [S1Ord',S2Ord'];

S1Avg = mean(S1Ord,2);
S2Avg = mean(S2Ord,2);

%% Averaging over legend text for each color scale

S1HiLo =  (S1Ord([1 2 5 6], :) + S1Ord([3 4 7 8], :))/2;
S2HiLo =  (S2Ord([1 2 5 6], :) + S2Ord([3 4 7 8], :))/2;

S1HiLoAvg = mean(S1HiLo,2);
S2HiLoAvg = mean(S2HiLo,2);

%% CALCULATING ERROR (from Cousineau (2005))

% subtract each subject's overall mean to eliminate subject over all
% biases, and then add back in grand mean 
 
SubjMean = mean(ColormapOut,2)';
GrandMean = mean(SubjMean);

%error bars for data averaged over legend text
 S1HiLoAdjVals = S1HiLo - SubjMean + GrandMean;
 S2HiLoAdjVals = S2HiLo - SubjMean + GrandMean;

 S1HiLo_SEM = std(S1HiLoAdjVals')./sqrt(n); %error bars for color scale 1
 S2HiLo_SEM = std(S2HiLoAdjVals')./sqrt(n); %error bars for color scale 2

%error bars for data seprated by legend text
 S1AdjVals = S1Ord - SubjMean + GrandMean; 
 S2AdjVals = S2Ord - SubjMean + GrandMean; 

 S1_SEM = std(S1AdjVals')./sqrt(n); %error bars for color scale 1
 S2_SEM = std(S2AdjVals')./sqrt(n); %error bars for color scale 2
    
%% Plot data separately for color scales, averaged over legend text
S1HiLoPlot = reshape(S1HiLoAvg,2,2)';
S2HiLoPlot = reshape(S2HiLoAvg,2,2)';

S1HiLo_SEMplot = reshape(S1HiLo_SEM,2,2)';
S2HiLo_SEMplot = reshape(S2HiLo_SEM,2,2)';

leg = {'D+', 'L+'};
Cond = {'D Hotspt'; 'L Hotspt'};
Gray = [.5 .5 .5];
Disp = [-.15, .15];

figure (figNum)

subplot(1,2,1)
    hold on
    
    b = bar(S1HiLoPlot, 'FaceColor', 'flat');
    b(1).CData = [0 0 0];
    b(2).CData = [1 1 1];
    
    colormap ('gray')
    
    for row = 1:2
        for col = 1:2
            plot([row+Disp(col) row+Disp(col)], [S1HiLoPlot(row,col) - S1HiLo_SEMplot(row,col), S1HiLoPlot(row,col) + S1HiLo_SEMplot(row,col)],'Color', Gray, 'LineWidth', 1 )
            plot([row+Disp(col)-.04 row+Disp(col)+.04], [S1HiLoPlot(row,col) - S1HiLo_SEMplot(row,col), S1HiLoPlot(row,col) - S1HiLo_SEMplot(row,col)],'Color', Gray, 'LineWidth', 1 )
            plot([row+Disp(col)-.04 row+Disp(col)+.04], [S1HiLoPlot(row,col) + S1HiLo_SEMplot(row,col), S1HiLoPlot(row,col) + S1HiLo_SEMplot(row,col)],'Color', Gray, 'LineWidth', 1 )
        end
    end
    title (strcat (S1name , Condition) )
    legend(leg)
    ylim([yminimum ymaximum])
    ylabel('Mean Response Time (ms)')
    set(gca, 'XTickLabel',Cond,'XTick',[1:2], 'FontSize', 9.5)
    
    
subplot(1,2,2)
hold on
    b = bar(S2HiLoPlot, 'FaceColor', 'flat');
    b(1).CData = [0 0 0];
    b(2).CData = [1 1 1];
    
     for row = 1:2
        for col = 1:2
            plot([row+Disp(col) row+Disp(col)], [S2HiLoPlot(row,col) - S2HiLo_SEMplot(row,col), S2HiLoPlot(row,col) + S2HiLo_SEMplot(row,col)],'Color', Gray, 'LineWidth', 1 )
            plot([row+Disp(col)-.04 row+Disp(col)+.04], [S2HiLoPlot(row,col) - S2HiLo_SEMplot(row,col), S2HiLoPlot(row,col) - S2HiLo_SEMplot(row,col)],'Color', Gray, 'LineWidth', 1 )
            plot([row+Disp(col)-.04 row+Disp(col)+.04], [S2HiLoPlot(row,col) + S2HiLo_SEMplot(row,col), S2HiLoPlot(row,col) + S2HiLo_SEMplot(row,col)],'Color', Gray, 'LineWidth', 1 )
        end
     end
    
    title (strcat (S2name , Condition) )
    legend(leg)
    ylim([ yminimum ymaximum])
    ylabel('Mean Response Time (ms)')
    legend(leg)
    set(gca, 'XTickLabel',Cond,'XTick',[1:2], 'FontSize', 9.5)
    

    set(gcf, 'Position',  [529 1041 438 120])
    


%% Plot data separated by color scales and legend text
S1Prep = reshape(S1Avg,2,4)';
S2Prep = reshape(S2Avg,2,4)';

S1_SEMprep = reshape(S1_SEM,2,4)';
S2_SEMprep = reshape(S2_SEM,2,4)';

%re-order the rows so that they are grouped by hotspot lightness not leg
%text
Ord2 = [1 3 2 4];

S1Plot = S1Prep(Ord2,:);
S2Plot = S2Prep(Ord2,:);

S1_SEMplot = S1_SEMprep(Ord2,:);
S2_SEMplot = S2_SEMprep(Ord2,:);

Cond = {'Dhs/GreatHi'; 'Lhs/GreatHi'; 'Dhs/GreatLo'; 'Lhs/GreatLo'};
 
figure (figNum*10)
colormap ('gray')
subplot(1,2,1)
hold on
    b = bar(S1Plot, 'FaceColor', 'flat');
    b(1).CData = [0 0 0];
    b(2).CData = [1 1 1];
    
     for row = 1:4
        for col = 1:2
            plot([row+Disp(col) row+Disp(col)], [S1Plot(row,col) - S1_SEMplot(row,col), S1Plot(row,col) + S1_SEMplot(row,col)],'Color', Gray, 'LineWidth', 1 )
            plot([row+Disp(col)-.06 row+Disp(col)+.06], [S1Plot(row,col) - S1_SEMplot(row,col), S1Plot(row,col) - S1_SEMplot(row,col)],'Color', Gray, 'LineWidth', 1 )
            plot([row+Disp(col)-.06 row+Disp(col)+.06], [S1Plot(row,col) + S1_SEMplot(row,col), S1Plot(row,col) + S1_SEMplot(row,col)],'Color', Gray, 'LineWidth', 1 )
        end
    end
    
    
    ylim([yminimum 1400])
    title (strcat (S1name , Condition) )
    legend(leg)
    set(gca, 'XTickLabel',Cond,'XTick',[1:4], 'FontSize', 9.5)
    ylabel('Mean RT (ms)')
    
    
subplot(1,2, 2)
hold on

    b = bar(S2Plot, 'FaceColor', 'flat');
    b(1).CData = [0 0 0];
    b(2).CData = [1 1 1];
    
     for row = 1:4
        for col = 1:2
            plot([row+Disp(col) row+Disp(col)], [S2Plot(row,col) - S2_SEMplot(row,col), S2Plot(row,col) + S2_SEMplot(row,col)],'Color', Gray, 'LineWidth', 1 )
            plot([row+Disp(col)-.06 row+Disp(col)+.06], [S2Plot(row,col) - S2_SEMplot(row,col), S2Plot(row,col) - S2_SEMplot(row,col)],'Color', Gray, 'LineWidth', 1 )
            plot([row+Disp(col)-.06 row+Disp(col)+.06], [S2Plot(row,col) + S2_SEMplot(row,col), S2Plot(row,col) + S2_SEMplot(row,col)],'Color', Gray, 'LineWidth', 1 )
        end
     end
    
    ylim([yminimum 1400])
    title (strcat (S2name , Condition) )
    legend(leg)
    set(gca, 'XTickLabel',Cond,'XTick',[1:4], 'FontSize', 9.5)
    
    set(gcf, 'Position',  [968 1039 718 123])    
    ylabel('Mean RT (ms)')
    
end

