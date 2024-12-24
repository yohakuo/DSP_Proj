% 处理接收机输出的信号内容
clear;
clc;
load('outsignal1.mat'); 
load('pPLHeader.mat'); 
% 提取前 250 个元素，并且取3000后面，因为前面不稳定
x = values(1:250, 1, 3001:end);

%% 确认帧长
x1=(x(:)); % 变成一列
x1=real(x1(1:1e5));
x2=zeros(100,1);

for ii=1:1000-1
    x2=x1(ii*100+1:(ii+1)*100);
    c=xcorr(x2,x1);%相关性
    c=c(1:1e5+1e2-1);
    c(1e5-1e2*ii)=0;
    if ~isempty(find(abs(c)>200))
        break;
    end
end

plot(c)
head = find(c>200)
framelength = head(2)-head(1)

%% 
x1=(x(:)); % 变成一列
x1=(x1(1:framelength*16));%取8帧的长度
x1=reshape(x1,framelength,[]);%A: 需要重新调整形状的数组或矩阵。m: 重新调整后的行数。n: 重新调整后的列数。
x1=sum(x1,2); %指定的维度参数，表示对矩阵的第2维进行求和。对于一个二维矩阵，dim=2表示对每一行的所有列元素进行求和。
figure(2);
stem(imag(x1))


%
x1=(x(:)); % 变成一列

sync_head = pPLHeader;
sync_length = length(sync_head);
data_length=length(x1)

% 计算同步头与数据的相关性
correlation = xcorr(x1, sync_head);
correlation = correlation(data_length:end); % 只保留正相关部分

% 找到相关性峰值位置
[~, sync_position] = max(abs(correlation));

% 提取同步头在数据中的位置
sync_end = sync_position + sync_length - 1;
if sync_end > data_length
    error('同步头位置超出数据范围。');
end

% 提取同步头数据
extracted_sync_head = x1(sync_position:sync_end);

% sync_positions = find(imag(x1) > 23);
% 
% x1=(x(:)); % 变成一列
% x1=(x1(1:framelength*16));%取8帧的长度
% x1=reshape(x1,framelength,[]);%A: 需要重新调整形状的数组或矩阵。m: 重新调整后的行数。n: 重新调整后的列数。
% sync_data = x1(sync_positions);


% 
% x2=imag(x1(1:framelength*8));
% x2=reshape(x2,32490,[]);
% x3=sum(x2,2);
% figure(3);stem((x3))






