function cost = cost_scott(factors,core, HSI, MSI, lambda, P1,P2,Pm)

% COST_SCOTT computes the value of the cost function for a Tucker 
%decomposition given HSI and MSI data cubes and estimated factors and core
% 
% INPUT ARGUMENTS:
%     factors: cell array of Tucker factors U,V,W
%     core: cell array for core tensor
%     HSI: hyperspectral data cube
%     MSI: multispectral data cube
%     lambda: weighting factor between HSI and MSI
%     P1,P2,Pm: degradation matrices specified by the model
% OUTPUT ARGUMENTS:
%     cost: real value of cost function

U = factors{1}; V = factors{2}; W = factors{3}; G = cell2mat(core);
cost = frob(HSI - lmlragen({P1*U,P2*V,W},G),'squared') + ...
    lambda*frob(MSI - lmlragen({U,V,Pm*W},G),'squared');
end