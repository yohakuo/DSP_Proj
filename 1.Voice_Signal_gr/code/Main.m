close all;clear;clc;
%% Main program
global keyNames tone_all h1 h2 h3 h4 Decode_output %%全局按键名
keyNames=[];   % 保存按键的数组
tone_all=[];
Decode_output=[];

%% 绘图
h1=subplot(2,3,2);grid on;
title('Signal tone');
ylabel('Amplitude');
xlabel('time (second)');
axis([0 0.035 -2 2]);

h2=subplot(2,3,5);grid on;
title('Spectrum for tone');
ylabel('Amplitude');
xlabel('frequency (Hz)');
axis([500 2000 0 1]);

h3=subplot(2,3,3);grid on;
title('BPF frequency responses');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
axis([500 2000 0 1]);

h4=subplot(2,3,6);grid on;
title('Decode Spectrum');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
axis([500 2000 0 1]);

%% 按钮和UI窗口
% 获取屏幕尺寸
screenSize = get(0, 'ScreenSize');
% 窗口宽度和高度
windowWidth = 1000;  
windowHeight = 500; 
% 计算窗口左上角位置
windowX = (screenSize(3) - windowWidth) / 2;
windowY = (screenSize(4) - windowHeight) / 2;
% 设置UI 窗口的位置和属性
set(gcf,'Units','pixels','position',[windowX, windowY, windowWidth, windowHeight],'Name','DTMF_Main'); % UI Window 位置
bip=[50,340]; % 按钮初始化位置
bs=40; % 按钮初始化大小

% 创建和定位文本标签控件
AuthorDisplay=uicontrol('Style', 'text', 'Position',[bip+[0 bs*3],85,35],'String', 'LiuLiu','FontSize',20,'HorizontalAlignment','left','BackgroundColor',[0.937 0.867 0.867]);
InputDisplay=uicontrol('Style', 'text', 'Position',[bip+[0 bs*2],85,35],'String', 'Input : ','FontSize',20,'HorizontalAlignment','left','BackgroundColor',[0.839 0.91 0.851]);
Display=uicontrol('Style', 'text', 'Position',[bip+[0 bs*1],260,35],'String', 'KeyNames','FontSize',15,'HorizontalAlignment','left','FontSize',20,'BackgroundColor',[0.973 0.973 0.973]);

% 设置文本标签内容
set(Display,'String',keyNames); % Property

% 创建按钮控件
button1 = uicontrol; % 生成按钮
% 设置按钮的字符串、位置和背景颜色
set(button1,'String','1','Position',[bip,repmat(bs,1,2)],'BackgroundColor',[0.804 0.878 0.969]); 
set(button1,'Callback','button_1'); % 单击按钮调用名为 button_1 的函数

button2 = uicontrol; % Generate Button
set(button2,'String','2','Position',[bip+[bs*1 0],repmat(bs,1,2)],'BackgroundColor',[0.804 0.878 0.969]); 
set(button2,'Callback','button_2'); 

button3 = uicontrol; % Generate Button
set(button3,'String','3','Position',[bip+[bs*2 0],repmat(bs,1,2)],'BackgroundColor',[0.804 0.878 0.969]); 
set(button3,'Callback','button_3');

buttonA = uicontrol; % Generate Button
set(buttonA,'String','A','Position',[bip+[bs*3 0],repmat(bs,1,2)],'BackgroundColor',[0.804 0.878 0.969]); 
set(buttonA,'Callback','button_A'); 

button4 = uicontrol; % Generate Button
set(button4,'String','4','Position',[bip+[0 -bs*1],repmat(bs,1,2)],'BackgroundColor',[0.804 0.878 0.969]); 
set(button4,'Callback','button_4'); 

button5 = uicontrol; % Generate Button
set(button5,'String','5','Position',[bip+[bs*1 -bs*1],repmat(bs,1,2)],'BackgroundColor',[0.804 0.878 0.969]); 
set(button5,'Callback','button_5'); 

