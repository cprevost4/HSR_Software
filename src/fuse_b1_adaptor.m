function [SRI_hat,info] = fuse_b1_adaptor(HSI, MSI, P1, P2, Pm, R, opts)
%Non-blind FUSE adaptor
[SRI_hat,info] = fuse(HSI,MSI,P1,P2,Pm, opts);
end

