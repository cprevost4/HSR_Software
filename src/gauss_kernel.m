
function Phi = gauss_kernel(q,sigma)

% GAUSS_KERNEL returns Gaussian blurring kernel along one dimension
% Phi = GAUSS_KERNEL(q,sigma) computes kernel Phi of size 1xq with parameter sigma
% 
% INPUT ARGUMENTS:
%     q : size of kernel 
%     sigma: normal distribution parameter (default: sigma = 0.5)
% OUTPUT ARGUMENTS:
%     Phi: Gaussian kernel of size 1xq

% Copyright (c) 2018 Clemence Prevost, Konstantin Usevich, Pierre Comon, David Brie
% https://github.com/cprevost4/HSR_Tucker
% Contact: clemence.prevost@univ-lorraine.fr

if nargin==1
    sigma = 1;
end

Phi = zeros(1,q);
for m=1:q
    Phi(m) = (1/sqrt(2*pi*sigma^2))*exp(-(m-ceil(q/2))^2 / (2*sigma^2));
end

end

