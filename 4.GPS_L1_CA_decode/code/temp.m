clc;
clear;
close all;
% 生成有极性的0,1序列,长度为20
B_code=2*randi([0,1],1,20)-1;
figure();stem(B_code);title('原信号');

fs=1e3; %采样率,1000采样点
rb=300;	%码元速率

n=floor((0:length(B_code)*fs/rb-1)*rb/fs)+1;
B_stream =B_code(n);

figure();
stem(B_stream);title('采样后信号');
