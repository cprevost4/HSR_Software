function [P1,P2] = spatial_deg(DATA, q, d1, d2)

% SRI2HSI computes P1 and P2 from SRI 
% [P1, P2] = SRI2HSI(DATA,d1,d2) returns spatial degradation matrices from SRI DATA
% 
% INPUT ARGUMENTS:
%     DATA: SRI in ImxJmxKh
%     q: size of Gaussian kernel
%     d1: downsampling factor in mode 1
%     d2: downsampling factor in mode 2
% OUTPUT ARGUMENTS:
%     P1: degradation along mode 1 of size IhxIm
%     P2: degradation along mode 2 of size JhxJm
% 
% SEE ALSO: SPECTRAL_DEG
% Copyright (c) 2018 Clemence Prevost, Konstantin Usevich, Pierre Comon, David Brie
% https://github.com/cprevost4/HSR_Tucker
% Contact: clemence.prevost@univ-lorraine.fr


Im = size(DATA,1); Jm = size(DATA,2);
Ih = ceil(Im/d1); Jh = ceil(Jm/d2);
Phi = gauss_kernel(q,1);

% r = [Phi, zeros(1,Im-q)]; c = [Phi(1), zeros(1,Im-1)]; TIm = toeplitz(c,r);
% r = [Phi, zeros(1,Jm-q)]; c = [Phi(1), zeros(1,Jm-1)]; TJm = toeplitz(c,r);
% 
% 
% S1 = zeros(Ih, size(DATA,1)); S2 = zeros(Jh, size(DATA,2));
% for i=1:Ih
%     %if 1+d1*(i-1)<= size(S1,2)
%         S1(i,1+d1*(i-1)) = 1;
%     %end
% end
% for j=1:Jh
%     %if 1+d1*(j-1)<= size(S2,2)
%         S2(j,1+d1*(j-1)) = 1;
%     %end
% end
% 
% P1 = S1*TIm; P2 = S2*TJm;

middlel = round((size(DATA,1)+1)/2);
h1 = Phi; 
B1 = zeros(size(DATA,1),1); B1(middlel-floor(q/2):middlel+floor(q/2)) = h1;
FB1 = fft(ifftshift(B1));
Y = eye(size(DATA,1));
T1 = ifft(fft(Y(:,:,1),[],2).*FB1);

downsamp_factor = d1; shift = 1;
S1 = downsample(eye(size(DATA,1)), downsamp_factor, shift);
P1 = real(S1*T1); %P2 = P1;

 middlec = round((size(DATA,2)+1)/2);
 h2 = Phi; 
 B2 = zeros(size(DATA,2),1); B2(middlec-floor(q/2):middlec+floor(q/2)) = h2;
 FB2 = fft(ifftshift(B2));
 Y = eye(size(DATA,2));
 T2 = ifft(fft(Y(:,:,1),[],2).*FB2);

 downsamp_factor = d2; shift = 1;
 S2 = downsample(eye(size(DATA,2)), downsamp_factor, shift);
 P2 = real(S2*T2);




end


