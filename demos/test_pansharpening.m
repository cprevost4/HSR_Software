% EXPERIMENTS ON WOOD DATA %
% Copyright (c) 2018 Clemence Prevost, Konstantin Usevich, Pierre Comon, David Brie
% https://github.com/cprevost4/HSR_Tucker
% Contact: clemence.prevost@univ-lorraine.fr

%% Table for Indian Pines

fprintf('Generating Table VI ...')

SRI = cell2mat(struct2cell(load('Indian_pines.mat')));
SRI(:,:,[104:108 150:163 220]) = []; %Regions of water absorption (Indian pines)
SRI(1,:,:) = []; SRI(:,1,:) = [];
d1 = 4; d2 = 4; q = 9;
[P1,P2] = spatial_deg(SRI, q, d1, d2);
HSI = tmprod(tmprod(SRI,P1,1),P2,2);
Km = 1; Pm = zeros(Km,size(SRI,3));
spec_range = linspace(400,2500,size(SRI,3));
Pm(1,:) = 1/length(spec_range);
MSI = tmprod(SRI,Pm,3); 

methods = {'SCOTT' 'scott2' '[24,24,25]' [];...
           'SCOTT' 'scott2' '[30,30,16]' [];...
           'SCOTT' 'scott2' '[35,35,6]' [];...
           'HySure','hysure_b1_adaptor','[]',16; ...
           'BSCOTT','bscott_b1_adaptor','[24,24,1]',[4,4];...
           'BSCOTT','bscott_b1_adaptor','[35,35,1]',[4,4];...
           };      
DegMat = struct('Pm', Pm, 'P1', P1, 'P2', P2);         
res = compare_methods(SRI, HSI, MSI, DegMat, [d1 d2], methods);
save_results('figures/tab6.txt',res)

