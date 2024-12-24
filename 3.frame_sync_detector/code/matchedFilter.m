function y = matchedFilter(data,head)
    head = head.';
    % 提取实部和虚部
    realPart = real(head);
    imagPart = imag(head);

    % 构建匹配滤波器的系数
    realcoeff = fliplr(realPart);
    imagcoeff = fliplr(imagPart);
    
    persistent tap_delay;
    
    % 清除延时
    if isempty(tap_delay)
        tap_delay = fi(zeros(1,length(realcoeff))+1j*zeros(1,length(realcoeff)),1,16,14);
    end
    
    y=fi(tap_delay * (realcoeff(1:1:end)'-1j*imagcoeff(1:1:end)'),1,32,14);
    % 计算匹配滤波器的输出。这里的计算是将延时信号与匹配滤波器的系数组成的复数序列进行点积（内积）运算。
    % 结果转换为定点数，属性为（有符号、32位宽度、14位小数位数）。
    
    % 更新延时信号tap_delay，将其向右移动一个位置，并将新的输入序列添加到末尾。    
    tap_delay=[tap_delay(2:length(realcoeff)) data];