button6 = uicontrol; % Generate Button
set(button6,'String','6','Position',[bip+[bs*2 -bs*1],repmat(bs,1,2)],'BackgroundColor',[0.804 0.878 0.969]); 
set(button6,'Callback','button_6'); 

buttonB = uicontrol; % Generate Button
set(buttonB,'String','B','Position',[bip+[bs*3 -bs*1],repmat(bs,1,2)],'BackgroundColor',[0.804 0.878 0.969]); 
set(buttonB,'Callback','button_B'); % button reaction and call function button_B

button7 = uicontrol; % Generate Button
set(button7,'String','7','Position',[bip+[0 -bs*2],repmat(bs,1,2)],'BackgroundColor',[0.804 0.878 0.969]); % Property
set(button7,'Callback','button_7'); 

button8 = uicontrol; % Generate Button
set(button8,'String','8','Position',[bip+[bs*1 -bs*2],repmat(bs,1,2)],'BackgroundColor',[0.804 0.878 0.969]); % Property
set(button8,'Callback','button_8'); % button reaction and call function button_8

button9 = uicontrol; % Generate Button
set(button9,'String','9','Position',[bip+[bs*2 -bs*2],repmat(bs,1,2)],'BackgroundColor',[0.804 0.878 0.969]); 
set(button9,'Callback','button_9'); 

buttonC = uicontrol; % Generate Button
set(buttonC,'String','C','Position',[bip+[bs*3 -bs*2],repmat(bs,1,2)],'BackgroundColor',[0.804 0.878 0.969]); 
set(buttonC,'Callback','button_C'); 

buttonStar = uicontrol; % Generate Button
set(buttonStar,'String','*','Position',[bip+[0 -bs*3],repmat(bs,1,2)],'BackgroundColor',[0.804 0.878 0.969]); 
set(buttonStar,'Callback','button_Star'); 

button0 = uicontrol; % Generate Button
set(button0,'String','0','Position',[bip+[bs*1 -bs*3],repmat(bs,1,2)],'BackgroundColor',[0.804 0.878 0.969]); 
set(button0,'Callback','button_0');

buttonSign = uicontrol; % Generate Button
set(buttonSign,'String','#','Position',[bip+[bs*2 -bs*3],repmat(bs,1,2)],'BackgroundColor',[0.804 0.878 0.969]); 
set(buttonSign,'Callback','button_Sign');

buttonD = uicontrol; % Generate Button
set(buttonD,'String','D','Position',[bip+[bs*3 -bs*3],repmat(bs,1,2)],'BackgroundColor',[0.804 0.878 0.969]); 
set(buttonD,'Callback','button_D');

buttonSoundAll = uicontrol; % Generate Button
set(buttonSoundAll,'String','SoundAll','Position',[bip+[0 -bs*4],bs*4,bs],'BackgroundColor',[0.839 0.91 0.851]); 
set(buttonSoundAll,'Callback','button_SoundAll'); 

buttonClear = uicontrol; % Generate Button
set(buttonClear,'String','Clear','Position',[bip+[0 -bs*5],bs*4,bs],'BackgroundColor',[0.937 0.867 0.867]);
set(buttonClear,'Callback','button_Clear'); 

buttonDecode = uicontrol; % Generate Button
set(buttonDecode,'String','Decode','Position',[bip+[0 -bs*6],bs*4,bs],'BackgroundColor',[0.992 0.918 0.796]); 
set(buttonDecode,'Callback','button_Decode'); 

% 创建和定位文本标签控件
DecodeDisplay=uicontrol('Style', 'text', 'Position',[bip+[0 -bs*7],125,35],'String', 'Decode : ','FontSize',20,'HorizontalAlignment','left','BackgroundColor',[0.839 0.91 0.851]);
Display2=uicontrol('Style', 'text', 'Position',[bip+[0 -bs*8],260,35],'String', 'KeyNames','FontSize',15,'HorizontalAlignment','left','FontSize',20,'BackgroundColor',[0.973 0.973 0.973]);

% 设置文本标签内容
set(Display2,'String',Decode_output); % Property


