function ergas = ergas(DATA,est,d1,d2)

% ERGAS computes ERGAS between original dataset and its estimate
% ergas = ERGAS(DATA, est,d) returns real number
% 
% INPUT ARGUMENTS:
%     DATA: original dataset
%     est: estimate of DATA
%     d: level of undersampling when computing 
% OUTPUT ARGUMENTS:
%     ergas: ERGAS between DATA and est
% 
% SEE ALSO: SAM, NMSE, R_SNR
% Copyright (c) 2018 Clemence Prevost, Konstantin Usevich, Pierre Comon, David Brie
% https://github.com/cprevost4/HSR_Tucker
% Contact: clemence.prevost@univ-lorraine.fr

ergas = 0;

for k=1:size(DATA,3)
    mu = mean(mean(DATA(:,:,k)));
    ergas = ergas + norm(reshape(est(:,:,k)-DATA(:,:,k),[],1),'fro')^2/mu^2;
end
ergas = 100*(1/sqrt(d1*d2))*sqrt(ergas/numel(DATA)); 

end

