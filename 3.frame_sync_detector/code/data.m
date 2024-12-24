% 帧同步检测的输入
clear;
clc;

load('pPLHeader.mat'); 
pPLHeader=pPLHeader.';

fileID = fopen('data.bin', 'r');
data = fread(fileID, 'int16');
fclose(fileID);
% data = data / 32767;
% 
% data=fi(data,1,16,14);
% data = data(~isnan(data));
% 
% time = (0:length(data)-1)' ; % 时间数组
% data = timeseries(data, time);
