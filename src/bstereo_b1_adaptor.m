function [SRI_hat,info] = bstereo_b1_adaptor(HSI, MSI, P1, P2, Pm, R, opts)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[SRI_hat, info] = stereo_blind2(HSI, MSI, Pm, R, opts);

end

