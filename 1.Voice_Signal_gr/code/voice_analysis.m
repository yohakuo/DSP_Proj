% 读取音频文件
filename = 'luyin.wav'; % 替换为你的音频文件路径
[x, fs] = audioread(filename);

% 绘制波形图
t = (0:length(x)-1) / fs;
figure;
subplot(2, 1, 1);
plot(t, x);
title('Audio Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% 计算并绘制频谱图
NFFT = 2^nextpow2(length(x));
Y = fft(x, NFFT) / length(x);
f = fs / 2 * linspace(0, 1, NFFT/2 + 1);
subplot(2, 1, 2);
plot(f, 2 * abs(Y(1:NFFT/2+1)));
title('Frequency Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');