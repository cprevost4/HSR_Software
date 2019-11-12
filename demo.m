% Hyperspectral Super-Resolution with Coupled Tucker Approximation:       %
%               Recoverability and SVD-based algorithms                   %
%-------------------------------------------------------------------------%

% Copyright (c) 2018 Clemence Prevost, Konstantin Usevich, Pierre Comon,
% David Brie
% https://github.com/cprevost4/HSR_Tucker
% Contact: clemence.prevost@univ-lorraine.fr

%-------------------------------------------------------------------------%
%                   DEMO WITH MINIMAL REQUIREMENTS                        %
%-------------------------------------------------------------------------%

%% LOAD DATA

fprintf('Load Indian Pines...\n')

SRI = cell2mat(struct2cell(load('Indian_pines.mat')));
SRI(:,:,[104:108 150:163 220]) = []; %Regions of water absorption
SRI(1,:,:) = []; SRI(:,1,:) = [];
Pm = spectral_deg(SRI,"LANDSAT");
MSI = tmprod(SRI,Pm,3);
d1 = 4; d2 = 4; q = 9;
[P1,P2] = spatial_deg(SRI, q, d1, d2);
HSI = tmprod(tmprod(SRI,P1,1),P2,2);

figure(1)
subplot(1,2,1)
imagesc(HSI(:,:,1)); title('HSI - band 1'); colorbar
subplot(1,2,2)
imagesc(MSI(:,:,1)); title('MSI - band 1'); colorbar

%% RUN ALGORITHMS

R = [40 40 6]; opts.Nblocks = [4 4];
fprintf('Running SCOTT with R = [%d %d %d]...\n',R)
tic; [SRI_hat1, ~] = scott2(HSI, MSI, P1, P2, Pm, R); t1= toc;

R = [36 36 6];
fprintf('Running BSCOTT with R = [%d %d %d] and [%d %d] blocks...\n',R, opts.Nblocks)
tic; [SRI_hat2, ~] = bscott(MSI,HSI,Pm,R,opts); t2 = toc;

figure(2)
subplot(1,3,1)
imagesc(SRI(:,:,44)); title('Groundtruth SRI - band 44')
subplot(1,3,2)
imagesc(SRI_hat1(:,:,44)); title('Result of SCOTT - band 44')
subplot(1,3,3)
imagesc(SRI_hat2(:,:,44)); title('Result of BSCOTT - band 44')

%% METRICS

err1 = cell2mat(compute_metrics(SRI,SRI_hat1,d1,d2));
err2 = cell2mat(compute_metrics(SRI,SRI_hat2,d1,d2));
tab = ["Algorithm" "R-SNR" "CC" "SAM" "ERGAS" "Time (s)";...
       "SCOTT" err1 t1;...
       "BSCOTT" err2 t2];
fprintf('Plot comparison metrics \n')   
tab


