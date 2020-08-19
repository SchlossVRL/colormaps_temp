% This script creates the underlying data for the set of experiments
% mentioned in the paper.

function [datasets, datasets_sq] = generate_datasets(noise_strength, delta, number_of_datasets, type)
    % Input Parameters:
    % noise_strength     : scalar
    % delta              : 1x2 vector with values delta(1) > delta(2)
    % number_of_datasets : scalar 
    % type               : 0:'top'- data created with higher values in the upper region
    %                      (Can be flipped vertically to get bottom heavy
    %                      dataset).
    %                      1:'topbottom'- creates datasets with higher values 
    %                      in both upper and lower regions (in equal numbers).
    
    % Output Parameters:
    % datasets     : cell array of size: 'number_of_datasets', consisting of
    %                matrices.
    % datasets_sq  : cell array of size: 'number_of_datasets', consisting of
    %                matrices.
    
    % Constants:
    % max_muR      : 4x2 matrix specifying max (x,y) value for mean in every quadrant.
    % min_muR      : 4x2 matrix specifying max (x,y) value for mean in every quadrant.
    % alphaR       : 1x2 vector specifying range of alpha [min max]
    % betaR        : 1x2 vector specifying range of beta  [min max]
    % window_size  : scalar
    
    rng(1);
    max_muR = [0.3 0.95; 0.2 0.3; 0.95 0.85; 0.95 0.3];
    min_muR = [0.2 0.9; 0.1 0.2; 0.85 0.8; 0.9 0.2 ];
    alphaR = [0.05 0.07]; %[min max]
    betaR = [0.05 0.07];  %[min max]
    window_size = 25;
    
    x1 = linspace(0,1,200);
    x2 = linspace(0,1,100);
    datasets = cell(number_of_datasets,1);
    datasets_sq = cell(number_of_datasets,1);
    
    for i = 1:number_of_datasets
        [mu1,mu2,mu3,mu4] = get_means(max_muR, min_muR);
        [Sigma1, Sigma2, Sigma3, Sigma4] = get_covariance(alphaR,betaR);
        [f1,f2,f3,f4] = get_mvnpdf(mu1,mu2,mu3,mu4,Sigma1,Sigma2,Sigma3,Sigma4,x1,x2);
      
        if type==0 % (type 0 -- top -- flip vertical required for half datasets)
        	[amp1, amp2, amp3, amp4] = get_amplitudes(delta, 'T');
        elseif type==1 && i<= number_of_datasets/2
            [amp1, amp2, amp3, amp4] = get_amplitudes(delta, 'T');
        elseif type==1 && i > number_of_datasets/2
            [amp1, amp2, amp3, amp4] = get_amplitudes(delta, 'B');
        end
        F = (amp1*f1) + (amp2*f2) + (amp3*f3) + (amp4*f4);
        
        % Generate Gaussian noise
        noise = (randn(size(F)));
        x = linspace(-2,2,window_size);
        ex = exp(-x.^2);
        H = ex'*ex;
        H = H / sum(sum(H));
        % Filter noise
        Y = filter2(H,noise,'same');
        Fp = reshape(F+(noise_strength*Y),size(F));
        datasets{i} = Fp;  
        
        % resize the image by downsampling (PICK AN EVEN NUMBER)
        N2 = 24;
        N1 = 12;
        Fp_sq = imresize(Fp,[N1 N2]);
        % randomize each half of the image
        q = 8;
        M = N1*N2/q;
        rix = randperm(M);
        for b = 1:q-1
            rix = [rix b*M+randperm(M)];
        end
        Fp_sq = reshape(Fp_sq(rix),N1,N2);
        datasets_sq{i} = Fp_sq;
    end
end 

function [m1, m2, m3, m4] = get_means(max_muR, min_muR)
    m = min_muR + (max_muR-min_muR).*(rand(size(max_muR)));
    A = m;
    m1 = A(1,:);
    m2 = A(2,:);
    m3 = A(3,:);
    m4 = A(4,:);
end

function [sigma1, sigma2, sigma3, sigma4, theta] = get_covariance(alphaR,betaR)
    A = zeros(2,2,4);
    for i = 1:4 
        a = alphaR(1) + (alphaR(2)-alphaR(1))*rand;
        b = betaR(1) + (betaR(2)-betaR(1))*rand;
        theta(i) = 360.*rand;
        u = [cosd(theta(i)) sind(theta(i)); -sind(theta(i)) cosd(theta(i))];
        covar = u'*[a 0; 0 b]*u;
        A(:,:,i) = covar;
    end
    sigma1 = A(:,:,1);
    sigma2 = A(:,:,2);
    sigma3 = A(:,:,3);
    sigma4 = A(:,:,4);
end

function [f1,f2,f3,f4] = get_mvnpdf(mu1,mu2,mu3,mu4,Sigma1,Sigma2,Sigma3,Sigma4,x1,x2)
    [X1,X2] = meshgrid(x1,x2);
    f1 = mvnpdf([X1(:) X2(:)],mu1,Sigma1);
    f1 = reshape(f1,length(x2),length(x1));
    f2 = mvnpdf([X1(:) X2(:)],mu2,Sigma2);
    f2 = reshape(f2,length(x2),length(x1));
    f3 = mvnpdf([X1(:) X2(:)],mu3,Sigma3);
    f3 = reshape(f3,length(x2),length(x1));
    f4 = mvnpdf([X1(:) X2(:)],mu4,Sigma4);
    f4 = reshape(f4,length(x2),length(x1));
end

function [amp1, amp2, amp3, amp4] = get_amplitudes(delta, side)
    if side == 'T' % Top Heavy
        amp1 = (0.5 + (0.2*rand))*delta(1); % amp1 lies within 50-70% of delta1
        amp2 = delta(1) - amp1;
        while 1
            amp3 = rand*delta(2);
            amp4 = delta(2) - amp3;
            % Check for the inequalities
            if(amp1 + amp4 > amp3 + amp2)
                break
            end
        end
    else % Bottom heavy
        amp4 = (0.5 + (0.2*rand))*delta(1); % amp4 lies within 50-70% of delta1
        amp3 = delta(1) - amp4;
        while 1
            amp1 = rand*delta(2);
            amp2 = delta(2) - amp1;
            % Remove if left-right heavy required
            break
            % Check for the inequalities
            if(amp4 + amp1 > amp2 + amp3)
                break
            end
        end
    end
end
