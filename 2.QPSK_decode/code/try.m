clc; 
clear all; 
close all; 

fileID = fopen('1697_2.dat', 'rb');
if fileID == -1
    error('文件打开失败');
end

% 指定要读取的数据数量，例如读取1000个int16数据
numData = 100000;
fileData = fread(fileID, numData, '*int16');
fclose(fileID);

Fs = 360e3; 
symbolRate = 90e3; 

% 进行FFT变换 
N = length(fileData); % 数据点数 
fftData = fft(fileData); 

% 计算双边频谱的幅度并取对数，便于观察 
fftMagLog = 20*log10(abs(fftData)); % 生成频率向量 
f = Fs * (0:(N/2)) / N; 

% 绘制单边对数频谱图 
figure; 
plot(f, fftMagLog(1:N/2+1)); 
xlabel('Frequency (Hz)'); 
ylabel('Magnitude (dB)'); 
title('Single-Sided Logarithmic Amplitude Spectrum of the Signal'); 
% 在这里，你需要观察频谱图，寻找是否有与90 KBPS符号速率相关的频率成分出现幅度峰值。


% % 自相关分析
% figure; 
% [R, lags] = xcorr(fileData, 'coeff');
% plot(lags, abs(R));
% xlabel('Lags');
% ylabel('Correlation');
% title('Autocorrelation of the Signal');
% 
% % 能量分析
% figure; 
% windowSize = 100; % 设置一个窗口大小，这需要根据你的信号特性来设定
% energy = conv(fileData.^2, ones(windowSize, 1), 'same');
% plot(energy);
% xlabel('Sample Index');
% ylabel('Energy');
% title('Short-time Energy of the Signal');


% %% 
% Fs = 360e3; % 采样频率为 360 KSPS
% N = length(fileData); % 数据点数
% 
% % 进行FFT变换
% fftData = fft(fileData);
% % 计算双边频谱的幅度
% fftMag = abs(fftData);
% % 生成频率向量，这里使用了单边频谱所以只取了一半的频率范围
% f = Fs * (0:(N/2)) / N;
% 
% % 绘制单边频谱的幅度
% figure;
% plot(f, fftMag(1:N/2+1));
% xlabel('Frequency (Hz)');
% ylabel('Magnitude');
% title('Single-Sided Amplitude Spectrum of the Signal');
% 
% % 如果需要绘制功率谱密度（PSD）
% fftMagNorm = fftMag / N; % 归一化幅度
% psd = fftMagNorm(1:N/2+1).^2; % 单边功率谱密度
% psd(2:end-1) = 2 * psd(2:end-1); % 除了直流分量外，其他分量需要乘以2
% 
% % 绘制功率谱密度
% figure;
% plot(f, 10*log10(psd));
% xlabel('Frequency (Hz)');
% ylabel('Power/Frequency (dB/Hz)');
% title('Single-Sided Power Spectral Density of the Signal');

