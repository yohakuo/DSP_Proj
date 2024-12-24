clc
close all
clear
n = 0:500; 
x = cos(0.48*pi*n) + cos(0.52*pi*n); % 周期为两余弦周期的公倍数,为50
% plot(x);
%1
x1 = x(1:10);
N1 = 10;
plot_fft(x1, N1);
%2
x2 = [x1, zeros(1, 100-10)];
N2 = 100;
plot_fft(x2, N2);
%3
x3 = x(1:100); %周期的两倍
N3 = 100;
plot_fft(x3, N3);
%4 
x4 = x(1:128); %非周期的倍数
N4 = 128;
plot_fft(x4, N4);
%5
x5 = x(1:50);
N5 = 50;
plot_fft(x5, N5);
