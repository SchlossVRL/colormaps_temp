% This script generates the images based on the data from
% generate_datasets.m

% Images Naming Convention:
% colormap(autumn/hot/vir)_darkArea(l/r: left/ right)_spatialArrangement(concentric/grid)_whereTheHotspotLies(light/dark)_replicationNum

function generate_colormaps(dataset, dataset_grid, cmaps, leftright, darklight, scramble, flipVertical, output_folder)

    % dataset   : cell array of size number_of_datasets containing
    %             underlying data.
    % dataset_grid: cell array of size number_of_datasets containing
    %               randomized downsampled underlying data.
    % cmaps     : colormap to be used for the images
    % leftright : True/ False - the data matrix is created to have hotspots in 
    %             the top left region of the image. If True, the matrix is also 
    %             flipped horizontally to get hotspots in the right region.
    % darklight : True/ False - If True, the data used to create images is also 
    %             negated to get light regions as hotspot.
    % scramble  : True/ False - If True, creates grid version of the images 
    %             by downsampling and andomizing each half of the image
    %             data.
    % flipVertical: True/ False - If True, the data in half of the chosen number of 
    %             datasets are flipped vertically to get the images with hotspots in the 
    %             bottom region (if all data was created Top Heavy). It is set to
    %             False if the data curated was bottom-heavy for half the 
    %             datasets in generate_datasets.m
    % output_folder: Output folder for the images for the experiment.
   
    fold_num = 0;version=0;
    mkdir(output_folder);
    k = 0;
    fprintf(strcat("Creating images for ",output_folder,"\n"));
    for i=1:size(dataset,1)
        k = k+1; % keeps track of dataset number
        Fp = dataset{i};
        fold_num = fold_num+1; version = version+1;
        %mkdir(output_folder, num2str(fold_num));
        %dir = strcat(output_folder,'/',num2str(fold_num),'/');
        dir = strcat(output_folder,'/');
        if scramble == true
            Fp_sq = dataset_grid{i};
        end
        param1 = 'r'; param2 = 'l'; % for figure: (where the darker region is: left/ right)
        if flipVertical == true && k > size(dataset,1)/2
            % Half the datasets are flipped vertically
            Fp = flipdim(Fp ,1); % flips vertically
            if scramble == true
                Fp_sq = flipdim(Fp_sq ,1);
            end
        elseif flipVertical == false && k > size(dataset,1)/2
            param1 = 'l'; param2 = 'r';
        end   
        
        for j=1:2
            if leftright == true && j == 2 % runs 2nd time for creating mirror images 
                Fp = flipdim(Fp ,2); % flips horizontally
                if scramble == true
                    Fp_sq = flipdim(Fp_sq ,2); 
                end
                temp = param1;param1 = param2;param2 = temp;
            elseif leftright == false && j == 2
                    break;
            end
            for c = 1:size(cmaps,2)
                close all;
                cmap = cmaps(c);colmap=cmaps(c);
                if cmap == 'viridis'
                    colmap='vir';
                end
                imgName = strcat(dir,colmap,'_',param1,'_conc_light_',num2str(version),'.bmp');
                createImage('conc',Fp,cmap,imgName);
                if darklight == true
                    imgName = strcat(dir,colmap,'_',param2,'_conc_dark_',num2str(version),'.bmp');
                    createImage('conc',-Fp,cmap,imgName);
                end
                if scramble == true
                    imgName = strcat(dir,colmap,'_',param1,'_grid_light_',num2str(version),'.bmp');
                    createImage('grid',Fp_sq,cmap,imgName);
                    if darklight == true
                        imgName = strcat(dir,colmap,'_',param2,'_grid_dark_',num2str(version),'.bmp');
                        createImage('grid',-Fp_sq,cmap,imgName);
                    end
                end
            end
        end
        
    end
    fprintf("Done.\n")
end


function createImage(type,data,cmap,imgName)
    h = figure('Visible', 'off') ;
    %set(gca,'LooseInset',get(gca,'TightInset'));
    if type == 'conc'
        contourf(data,8,'LineStyle','none');
        colormap(h,cmap);
    elseif type == 'grid'
         imagesc(data);colormap(h,cmap);
         set(gca,'YDir','normal')
    end
    axis image; axis off;
    f=getframe; 
    imwrite(f.cdata,imgName);
    %saveas(gcf,imgName);
    close all;
end 







          

            
 
