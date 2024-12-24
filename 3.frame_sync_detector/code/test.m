clear;
clc;

% 定义一个复数序列
load('pPLHeader.mat'); 
fileID = fopen('data.bin', 'r');
data = fread(fileID, 'int16');
fclose(fileID);

% 调用matchedFilter函数
y = matchedFilter(data,pPLHeader);

