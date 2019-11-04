% TABLES FOR SEMIREAL DATA %
% Copyright (c) 2018 Clemence Prevost, Konstantin Usevich, Pierre Comon, David Brie
% https://github.com/cprevost4/HSR_Tucker
% Contact: clemence.prevost@univ-lorraine.fr

%% Table for Indian Pines

fprintf('Generating Table I ...')

SRI = cell2mat(struct2cell(load('Indian_pines.mat')));
SRI(:,:,[104:108 150:163 220]) = []; %Regions of water absorption
SRI(1,:,:) = []; SRI(:,1,:) = [];
Pm = spectral_deg(SRI,"LANDSAT");
MSI = tmprod(SRI,Pm,3);
d1 = 4; d2 = 4; q = 9;
[P1,P2] = spatial_deg(SRI, q, d1, d2);
HSI = tmprod(tmprod(SRI,P1,1),P2,2);

methods = {'STEREO' 'stereo4' '50' [];...
           'STEREO' 'stereo4' '100' [];...
           'SCOTT2' 'scott2' '[40,40,6]' []; ...
           'SCOTT2' 'scott2' '[30,30,16]' []; ...
           'SCOTT2' 'scott2' '[70,70,6]' []; ...
           'SCOTT' 'scott2' '[24,24,25]' [];...
           'B-SCOTT' 'bscott_b1_adaptor' '[40,40,6]' []; ...  
           'HySure' 'hysure_b1_adaptor' '[]' 16;...
           'FUSE' 'fuse_b1_adaptor' '[]' [];...
           'TenRec' 'TenRec_adaptor' '50' [];...
           'TenRec' 'TenRec_adaptor' '100' [];};     
DegMat = struct('Pm', Pm, 'P1', P1, 'P2', P2);         
res = compare_methods(SRI, HSI, MSI, DegMat, [d1 d2], methods);  
save_results('figures/tab1.txt',res);

%% Table for Indian Pines with noise

fprintf('Generating Table II ...')

SRI = cell2mat(struct2cell(load('Indian_pines.mat')));
SRI(:,:,[104:108 150:163 220]) = []; %Regions of water absorption
SRI(1,:,:) = []; SRI(:,1,:) = [];
Pm = spectral_deg(SRI,"LANDSAT");
MSI = tmprod(SRI,Pm,3);
d1 = 4; d2 = 4; q = 9;
[P1,P2] = spatial_deg(SRI, q, d1, d2);
HSI = tmprod(tmprod(SRI,P1,1),P2,2);

for k=1:size(HSI,3)
    HSI(:,:,k) = awgn(HSI(:,:,k),15,'measured');
end
for k=1:size(MSI,3)
    MSI(:,:,k) = awgn(MSI(:,:,k),25,'measured');
end

methods = {'STEREO' 'stereo4' '50' [];...
           'STEREO' 'stereo4' '100' [];...
           'SCOTT2' 'scott2' '[40,40,6]' []; ...
           'SCOTT2' 'scott2' '[30,30,16]' []; ...
           'SCOTT2' 'scott2' '[70,70,6]' []; ...
           'SCOTT' 'scott2' '[24,24,25]' [];...
           'B-SCOTT' 'bscott_b1_adaptor' '[40,40,6]' []; ...  
           'HySure' 'hysure_b1_adaptor' '[]' 16;...
           'FUSE' 'fuse_b1_adaptor' '[]' [];...
           'TenRec' 'TenRec_adaptor' '50' [];...
           'TenRec' 'TenRec_adaptor' '100' [];};     
DegMat = struct('Pm', Pm, 'P1', P1, 'P2', P2);         
res = compare_methods(SRI, HSI, MSI, DegMat, [d1 d2], methods);  
save_results('figures/tab2.txt',res);

%% Table for Salinas A-scene

fprintf('Generating Table III ...')

% 1. load data
SRI = cell2mat(struct2cell(load('SalinasA.mat')));
SRI = crop(SRI,[80,84,size(SRI,3)]);
SRI(:,:,[108:112 154:167 224]) = []; %Regions of water absorption (Salinas)
% 2. degradation
Pm = spectral_deg(SRI,"LANDSAT");
d1 = 4; d2 = 4; q = 9;
[P1,P2] = spatial_deg(SRI, q, d1, d2);
MSI = tmprod(SRI,Pm,3); HSI = tmprod(tmprod(SRI,P1,1),P2,2);

