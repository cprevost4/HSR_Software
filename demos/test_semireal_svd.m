% SVD OF UNFOLDINGS %
% Copyright (c) 2019 Clemence Prevost, Konstantin Usevich, Pierre Comon,
% David Brie
% https://github.com/cprevost4/HSR_Software
% Contact: clemence.prevost@univ-lorraine.fr

%% SVD for Indian Pines 

fprintf('Generating Figure 13...')

SRI = cell2mat(struct2cell(load('Indian_pines.mat')));
SRI(:,:,[104:108 150:163 220]) = []; %Regions of water absorption
SRI(1,:,:) = []; SRI(:,1,:) = [];
Pm = spectral_deg(SRI,"LANDSAT");
MSI = tmprod(SRI,Pm,3);
d1 = 4; d2 = 4; q = 9;
[P1,P2] = spatial_deg(SRI, q, d1, d2);
HSI = tmprod(tmprod(SRI,P1,1),P2,2);

figure
   subplot(1,3,1)
    x = svd(tens2mat(MSI,1,[]));
    ylim auto
    semilogy(x(:),'-s','MarkerSize',0.4,'Linewidth',0.8)
    title('1st unfolding MSI')
   subplot(1,3,2)
    y = svd(tens2mat(MSI,2,[]));
    ylim auto
    semilogy(y(:),'-s','MarkerSize',0.4,'Linewidth',0.8)
    title('2nd unfolding MSI')
   subplot(1,3,3)
    z = svd(tens2mat(HSI,3,[]));
    ylim auto
    semilogy(z(:),'-s','MarkerSize',0.4,'Linewidth',0.8)
    title('3rd unfolding HSI')
saveas(gcf,'figures/fig13.fig') 

%% SVD for Salinas-A

fprintf('Generating Figure 14...')

SRI = cell2mat(struct2cell(load('SalinasA.mat')));
SRI(:,:,[108:112 154:167 224]) = []; %Regions of water absorption (Salinas)
Pm = spectral_deg(SRI,"LANDSAT");
d1 = 4; d2 = 4; q = 9;
[P1,P2] = spatial_deg(SRI, q, d1, d2);
MSI = tmprod(SRI,Pm,3); HSI = tmprod(tmprod(SRI,P1,1),P2,2);

figure
   subplot(1,3,1)
    x = svd(tens2mat(MSI,1,[]));
    ylim auto
    semilogy(x(:),'-s','MarkerSize',0.4,'Linewidth',0.8)
    title('1st unfolding MSI')
   subplot(1,3,2)
    y = svd(tens2mat(MSI,2,[]));
    ylim auto
    semilogy(y(:),'-s','MarkerSize',0.4,'Linewidth',0.8)
    title('2nd unfolding MSI')
   subplot(1,3,3)
    z = svd(tens2mat(HSI,3,[]));
    ylim auto
    semilogy(z(:),'-s','MarkerSize',0.4,'Linewidth',0.8)
    title('3rd unfolding HSI')
saveas(gcf,'figures/fig14.fig') 



    


    