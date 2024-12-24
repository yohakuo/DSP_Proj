% figure(1);[Pxx,fx,SigPow]=PWelch(x,30e6,2048,1024,28e6);
% plot(fx,Pxx);
% 
% grid;axis([-15 15 85 95])  %　Ｉ中有C/A码
clear;clc;
load data.mat;
x=fft(real(data));
%% 参数
%CA信号的rb为1.023e6

fs = 30e6; % 采样率30e6
N = length(x); % 信号长度3e4,则需要在fs的条件下,持续时间位1ms
f = (-N/2:N/2-1)*(fs/N); % 频率轴

signal_fft_shifted = fftshift(x); % 频谱中心化

% 绘制频谱图
figure(1);
plot(f, abs(signal_fft_shifted));
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('LA_I路信号的FFT');

fs_new = 40.92e6; % 新采样率40.92MSPS
N_new = round(N * (fs_new / fs));
f = (-N_new/2:N_new/2-1)*(fs_new / N_new); % 频率轴
%% 补零
 pad_length = (N_new - N) / 2;
 padded_fft = [zeros(1, pad_length), signal_fft_shifted, zeros(1, pad_length)];

% 绘制插值后的频谱图
figure(2);
plot(f, abs(padded_fft));
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('插值后的C/A码的频域图');

%% 滤波
ca_rate = 1.023e6; % C/A码速率1.023MSPS
filter_mask = (abs(f) <= ca_rate);
filtered_fft = padded_fft .* filter_mask;

% 绘制过滤后的频谱图
figure(3);
plot(f, abs(filtered_fft));
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('过滤后C/A码的频域图');

% 计算过滤后的逆FFT
filtered_signal = ifft(ifftshift(filtered_fft));



% 绘制时域图
t_new = (0:N_new-1) / fs_new;
figure;
plot(t_new, real(filtered_signal));
xlabel('Time (s)');
ylabel('Amplitude');
title('时域波形');

