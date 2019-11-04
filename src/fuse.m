function [SRI_hat,info] = fuse(HSI,MSI,P1,P2,Pm, opt)

d1 = 4;
start_pos(1)=1; start_pos(2)=1; % The starting point of downsampling

B_est = real(P1(1,:)'*P2(1,:));
B_est = circshift(circshift(B_est,-4,2),-4,1);
scale=1;[E_hyper, ~, ~, ~]=idHSsub(HSI,'PCA',scale,size(MSI,3));

tic
SRI_hat = BayesianFusion(HSI,MSI,B_est,d1,Pm,E_hyper,'ML',start_pos);
info.time =toc;


end

