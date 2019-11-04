function [SRI_hat,info] = fuse_blind_adaptor(HSI, MSI, Pm, R, opts)

SRI = cell2mat(struct2cell(load('PaviaU.mat')));
SRI(1:2,:,:) = []; SRI(:,1:4,:) = []; q=7; d1 = 4; d2 = 4;
[P1,P2] = spatial_deg(SRI, q, d1, d2);
[SRI_hat,info] = fuse(HSI,MSI,P1,P2,Pm, opts);

end

