% EXPERIMENT 1: HOSVD OF UNFOLDINGS %
% Copyright (c) 2019 Clemence Prevost, Konstantin Usevich, Pierre Comon,
% David Brie
% https://github.com/cprevost4/HSR_Software
% Contact: clemence.prevost@univ-lorraine.fr

%% Load 2-material dataset

fprintf('Generating Figure 12...')

load('2x2_synth.mat')
MSI_gt = MSI; HSI_gt = HSI; clear MSI; clear HSI;
lvl = ["20","35","60","Inf"];
leg = {'20dB SNR', '35dB SNR','60dB SNR','Inf. SNR'};

figure
for j=1:length(lvl)
    for k=1:size(MSI_gt,3)
        eval(sprintf('MSI(:,:,k) = awgn(MSI_gt(:,:,k),%s);',lvl(j)))
    end
    for k=1:size(HSI_gt,3)
        eval(sprintf('HSI(:,:,k) = awgn(HSI_gt(:,:,k),%s);',lvl(j)))
    end

   subplot(1,3,1)
    x = log(svd(tens2mat(MSI,1,[])));
    ylim auto
    plot(x(1:15),'-s','MarkerSize',3,'Linewidth',1.1)
    title('1st unfolding MSI')
    legend(leg(1:j),'Location', 'southoutside')
    hold on
   subplot(1,3,2)
    x = log(svd(tens2mat(MSI,2,[])));
    ylim auto
    plot(x(1:15),'-s','MarkerSize',3,'Linewidth',1.1)
    title('2nd unfolding MSI')
    legend(leg(1:j),'Location', 'southoutside')
    hold on
   subplot(1,3,3)
    x = log(svd(tens2mat(HSI,3,[])));
    ylim auto
    plot(x(1:15),'-s','MarkerSize',3,'Linewidth',1.1)
    title('3rd unfolding HSI')
    legend(leg(1:j),'Location', 'southoutside')
    hold on
end
saveas(gcf,'figures/fig12.fig')    

   




