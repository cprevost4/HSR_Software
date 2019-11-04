function [SRI_hat,info] = scuba_adaptor(HSI, MSI, Pm, R, opts)
%Changes the order of parameters 
  [SRI_hat,info] = scuba(MSI, HSI, Pm, R, opts);
end

