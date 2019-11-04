function [SRI_hat,info] = TenRec_adaptor_b1(HSI, MSI, Pm, R, opts)

H3 = tens2mat(HSI,[],3); maxit = 25;
[A_hat,B_hat,C_hat,~,~,~]=Blind_TenRec(MSI,H3,maxit,R);
SRI_hat = cpdgen({A_hat,B_hat,C_hat});
info = [];

end

