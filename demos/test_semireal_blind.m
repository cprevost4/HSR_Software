% EXPERIMENT 1: HOSVD FOR VARIOUS RANKS %
% Copyright (c) 2018 Clemence Prevost, Konstantin Usevich, Pierre Comon, David Brie
% https://github.com/cprevost4/HSR_Tucker
% Contact: clemence.prevost@univ-lorraine.fr

%% Table for Pavia University

fprintf('Generating Table IV ...')

SRI = cell2mat(struct2cell(load('PaviaU.mat')));
SRI(1:2,:,:) = []; SRI(:,1:4,:) = [];
Pm = spectral_deg(SRI,"Quickbird");
MSI = tmprod(SRI,Pm,3);
d1 = 4; d2 = 4; q = 7;
[P1,P2] = spatial_deg(SRI, q, d1, d2);
HSI = tmprod(tmprod(SRI,P1,1),P2,2);

for k=1:size(HSI,3)
    HSI(:,:,k) = awgn(HSI(:,:,k),15);
end
for k=1:size(MSI,3)
    MSI(:,:,k) = awgn(MSI(:,:,k),25);
end

  methods2 = {'SCUBA'  'scuba_adaptor' '[120,3]' [4,4]; ...
              'B-SCOTT' 'bscott_adaptor' '[60,60,3]' [4,4]; ... 
              'B-SCOTT' 'bscott_adaptor' '[152,84,3]' [4,4]; ...
              'B-SCOTT' 'bscott_adaptor' '[120,60,4]' [4,4]; ...
              'SCUBA'  'scuba_adaptor' '[120,3]' [8,8]; ... 
              'B-SCOTT' 'bscott_adaptor' '[76,42,3]' [8,8];...
              'B-STEREO' 'stereo_blind2'  '300'  [];...
              'HySure' 'hysure_adaptor' '[]' 9;...
              'B-TenRec' 'TenRec_adaptor_b1' '300' [];
            };
res = compare_methods(SRI, HSI, MSI, struct('Pm', Pm), [d1 d2], methods2);
save_results('figures/tab4.txt',res);

%% Table for Cuprite

fprintf('Generating Table V ...')

load Cuprite.mat
SRI = double(X); clear X; %Convert groundtruth to double
SRI(:,:,[1:2 104:113 148:167 221:224]) = []; %Regions of water absorption
SRI(:,1:2,:) = [];
d1 = 4; d2 = 4; %Spatial downsampling ratios
[P1,P2] = spatial_deg(SRI,7,d1,d2); Pm = spectral_deg(SRI,"LANDSAT");
HSI = tmprod(SRI,{P1,P2},[1,2]); MSI = tmprod(SRI,Pm,3);
for k=1:size(HSI,3)
    HSI(:,:,k) = awgn(HSI(:,:,k),15);
end
for k=1:size(MSI,3)
    MSI(:,:,k) = awgn(MSI(:,:,k),25);
end

methods2 = {'SCUBA'  'scuba_adaptor' '[45,3]' [4,4]; ...
            'B-SCOTT' 'bscott_adaptor' '[45,45,3]' [4,4]; ... 
            'B-SCOTT' 'bscott_adaptor' '[60,60,3]' [4,4]; ... 
            'SCUBA'  'scuba_adaptor' '[45,3]' [8,8]; ... 
            'B-SCOTT' 'bscott_adaptor' '[45,45,3]' [8,8];...
            'B-STEREO','stereo_blind2', '150', [];...
            'HySure','hysure_adaptor','[]',10; ...
            'B-TenRec' 'TenRec_adaptor_b1' '150' [];
           };      
res = compare_methods(SRI, HSI, MSI, struct('Pm', Pm), [d1 d2], methods2);
save_results('figures/tab5.txt',res);

%% Figures for Pavia 

fprintf('Generating Figure 5 ...')

methods = {'SCUBA'  'scuba_adaptor' '[120,3]' [8,8]; ... 
           'B-SCOTT' 'bscott_adaptor' '[76,42,3]' [8,8];...
           'HySure','hysure_adaptor','[]',9;};      
[~, est] = compare_methods(SRI, HSI, MSI, struct('Pm', Pm), [d1 d2], methods);

figure
subplot(1,4,1); imagesc(SRI(:,:,44)); ...
    title('Groundtruth'); colorbar; lim = caxis; axis off
subplot(1,4,2); imagesc(real(est{1}(:,:,44)));...
    title(sprintf('%s, [F R]=%s, [%d %d]',methods{1,1},methods{1,3},methods{1,4}(1),methods{1,4}(2))); colorbar; caxis(lim); axis off
subplot(1,4,3); imagesc(real(est{2}(:,:,44)));...
    title(sprintf('%s, R=%s, [%d %d]',methods{2,1},methods{2,3},methods{2,4}(1),methods{2,4}(2))); colorbar; caxis(lim); axis off
subplot(1,4,4); imagesc(real(est{3}(:,:,44)));...
    title(sprintf('%s, p=%d',methods{3,1},methods{3,4})); colorbar; caxis(lim); axis off
saveas(gcf,'figures/fig5.fig')
%% Figures for Cuprite

fprintf('Generating Figure 6 ...')

methods = {'SCUBA'  'scuba_adaptor' '[45,3]' [8,8]; ... 
           'B-SCOTT' 'bscott_adaptor' '[45,45,3]' [8,8];...
           'HySure','hysure_adaptor','[]',10};      
[~,est] = compare_methods(SRI, HSI, MSI, struct('Pm', Pm), [d1 d2], methods);

figure
subplot(1,4,1); imagesc(SRI(:,:,44)); ...
    title('Groundtruth'); colorbar; lim = caxis; axis off
subplot(1,4,2); imagesc(real(est{1}(:,:,44)));...
    title(sprintf('%s, [F R]=%s, [%d %d]',methods{1,1},methods{1,3},methods{1,4}(1),methods{1,4}(2))); colorbar; caxis(lim); axis off
subplot(1,4,3); imagesc(real(est{2}(:,:,44)));...
    title(sprintf('%s, R=%s, [%d %d]',methods{2,1},methods{2,3},methods{2,4}(1),methods{2,4}(2))); colorbar; caxis(lim); axis off
subplot(1,4,4); imagesc(real(est{3}(:,:,44)));...
    title(sprintf('%s, p=%d',methods{3,1},methods{3,4})); colorbar; caxis(lim); axis off
saveas(gcf,'figures/fig6.fig')

