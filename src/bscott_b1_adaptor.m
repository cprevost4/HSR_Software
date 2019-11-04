function [SRI_hat,info] = bscott_b1_adaptor(HSI, MSI, P1, P2, Pm, R, opts)
%BSCOTT_B1_ADAPTOR Adaptor function for bscott with 1x1 block
%   This function is just to have the same number of parameters for
%   BSCOTT and for the non-blind methods 
%  opts.Nblocks = [1 1];
  [SRI_hat,info] = bscott(MSI, HSI, Pm, R, opts);
end

