function [SRI_hat,info] = bscott_adaptor(HSI, MSI, Pm, R, opts)
%Changes the order of parameters 
  [SRI_hat,info] = bscott(MSI, HSI, Pm, R, opts);
end

