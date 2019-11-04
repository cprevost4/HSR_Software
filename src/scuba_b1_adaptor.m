function [SRI_hat,info] = scuba_b1_adaptor(HSI, MSI, P1, P2, Pm, R, opts)
%   Detailed explanation goes here
[SRI_hat,info] = scuba(MSI, HSI, Pm, R, opts);
end

