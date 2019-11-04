function [SRI_hat, info] = stereo(HSI, MSI, P1, P2, Pm, ranks, opts)

% STEREO provides estimation of SRI with an AO algorithm
% [SRI_hat, info] = STEREO(HSI, MSI, P1, P2, Pm, ranks, opts) returns
% SRI_hat = [A,B,C] from HSI and MSI
% 
% INPUT ARGUMENTS:
%     ranks: tensor rank of estimation
%     HSI, MSI: lower-resolution images
%     P1,P2,Pm: degradation matrices
%     opts: options structure
% OUTPUT ARGUMENTS:
%     SRI_hat: estimation of SRI such that SRI_hat = [A,B,C]
%     info: informative structure about the method
% 
% Copyright (c) 2018 Clemence Prevost, Konstantin Usevich, Pierre Comon, David Brie
% https://github.com/cprevost4/HSR_Tucker
% Contact: clemence.prevost@univ-lorraine.fr

if ~exist('opts','var')
    opts = struct();
end
if ~isfield(opts,'lambda') || isempty(opts.lambda)
    opts.lambda = 1;
end
if ~isfield(opts,'Niter') || isempty(opts.Niter)
    opts.Niter = 10;
end
if ~isfield(opts,'CPD_Niter') || isempty(opts.CPD_Niter)
    opts.CPD_Niter = 25;
end
if ~isfield(opts,'factors') || isempty(opts.factors)
    [A, B, ~,~, C] = stereo_init(MSI, HSI, P1, P2, Pm, ranks);
end

opts2.POSDEF = true; opts2.SYM = true;

Yh1 = tens2mat(HSI,[],1); Yh2 = tens2mat(HSI,[],2); Yh3 = tens2mat(HSI,[],3);
Ym1 = tens2mat(MSI,[],1); Ym2 = tens2mat(MSI,[],2); Ym3 = tens2mat(MSI,[],3);

for n = 1:opts.Niter
    
    %disp('A...')
    R = opts.lambda*Ym1'*kr(Pm*C,B) + P1'*Yh1'*kr(C,P2*B);
    Q = opts.lambda*kron(((Pm*C)'*(Pm*C)).*(B'*B), eye(size(P1,2))) + kron((C'*C).*((P2*B)'*(P2*B)), P1'*P1);
    A = reshape(linsolve(Q, R(:), opts2),[size(P1,2) ranks]);
    %A = reshape(Q\R(:),[size(P1,2) ranks]);
    
    %disp('B...')
    R = opts.lambda*Ym2'*kr(Pm*C,A) + P2'*Yh2'*kr(C,P1*A);
    Q = opts.lambda*kron(((Pm*C)'*(Pm*C)).*(A'*A), eye(size(P2,2))) + kron((C'*C).*((P1*A)'*(P1*A)), P2'*P2);
    B = reshape(linsolve(Q, R(:), opts2),[size(P2,2) ranks]);
    %B = reshape(Q\R(:),[size(P2,2) ranks]);
    
    %disp('C...')
    R = opts.lambda*Pm'*Ym3'*kr(B,A) + Yh3'*kr(P2*B,P1*A);
    Q = opts.lambda*kron((B'*B).*(A'*A), Pm'*Pm) + kron(((P2*B)'*(P2*B)).*((P1*A)'*(P1*A)), eye(size(Pm,2)));
    C = reshape(linsolve(Q, R(:), opts2),[size(Pm,2) ranks]);
    %C = reshape(Q\R(:),[size(Pm,2) ranks]);
    
end

SRI_hat = cpdgen({A,B,C});
info.factors = {A,B,C};
info.rank = {ranks};
info.Niter = {opts.Niter};

end

