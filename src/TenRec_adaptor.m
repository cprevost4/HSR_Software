function [SRI_hat,info] = TenRec_adaptor(HSI, MSI, P1, P2, Pm, R, opts)

H3 = tens2mat(HSI,[],3); maxit = 25;
[A_hat,B_hat,C_hat,~,~,~]=TenRec(MSI,H3,maxit,R,P1,P2);
SRI_hat = cpdgen({A_hat,B_hat,C_hat});
info = [];

end

