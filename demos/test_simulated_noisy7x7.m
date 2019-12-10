% SYNTHETIC SALINAS/BTD EXAMPLE %
% Copyright (c) 2019 Clemence Prevost, Konstantin Usevich, Pierre Comon,
% David Brie
% https://github.com/cprevost4/HSR_Software
% Contact: clemence.prevost@univ-lorraine.fr

%% Load Salinas-like BTD example

fprintf('Generating Figure 9 ...')

warning('off')
load('noisy_BTDSalinas.mat');
Pm = spectral_deg(SRI,"Quickbird");
d1 = 4; d2 = 4; q = 9; [P1,P2] = spatial_deg(SRI, q, d1, d2);

figure
subplot(1,2,1)
imagesc(SRI(:,:,44)); title('Spectral band 44')
subplot(1,2,2)
imagesc(SRI(:,:,160)); title('Spectral band 160')
saveas(gcf,'figures/fig9.fig')

%% Run simulations for Salinas-like BTD example

fprintf('Generating Figure 10 ...')
        
snr_stereo = []; snr_scott = []; snr_tenrec = [];
 for F=1:size(HSI,1)+10
    try
        [SRI_hat2, ~] = stereo_adaptor(HSI, MSI, P1,P2,Pm, F);
        SRI_hat2 = real(SRI_hat2); snr_stereo(F,1) = r_snr(SRI,SRI_hat2);
    catch
        snr_stereo(F,1) = NaN;
        continue
    end
    try
        [A,B,C,~,~,~]=TenRec(MSI,tens2mat(HSI,[],3),25,F,P1,P2);
        snr_tenrec(F,1) = r_snr(SRI,cpdgen({A,B,C}));
    catch
        snr_tenrec(F,1) = NaN;
        continue
    end
 end

 for r1=1:size(HSI,1)+10
    for r3=1:20
        R = [r1 r1 r3];
        if not((r3<=size(MSI,3) || r1<=size(HSI,1)) && r3<=(min(r1,size(HSI,1)))^2)%identifiability
             snr_scott(r1,r3) = NaN;
        else
            [SRI_hat2,~] = scott2(HSI, MSI, P1, P2, Pm, R);
            snr_scott(r1,r3) = r_snr(SRI,SRI_hat2);
        end
    end
 end
 
figure
subplot(1,2,1)
plot(1:size(HSI,1)+10,snr_stereo); hold on;
plot(1:size(HSI,1)+10, snr_scott(:,7)); hold on;
plot(1:size(HSI,1)+10, snr_scott(:,15));
plot(1:size(HSI,1)+10, snr_tenrec);
legend('STEREO','SCOTT R_3 = N','SCOTT R_3 = 15','TenRec')
xlabel('F'); ylabel('SNR (dB)');xlim([1 40])
title('STEREO, TenRec and SCOTT')
subplot(1,2,2)
surf(1:20,1:size(HSI)+10,snr_scott) 
xlabel('R_3'); ylabel('R_1 = R_2'); title('SCOTT')
saveas(gcf,'figures/fig10.fig')