% 3. run metrics
methods = {'STEREO' 'stereo4' '50' [];...
           'STEREO' 'stereo4' '100' [];...
           'SCOTT2' 'scott2' '[40,40,6]' [];...
           'SCOTT2' 'scott2' '[50,50,6]' [];...
           'SCOTT2' 'scott2' '[70,70,6]' [];...
           'B-SCOTT' 'bscott_b1_adaptor' '[40,40,6]' []; ...   
           'HySure','hysure_b1_adaptor','[]',6;...
           'FUSE' 'fuse_b1_adaptor' '[]' [];...
           'TenRec' 'TenRec_adaptor' '50' [];...
           'TenRec' 'TenRec_adaptor' '100' [];};      
DegMat = struct('Pm', Pm, 'P1', P1, 'P2', P2);         
res = compare_methods(SRI, HSI, MSI, DegMat, [d1 d2], methods); 
save_results('figures/tab3.txt',res);

%% Figures for Indian Pines

fprintf('Generating Figure 3 ...')

SRI = cell2mat(struct2cell(load('Indian_pines.mat')));
SRI(:,:,[104:108 150:163 220]) = []; %Regions of water absorption
SRI(1,:,:) = []; SRI(:,1,:) = [];
Pm = spectral_deg(SRI,"LANDSAT");
MSI = tmprod(SRI,Pm,3);
d1 = 4; d2 = 4; q = 9;
[P1,P2] = spatial_deg(SRI, q, d1, d2);
HSI = tmprod(tmprod(SRI,P1,1),P2,2);

methods = {'STEREO' 'stereo3' '50' []; ...
           'SCOTT' 'scott2' '[40,40,6]' []; ...
           'HySure','hysure_b1_adaptor','[]',16};      
DegMat = struct('Pm', Pm, 'P1', P1, 'P2', P2);         
[~, est] = compare_methods(SRI, HSI, MSI, DegMat, [d1 d2], methods); 

figure
subplot(2,2,1); imagesc(SRI(:,:,120)); title('Groundtruth SRI'); colorbar; lim = caxis; axis off
subplot(2,2,2); imagesc(real(est{1}(:,:,120))); title(sprintf('%s, F=%s',methods{1,1},methods{1,3})); colorbar; caxis(lim); axis off
subplot(2,2,3); imagesc(real(est{2}(:,:,120))); title(sprintf('%s, R=%s',methods{2,1},methods{2,3})); colorbar; caxis(lim); axis off
subplot(2,2,4); imagesc(real(est{3}(:,:,120))); title(sprintf('%s, p=%d',methods{3,1},methods{3,4})); colorbar; caxis(lim); axis off
saveas(gcf,'figures/fig3.fig');

%% Figures for Salinas A-scene

fprintf('Generating Figure 4 ...')

% 1. load data
SRI = cell2mat(struct2cell(load('SalinasA.mat')));
SRI = crop(SRI,[80,84,size(SRI,3)]);
SRI(:,:,[108:112 154:167 224]) = []; %Regions of water absorption (Salinas)
% 2. degradation
Pm = spectral_deg(SRI,"LANDSAT");
d1 = 4; d2 = 4; q = 9;
[P1,P2] = spatial_deg(SRI, q, d1, d2);
MSI = tmprod(SRI,Pm,3); HSI = tmprod(tmprod(SRI,P1,1),P2,2);

methods = {'STEREO' 'stereo3' '100' []; ...         
           'SCOTT' 'scott2' '[70,70,6]' [];...
           'HySure','hysure_b1_adaptor','[]',6};      
DegMat = struct('Pm', Pm, 'P1', P1, 'P2', P2);         
[res,est] = compare_methods(SRI, HSI, MSI, DegMat, [d1 d2], methods);

figure
subplot(2,2,1); imagesc(SRI(:,:,120)); title('Groundtruth SRI'); colorbar; lim = caxis; axis off
subplot(2,2,2); imagesc(real(est{1}(:,:,120))); title(sprintf('%s, F=%s',methods{1,1},methods{1,3})); colorbar; caxis(lim); axis off
subplot(2,2,3); imagesc(real(est{2}(:,:,120))); title(sprintf('%s, R=%s',methods{2,1},methods{2,3})); colorbar; caxis(lim); axis off
subplot(2,2,4); imagesc(real(est{3}(:,:,120))); title(sprintf('%s, p=%d',methods{3,1},methods{3,4})); colorbar; caxis(lim); axis off
saveas(gcf,'figures/fig4.fig');


