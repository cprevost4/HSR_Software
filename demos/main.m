% Hyperspectral Super-Resolution with Coupled Tucker Approximation:       %
%               Recoverability and SVD-based algorithms                   %
%-------------------------------------------------------------------------%

% Copyright (c) 2018 Clemence Prevost, Konstantin Usevich, Pierre Comon,
% David Brie
% https://github.com/cprevost4/HSR_Tucker
% Contact: clemence.prevost@univ-lorraine.fr

% This software reproduces the results from the paper called 
% "Hyperspectral Super-Resolution with Coupled Tucker Approximation:
% Recoverability and SVD-based algorithms" - C.Prévost, K.Usevich, D.Brie,
% P.Comon.

% In order to run the demo, you will need to add to your MATLAB path:
% - Tensorlab 3.0: https://www.tensorlab.net
% - Codes by C. Kanatsoulis: 
%      https://github.com/marhar19/HSR_via_tensor_decomposition
% - Codes for HySure: https://github.com/alfaiate/HySure
% - Codes for FUSE: https://github.com/qw245/BlindFuse
% - Hyperspectral data :
%      https://github.com/marhar19/HSR_via_tensor_decomposition

%-------------------------------------------------------------------------%
%                              CONTENT
% - /data : contains data for synthetic examples (Section VI.D)
% - /demos : contains demo files that produce tables and figures
% - /figures : where the tables and figures are saved
% - /src : contains helpful files to run the demos
%-------------------------------------------------------------------------%
%                                MENU
% You can launch a specified demo by typing its number. The resulting tables
% and figures produced will be stored in the figures folder.
%
% 1:  produces Tables I and II and Figures 3 and 4
% 2:  produces Tables III and IV and Figures 5 and 6
% 3:  produces Table V
% 4:  produces Figures 7 and 8
% 5:  produces Figures 9 and 10
% 6:  produces Figure 11
% 7:  produces Figure 12
% 8:  produces Figures 13 and 14
% 9:  produces Figures 15 and 16
% 10: produces Figures 17 and 18
% 11: produces Figures 20, 21 and 22 
%-------------------------------------------------------------------------%

list_demos = ["test_semireal_nonblind" "test_semireal_blind" ...
    "test_pansharpening" "test_simulated_noiseless2by2"...
    "test_simulated_noisy7x7" "test_simulated_blocks" "test_simulated_svd" ...
    "test_semireal_svd" "test_semireal_ranks" "test_semireal_conditioning" ...
    "test_indianpines_spectra"];

prompt = "Which file do you want to run ?";
num = input(prompt);
eval(list_demos(num));