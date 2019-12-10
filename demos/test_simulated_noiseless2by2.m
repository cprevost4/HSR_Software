% EXPERIMENT 1: R-SNR FOR NOISELESS SIMULATED SRI 2x2x2 %
% Copyright (c) 2019 Clemence Prevost, Konstantin Usevich, Pierre Comon,
% David Brie
% https://github.com/cprevost4/HSR_Software
% Contact: clemence.prevost@univ-lorraine.fr

%% Generate 2x2 noiseless dataset

warning('off')
fprintf('Generating Figure 7 ...')

load('2x2_synth.mat')
Pm = spectral_deg(X,"LANDSAT");
MSI = tmprod(X,Pm,3);
d1 = 4; d2 = 4; q = 9;
[P1,P2] = spatial_deg(X, q, d1, d2);
HSI = tmprod(tmprod(X,P1,1),P2,2);

figure
subplot(1,2,1)
imagesc(X(:,:,44)); title('Spectral band 44')
subplot(1,2,2)
imagesc(X(:,:,160)); title('Spectral band 160')
saveas(gcf,'figures/fig7.fig')

%% Simulations for 2x2 noiseless dataset

fprintf('Generating Figure 8 ...')

snr_stereo = []; snr_scott = []; snr_tenrec = [];
 for F=1:40
    try
        [SRI_hat2, ~] = stereo_adaptor(HSI, MSI, P1,P2,Pm, F);
        SRI_hat2 = real(SRI_hat2); snr_stereo(F,1) = r_snr(X,SRI_hat2);
    catch
        snr_stereo(F,1) = NaN;
        continue
    end
 end
 
 for F=1:40
     try
        [A,B,C,~,~,~]=TenRec(MSI,tens2mat(HSI,[],3),25,F,P1,P2);
        snr_tenrec(F,1) = r_snr(X,cpdgen({A,B,C}));
    catch
        snr_tenrec(F,1) = NaN;
        continue
     end
 end

 for r1=1:size(HSI,1)+10
    for r3=1:10
        if not((r3<=size(MSI,3) || r1<=size(HSI,1)) && r3<=(min(r1,size(HSI,1)))^2)%identifiability
             snr_scott(r1,r3) = NaN;
        else
            [SRI_hat2,~] = scott2(HSI, MSI, P1, P2, Pm, R);
            snr_scott(r1,r3) = r_snr(X,SRI_hat2);
        end
    end
end

figure
subplot(1,2,1)
plot(1:40,snr_stereo); hold on; plot(1:40, snr_scott(:,2)); hold on;
plot(1:40,snr_tenrec)
legend('STEREO','SCOTT (R_3=N)','TenRec')
xlabel('F'); ylabel('SNR (dB)');...
    xlim([1 40]); title('STEREO, TenRec and SCOTT')
subplot(1,2,2)
surf(1:10,1:size(HSI)+10,snr_scott); xlabel('R_3');...
    ylabel('R_1 = R_2'); title('SCOTT')

saveas(gcf,'figures/fig8.fig')





