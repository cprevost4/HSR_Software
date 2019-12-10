% SPECTRA FOR INDIAN PINES %
% Copyright (c) 2019 Clemence Prevost, Konstantin Usevich, Pierre Comon,
% David Brie
% https://github.com/cprevost4/HSR_Software
% Contact: clemence.prevost@univ-lorraine.fr

%% Load Indian Pines + groundtruth data

SRI = cell2mat(struct2cell(load('Indian_pines.mat')));
SRI(:,:,[104:108 150:163 220]) = []; %Regions of water absorption
SRI(1,:,:) = []; SRI(:,1,:) = [];
Pm = spectral_deg(SRI,"LANDSAT");
MSI = tmprod(SRI,Pm,3);
d1 = 4; d2 = 4; q = 9;
[P1,P2] = spatial_deg(SRI, q, d1, d2);
HSI = tmprod(tmprod(SRI,P1,1),P2,2);
load('Indian_pines_gt.mat'); indian_pines_gt(:,1) = []; indian_pines_gt(1,:) = [];

%% Figure - original spectral for mat. 4,7,9,14

fprintf('Generating Figure 20 ...')

X = tens2mat(SRI,3,[]); mat = [4 7 9 14];
figure
for i=1:length(mat)
    ind = find(reshape(indian_pines_gt,1,[]) == mat(i));
    s = real(mean(X(:,ind),2));
    
    plot(s); hold on
end
title('Original spectra'), legend('Mat.4','Mat.7','Mat.9','Mat.14')
saveas(gcf,'figures/fig20.fig')

%% Figure - residual error

fprintf('Generating Figure 21 ...')

methods = {'STEREO' 'stereo_adaptor' '100'; ...
           'SCOTT' 'scott2' '[40,40,6]';...
           'SCOTT' 'scott2' '[30,30,16]';...
           'SCOTT' 'scott2' '[24,24,25]';};      
DegMat = struct('Pm', Pm, 'P1', P1, 'P2', P2);         
[~, est] = compare_methods(SRI, HSI, MSI, DegMat, [d1 d2], methods); 

X = tens2mat(SRI,3,[]); mat = [4 7 9 14];
Xhat1 = tens2mat(real(est{1}),3,[]); Xhat2 = tens2mat(real(est{2}),3,[]);
Xhat3 = tens2mat(real(est{3}),3,[]); Xhat4 = tens2mat(real(est{4}),3,[]);

figure
for i=1:length(mat)
    ind = find(reshape(indian_pines_gt,1,[]) == mat(i));
    s = real(mean(X(:,ind),2)); s1 = real(mean(Xhat1(:,ind),2));
    s2 = real(mean(Xhat2(:,ind),2)); s3 = real(mean(Xhat3(:,ind),2));
    s4 = real(mean(Xhat4(:,ind),2));
    
    subplot(2,2,i)
    plot((s-s1)./s,'Linewidth',1);hold on;
    plot((s-s2)./s,'Linewidth',1);hold on;
    plot((s-s3)./s,'Linewidth',1);hold on;
    plot((s-s4)./s,'Linewidth',1)
     title(sprintf('Material %d',mat(i)))
    legend(sprintf('%s,%s',methods{1,1},methods{1,3}),...
        sprintf('%s,%s',methods{2,1},methods{2,3}),...
        sprintf('%s,%s',methods{3,1},methods{3,3}),...
        sprintf('%s,%s',methods{4,1},methods{4,3}));
    ylim([-0.3 0.15])
end
saveas(gcf,'figures/fig21.fig')

%% Figure - spectral bins 80 to 100

fprintf('Generating Figure 22 ...')

methods = {'STEREO' 'stereo_adaptor' '100'; ...
           'SCOTT' 'scott2' '[40,40,6]';...
           'SCOTT' 'scott2' '[30,30,16]';...
           'SCOTT' 'scott2' '[24,24,25]';};      
DegMat = struct('Pm', Pm, 'P1', P1, 'P2', P2);         
[~, est] = compare_methods(SRI, HSI, MSI, DegMat, [d1 d2], methods); 

X = tens2mat(SRI,3,[]); mat = [4 7 9 14];
Xhat1 = tens2mat(real(est{1}),3,[]); Xhat2 = tens2mat(real(est{2}),3,[]);
Xhat3 = tens2mat(real(est{3}),3,[]); Xhat4 = tens2mat(real(est{4}),3,[]);

figure
for i=1:length(mat)
    ind = find(reshape(indian_pines_gt,1,[]) == mat(i));
    s = real(mean(X(:,ind),2)); s1 = real(mean(Xhat1(:,ind),2));
    s2 = real(mean(Xhat2(:,ind),2)); s3 = real(mean(Xhat3(:,ind),2));
    s4 = real(mean(Xhat4(:,ind),2));
    
    subplot(2,2,i)
    plot(s(80:100),'Linewidth',1);hold on;
    plot(s1(80:100),'Linewidth',1);hold on;
    plot(s2(80:100),'Linewidth',1);hold on;
    plot(s3(80:100),'Linewidth',1); hold on;
    plot(s4(80:100),'Linewidth',1)
     title(sprintf('Material %d',mat(i)))
    legend('Original spectrum',...
        sprintf('%s,%s',methods{1,1},methods{1,3}),...
        sprintf('%s,%s',methods{2,1},methods{2,3}),...
        sprintf('%s,%s',methods{3,1},methods{3,3}),...
        sprintf('%s,%s',methods{4,1},methods{4,3}));
end
saveas(gcf,'figures/fig22.fig')

