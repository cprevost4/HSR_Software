% EXPERIMENT 1: HOSVD FOR VARIOUS RANKS %
% Copyright (c) 2019 Clemence Prevost, Konstantin Usevich, Pierre Comon,
% David Brie
% https://github.com/cprevost4/HSR_Software
% Contact: clemence.prevost@univ-lorraine.fr


%% Simulations for Indian Pines 

fprintf('Generating Figure 15...')

SRI = cell2mat(struct2cell(load('Indian_pines.mat')));
SRI(:,:,[104:108 150:163 220]) = []; %Regions of water absorption
SRI(1,:,:) = []; SRI(:,1,:) = [];
Pm = spectral_deg(SRI,"LANDSAT");
MSI = tmprod(SRI,Pm,3);
d1 = 4; d2 = 4; q = 9;
[P1,P2] = spatial_deg(SRI, q, d1, d2);
HSI = tmprod(tmprod(SRI,P1,1),P2,2);
lambda = 1;

R1 = 10:50; R3 = 2:25; snr = []; cost = [];
for i=1:length(R1)
    for j=1:length(R3)
        R = [R1(i),R1(i),R3(j)]
        if not((R3(j)<=size(MSI,3) || R1(i)<=size(HSI,1)) && (R1(i)<=min(R3(j),size(MSI,3))*R1(i) && R3(j)<=min(R1(i),size(HSI,1))^2))
            snr(i+9,j+1) = NaN; cost(i+9,j+1) = NaN;
        else  
            [SRI_hat,info] = scott2(HSI, MSI, P1, P2, Pm, R);
            snr(i+9,j+1) = r_snr(SRI,SRI_hat); 
            cost(i+9,j+1) = cost_scott(info.factors,info.core, HSI, MSI, lambda, P1,P2,Pm);
        end
    end
end


R3 = 2:25; R1 = 10:50;
snr(find(snr==0)) = 24;
cost(find(cost==0)) = 0.7e10;
cost(cost==0) = 0.2e10;

figure
subplot(1,2,1)
imagesc(snr)
xlabel("R_3");ylabel("R_1 = R_2");
rectangle('Position',[5.5 35.5 50.5 50.5],'FaceColor',[1,1,1])
grid on; set(gca,'layer','top')
colorbar
xlim([1.5 25.5]); ylim([9.5 50.5]);
subplot(1,2,2)
imagesc(cost)
xlabel("R_3");ylabel("R_1 = R_2");
rectangle('Position',[5.5 35.5 50.5 50.5],'FaceColor',[1,1,1])
grid on; set(gca,'layer','top')
colorbar
xlim([1.5 25.5]); ylim([9.5 50.5]);
saveas(gcf,'figures/fig15.fig')

%% Simulations for  Salinas-A

fprintf('Generating Figure 16...')

SRI = cell2mat(struct2cell(load('SalinasA.mat')));
SRI(:,:,[108:112 154:167 224]) = []; %Regions of water absorption (Salinas)
SRI = crop(SRI,[80,84,size(SRI,3)]);
Pm = spectral_deg(SRI,"LANDSAT");
d1 = 4; d2 = 4; q = 9;
[P1,P2] = spatial_deg(SRI, q, d1, d2);
MSI = tmprod(SRI,Pm,3); HSI = tmprod(tmprod(SRI,P1,1),P2,2);

lambda = 1; 
R1 = 10:50; R3 = 2:25; snr = []; cost = [];
for i=1:length(R1)
    for j=1:length(R3)
        R = [R1(i),R1(i),R3(j)]
        if not((R3(j)<=size(MSI,3) || R1(i)<=size(HSI,1)) && (R1(i)<=min(R3(j),size(MSI,3))*R1(i) && R3(j)<=min(R1(i),size(HSI,1))^2))
            snr(i+9,j+1) = 0; cost(i+9,j+1) = 0;
        else  
            [SRI_hat,info] = scott2(HSI, MSI, P1, P2, Pm, R);
            snr(i+9,j+1) = r_snr(SRI,SRI_hat); 
            cost(i+9,j+1) = cost_scott(info.factors,info.core, HSI, MSI, lambda, P1,P2,Pm);
        end
    end
end


R3 = 2:25; R1 = 10:50;
snr(find(snr==0)) = 24;
cost(find(cost==0)) = 0.2e9;
snr(snr==0) = 14;
cost(cost==0) = 0.17e9;

figure
subplot(1,2,1)
imagesc(snr)
colorbar
xlabel("R_3");ylabel("R_1 = R_2");
rectangle('Position',[6.5 20.5 50.5 50.5],'FaceColor',[1,1,1])
grid on; set(gca,'layer','top')
xlim([1.5 25.5]); ylim([9.5 50.5]);
subplot(1,2,2)
imagesc(cost)
colorbar
xlabel("R_3");ylabel("R_1 = R_2");
rectangle('Position',[6.5 20.5 50.5 50.5],'FaceColor',[1,1,1])
grid on; set(gca,'layer','top')
xlim([1.5 25.5]); ylim([9.5 50.5]);
saveas(gcf,'figures/fig16.fig')


