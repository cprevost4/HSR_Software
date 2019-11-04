function err = compute_metrics(Y,Y_hat,d1,d2)

% COMPUTE_METRICS returns cell array of metrics between GT SRI and estimation
% err = COMPUTE_METRICS(Y,Yhat) returns cell array err of metrics btw Y and Y_hat
% INPUT ARGUMENTS:
%     Y: GT SRI
%     Y_hat: estimated SRI
%     d1, d2: spatial degradation ratios
% OUTPUT ARGUMENTS:
%     err: contains R-SNR, CC, SAM, ERGAS

err = {r_snr(Y,Y_hat), cc(Y,Y_hat), sam(Y,Y_hat), ergas(Y,Y_hat,d1,d2)};

end

