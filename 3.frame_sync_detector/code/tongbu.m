% 清理工作区和命令窗口
clear;
clc;

% 加载数据
% load('outsignal1.mat'); 
load('pPLHeader.mat'); 

% 打开文件
fileID = fopen('data.bin', 'r');

% 读取文件中的数据，假设文件中存储的是 int16 类型的数据
data = fread(fileID, 'int16');

% 关闭文件
fclose(fileID);
% 将 int16 数据归一化到 -1 到 1 之间
data = double(data) / 32768;

% 将数据转换为复数形式
real_part = data(1:2:end); % 奇数索引是实部
imag_part = data(2:2:end); % 偶数索引是虚部

% 组合成复数形式
data = real_part + 1i * imag_part;

data = data(~isnan(data));

% 从工作区加载QPSK信号和同步头
QPSK_signal = double(evalin('base', 'data')); % 从工作区加载并转换为双精度
sync_head = double(evalin('base', 'pPLHeader')); % 从工作区加载并转换为双精度

[Csh,lagsh] = xcorr(QPSK_signal,sync_head); % lagsh表示信号落后帧头多少个样本点
Csh = Csh/max(Csh);

% 设置一个阈值来检测相关性峰值
threshold = 0.85; % 根据需要调整阈值

% 找到所有超过阈值的相关性峰值位置
peak_indices = find(Csh > threshold);

% 得到所有对齐的时刻
alignment_times = lagsh(peak_indices);


[Msh,Ish] = max(Csh);
tsh = lagsh(Ish);

% 截取对齐后的QPSK信号的前90个样本点
num_samples = 90; % 帧头的长度
QPSK_signal_aligned = QPSK_signal(tsh:tsh + num_samples - 1);

% 可视化结果
figure;
subplot(2,1,1);
plot(real(sync_head));
title('同步头');
xlabel('样本点');
ylabel('幅度');
hold on;


subplot(2,1,2);
plot(real(QPSK_signal_aligned));
title('对齐后的QPSK信号的前90个样本点');
xlabel('样本点');
ylabel('幅度');

% 添加代码显示QPSK信号相对于帧头的滞后值
fprintf('QPSK信号落后帧头的样本点数: %d\n', tsh);
% fprintf('QPSK信号和帧头对齐的时刻: %d\n', alignment_times);