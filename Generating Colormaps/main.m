% generate the datasets for experiments #1,#2,#3 (same dataset is used for all 3 expts, 
noise_strength = 8;
delta = [5,1];
number_of_datasets = 80;
% If type=0 (top) -- set flipVertical = true when generating colormaps.
[exp123, exp123_grid] = generate_datasets(noise_strength, delta, number_of_datasets,0);

% generate the datasets for experiment #4
noise_strength = 5;
delta = [8,1];
number_of_datasets = 20
[exp4, exp4_grid] = generate_datasets(noise_strength, delta, number_of_datasets,1);   


% this selects which 20 datasets we used out of the exp123 datasets generated
chosen123 = [1, 4, 6, 9, 10, 13, 20, 24, 27, 28, 30, 32, 37, 46, 47, 49, 52, 54, 69, 78];
data123 = exp123(chosen123);
data123_grid = exp123_grid(chosen123);


% % Experiment 1: (exp123[chosen123], aut/viridis, left/right, dark/light, normal/scrambled, flipVertical) 
% % --- each dataset should produce 16 images. (320 img total)
generate_colormaps(data123, data123_grid, ["autumn","viridis"],true, true, true,true,'IMG_exp1' )

% % Experiment 2 (exp123[chosen123], aut/viridis, left/right, dark/light, flipVertical) 
% % --- each dataset should produce 8 images. (160 img total)
generate_colormaps(data123, data123_grid,["autumn","viridis"],true, true, false,true,'IMG_exp2' )
                    
% % Experiment 3 (exp123[chosen123], hot/viridis, left/right, dark/light, flipVertical) 
% % --- each dataset should produce 8 images. (160 img total)
generate_colormaps(data123, data123_grid,["hot","viridis"],true, true, false,true,'IMG_exp3' )
                
% % Experiment 4 (exp4, hot/viridis, left/right, dark/light, flipVertical) 
% % --- each dataset should produce 8 images. (160 img total)
generate_colormaps(exp4, exp4_grid,["hot","viridis"],true, true, false,false,'IMG_exp4' )

