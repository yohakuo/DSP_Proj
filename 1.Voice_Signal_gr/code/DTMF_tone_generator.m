global keyNames tone_all h1 h2
fs=8000; % 采样率，每秒采样8000次
t=[0:1:204*5]/fs; % 采样率的倒数
 % 产生单位冲激信号
x=zeros(1,length(t));
x(1)=1;

% 定义了 DTMF 键盘的键
dtmf.keys = ... 
   ['1','2','3','A';
    '4','5','6','B';
    '7','8','9','C';
    '*','0','#','D'];
% 定义了 DTMF 键盘的列频率和行频率
dtmf.colTones = ones(4,1)*[1209,1336,1477,1633];
dtmf.rowTones = [697;770;852;941]*ones(1,4);

% 获取 keyNames 数组中的最后一个元素，即当前要播放的 DTMF 键。
keyName = keyNames(length(keyNames));
[r,c] = find(dtmf.keys==keyName); % 查找指定键的行和列索引

% 生成 DTMF 信号的时间域波形
% 通过对行频率和列频率的正弦信号进行滤波，然后相加得到 DTMF 信号。
%filter（分子系数 ,分母系数,输入信号）
tone=filter([0 sin(2*pi*dtmf.rowTones(r,c)/fs) ],[1 -2*cos(2*pi*dtmf.rowTones(r,c)/fs) 1],x)... 
+ filter([0 sin(2*pi*dtmf.colTones(r,c)/fs) ],[1 -2*cos(2*pi*dtmf.colTones(r,c)/fs) 1],x);

soundsc(tone,fs); % 播放生成的 DTMF 信号
tone_all=[tone_all,zeros(1,400),tone];

%  绘制生成DTMF 信号的波形图
h1=subplot(2,3,2);plot(t,tone);grid on;
title('Signal tone');
ylabel('Amplitude');
xlabel('time (second)');
axis([0 0.035 -2 2]);

% 计算并绘制生成 DTMF 信号的频谱图
Ak=2*abs(fft(tone))/length(tone);Ak(1)=Ak(1)/2;
f=[0:1:(length(tone)-1)/2]*fs/length(tone);
h2=subplot(2,3,5);plot(f,Ak(1:(length(tone)+1)/2));grid on
title('Spectrum for tone');
ylabel('Amplitude');
xlabel('frequency (Hz)');
axis([500 2000 0 1]);