function [SRI_hat, err] = stereo_adaptor( HSI, MSI, P1,P2,Pm, ranks, opts)

%STEREO_ADAPTOR calls the STEREO implementation provided by C. Kanatsoulis
% available at https://github.com/marhar19/HSR_via_tensor_decomposition

if ~exist('opts','var')
    opts = struct();
end
if ~isfield(opts,'factors') || isempty(opts.factors)
    [A,B,C,~,~,~]=TenRec(MSI,tens2mat(HSI,[],3),25,ranks,P1,P2);
else
    A = opts.factors{1}; B = opts.factors{2}; C = opts.factors{3};
end

lamda=1;
s_iter=10; % 10
[ A1,B1,C1,~ ] = STEREO( HSI,MSI,P1,P2,Pm,s_iter,lamda,A,B,C,Pm*C);

SRI_hat = cpdgen({A1,B1,C1});
err = {};


end

