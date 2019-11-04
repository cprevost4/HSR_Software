function nmse = nmse(DATA, est)

% NMSE computes NMSE between original dataset and its estimate
% nmse = NMSE(DATA, est) returns real number
% 
% INPUT ARGUMENTS:
%     DATA: original dataset
%     est: estimate of DATA
% OUTPUT ARGUMENTS:
%     nmse: NMSE between DATA and est
% 
% SEE ALSO: SAM, ERGAS, R_SNR
% Copyright (c) 2018 Clemence Prevost, Konstantin Usevich, Pierre Comon, David Brie
% https://github.com/cprevost4/HSR_Tucker
% Contact: clemence.prevost@univ-lorraine.fr



 nmse = frob(DATA-est,'squared')/frob(DATA,'squared');

end

