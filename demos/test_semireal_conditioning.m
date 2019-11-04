addpath ../src

%% Condition number for Indian Pines

fprintf('Generating Figure 17...')

SRI = cell2mat(struct2cell(load('Indian_pines.mat')));
SRI(:,:,[104:108 150:163 220]) = []; %Regions of water absorption
SRI(1,:,:) = []; SRI(:,1,:) = [];
Pm = spectral_deg(SRI,"LANDSAT");
MSI = tmprod(SRI,Pm,3);
d1 = 4; d2 = 4; q = 9;
[P1,P2] = spatial_deg(SRI, q, d1, d2);
HSI = tmprod(tmprod(SRI,P1,1),P2,2);

% Find singular vectors and their projections
[U, S1, ~] = svd(tens2mat(MSI,1,[]),0);
[V, S2, ~] = svd(tens2mat(MSI,2,[]),0);
[W, S3, ~] = svd(tens2mat(HSI,3,[]),0);
PU = P1 * U; PV = P2 * V; PW = Pm * W;
I_H = size(PU,1); J_H = size(PV,1); K_M = size(Pm,1);

sigmaU = zeros(I_H,2); sigmaV = zeros(J_H,2); s1W = zeros(200,1);
for i=1:size(sigmaU,1), 
  sU = svd(PU(:,1:i)); 
  sigmaU(i,:) = [sU(1) sU(end)]; 
end
for i=1:size(sigmaV,1), 
  sV = svd(PV(:,1:i)); 
  sigmaV(i,:) = [sV(1) sV(end)]; 
end
for i=1:size(s1W,1), s1W(i) = norm(PW(:,1:i),2); end

minIJ_H = min(I_H,J_H);
condXtX = ((sigmaU(1:minIJ_H,1).*sigmaV(1:minIJ_H,1)).^2 + s1W(K_M)^2) ./ ...
          ((sigmaU(1:minIJ_H,2).*sigmaV(1:minIJ_H,2)).^2);
      
figure 
subplot(1,2,1)
semilogy(condXtX)
xlabel('R_1 = R_2'); ylabel('$\mathrm{cond}({\bf X}^{\rm T} {\bf X}) $', 'Interpreter', 'latex')
set(gcf, 'Position',  [100, 100, 200, 160])
subplot(1,2,2)
plot(6:25, s1W(6:25));
xlabel('R_3'); ylabel('$\sigma_1({\bf P}_M \widehat{\bf W})$', 'Interpreter', 'latex')
set(gcf, 'Position',  [100, 100, 200, 160])
saveas(gcf,'figures/fig17.fig')

%% Condition number for Salinas-A

fprintf('Generating Figure 18...')

SRI = cell2mat(struct2cell(load('SalinasA.mat')));
%SRI = crop(SRI,[80,84,size(SRI,3)]);
SRI(:,:,[108:112 154:167 224]) = [];
Pm = spectral_deg(SRI,"LANDSAT");
MSI = tmprod(SRI,Pm,3);
d1 = 4; d2 = 4; q = 9;
[P1,P2] = spatial_deg(SRI, q, d1, d2);
HSI = tmprod(tmprod(SRI,P1,1),P2,2);

% Find singular vectors and their projections
[U, S1, ~] = svd(tens2mat(MSI,1,[]),0);
[V, S2, ~] = svd(tens2mat(MSI,2,[]),0);
[W, S3, ~] = svd(tens2mat(HSI,3,[]),0);
PU = P1 * U; PV = P2 * V; PW = Pm * W;
I_H = size(PU,1); J_H = size(PV,1); K_M = size(Pm,1);

sigmaU = zeros(I_H,2); sigmaV = zeros(J_H,2); s1W = zeros(200,1);
for i=1:size(sigmaU,1), 
  sU = svd(PU(:,1:i)); 
  sigmaU(i,:) = [sU(1) sU(end)]; 
end
for i=1:size(sigmaV,1), 
  sV = svd(PV(:,1:i)); 
  sigmaV(i,:) = [sV(1) sV(end)]; 
end
for i=1:size(s1W,1), s1W(i) = norm(PW(:,1:i),2); end

minIJ_H = min(I_H,J_H);
condXtX = ((sigmaU(1:minIJ_H,1).*sigmaV(1:minIJ_H,1)).^2 + s1W(K_M)^2) ./ ...
          ((sigmaU(1:minIJ_H,2).*sigmaV(1:minIJ_H,2)).^2);
      
figure 
subplot(1,2,1)
semilogy(condXtX)
xlabel('R_1 = R_2'); ylabel('$\mathrm{cond}({\bf X}^{\rm T} {\bf X}) $', 'Interpreter', 'latex')
set(gcf, 'Position',  [100, 100, 200, 160])
subplot(1,2,2)
plot(6:25, s1W(6:25));
xlabel('R_3'); ylabel('$\sigma_1({\bf P}_M \widehat{\bf W})$', 'Interpreter', 'latex')
set(gcf, 'Position',  [100, 100, 200, 160])
saveas(gcf,'figures/fig18.fig')










