function [SRI_hat,info] = fuse_blind(MSI, HSI, Pm, opts);

d1 = 4; %d1 = size(MSI,1)/size(HSI,1); 
lambda_R = 1e1; lambda_B = 1e1; q=7;

intersection = cell(1,size(MSI,3));
spectral_distrib = linspace(400,2500,size(HSI,3)); %Hyp: uniform distribution
bands = [450 520; 520 600; 630 690; 760 900; 1550 1770; 2080 2350];
for k=1:size(MSI,3)
    ind = find(spectral_distrib >= bands(k,1) & spectral_distrib <= bands(k,2));
    intersection{1,k} = ind;
end
contiguous=intersection;

hsize_h = q; hsize_w = q;
shift = 0; % 'phase' parameter in MATLAB's 'upsample' function
blur_center = 0; % to center the blur kernel according to the simluated data
[~, ~, B_est] = sen_resp_est(HSI, MSI, d1, intersection, contiguous,...
                size(MSI,3), lambda_R, lambda_B, hsize_h, hsize_w, shift, blur_center);

BluKer=MatrixToKernel(B_est,hsize_h,hsize_w);
start_pos(1)=1; start_pos(2)=1; % The starting point of downsampling
scale=1;[E_hyper, ~, ~, ~]=idHSsub(HSI,'PCA',scale,size(MSI,3));

tic
SRI_hat = BayesianFusion(HSI,MSI,B_est,d1,Pm,E_hyper,'ML',start_pos);
info.time =toc;

end

