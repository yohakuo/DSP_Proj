clear;clc;
load data.mat;
figure(1);[Pxx,fx,SigPow]=PWelch(data,30e6,2048,1024,28e6);plot(fx,Pxx);grid;axis([-15 15 20 65])
figure(2);[Pxx,fx,SigPow]=PWelch(real(data),30e6,2048,1024,28e6);plot(fx,Pxx);grid;axis([-15 15 20 65])  %　Ｉ中有C/A码
figure(3);[Pxx,fx,SigPow]=PWelch(imag(data),30e6,2048,1024,28e6);plot(fx,Pxx);grid;axis([-15 15 20 65])


