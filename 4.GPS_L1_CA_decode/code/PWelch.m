function [Pxx,fx,SigPow]=PWelch(SignalCalibration,Fs,Nfft,overlap,BandWid)
% 求功率谱　
% 输入信号，采样频率，FFT的点数，窗口之间的重叠样本数，用于计算信号功率的频带宽度
w = 0.5*(1 - cos(2*pi*(1:Nfft)/(Nfft+1)));
n = length(SignalCalibration);		          
nwind = length(w);   
k = fix((n-overlap)/(nwind-overlap)); 
index = 1:nwind;
KMU = k*norm(w)^2;	% Normalizing scale factor ==> asymptotically unbiased
% Calculate PSD
Spec = zeros(1,Nfft);
for i=1:k
   xw = w.*SignalCalibration(index);
   index = index + (nwind - overlap);
   Xx = abs(fft(xw,Nfft)).^2;
   Spec = Spec + Xx;
end

Pxx = (Spec / (KMU *Fs));
f = 0:(2*pi/Nfft):(2*pi-2*pi/Nfft);
f = f*Fs/(2*pi);    % freqvector wanted in Hz
Pxx = fftshift(Pxx);
MidIndex = Nfft/2+1;
fx = (f-Fs/2)/1e6;
IndOffset = round(BandWid/(Fs/Nfft)*0.5);
SigPow = 10*log10(sum(Pxx((MidIndex-IndOffset:MidIndex+IndOffset)))*Fs/Nfft);
Pxx = 10*log10((Pxx*Fs/Nfft*10));