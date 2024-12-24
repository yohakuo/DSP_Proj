clc
close all
clear

fs = 1000;          % 采样率 1000 Hz
T = 1;              % 1s
t = 0:1/fs:T-1/fs;  

x= sin(80*2*pi*t)+2*sin(140*2*pi*t);

x_n=x+randn(size(t));

% 设计FIR滤波器
n = 100; % 滤波器阶数
f = [0 0.13 0.16  0.19 0.25 0.28 0.31 1];
m = [0 0 1  0 0 1  0 0];
b = firls(n, f, m);

% 滤波
y_t = filter(b, 1, x_n);

%% 图
%绘制原始信号，加噪声信号和滤波后信号
figure;
subplot(3,1,1);
plot(t, x);
title('原始信号');
xlabel('时间 (秒)');
ylabel('幅度');
xlim([0 0.2]); % 观测前0.1秒的信号

subplot(3,1,2);
plot(t, x_n);
title('加噪声信号');
xlabel('时间 (秒)');
ylabel('幅度');
xlim([0 0.2]);

subplot(3,1,3);
plot(t, y_t);
title('滤波后信号');
xlabel('时间 (秒)');
ylabel('幅度');
xlim([0 0.2]);

% 显示滤波器的频率响应
figure;
freqz(b, 1, 512, fs);
title('FIR滤波器的频率响应');