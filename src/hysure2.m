function [SRI_hat,info] = hysure2(HSI,MSI,P1,P2,Pm, opt)
%UNTITLED23 Summary of this function goes here
%   Detailed explanation goes here

% hsize_h = 10; hsize_w = 10;
% shift = 1;
hsize_h = 10; hsize_w = 10;
shift = 3; blur_center = 4; lambda_R = 1e1; lambda_B = 1e1;
basis_type = 'VCA'; lambda_phi = 5e-4; lambda_m = 1e0;

d1 = ceil(size(MSI,1)/size(HSI,1));

% Pm = zeros(1,size(HSI,3));
% spec_range = linspace(400,2500,size(HSI,3));
% Pm(1,:) = 1/length(spec_range);
% R_est = Pm;
% B_est = zeros(size(MSI,1),size(MSI,2));
% h1 = gauss_kernel(9, 1);
% B_est(1:9,1:9) = h1' * h1;

B_est = real(P1(1,:)'*P2(1,:));

B_est = circshift(circshift(B_est,-4,2),-4,1);

tic; SRI_hat = data_fusion(HSI, MSI, d1, Pm, B_est, opt.p, basis_type, lambda_phi, lambda_m); t = toc;

info.time = t;

end

