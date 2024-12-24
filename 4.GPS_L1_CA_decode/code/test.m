N = length(filtered_signal); % 信号长度

% 1. 自相关
autocorr_signal = xcorr(filtered_signal);
% 取中心对称的部分（只需要非负滞后部分）
autocorr_signal = autocorr_signal(N:end);

% 2. 能量检测
window_size = 40; % 每个码片有40个样本
num_chips = floor(N / window_size);
energy = zeros(1, num_chips);

for i = 1:num_chips
    start_idx = (i-1)*window_size + 1;
    end_idx = i*window_size;
    energy(i) = sum(abs(filtered_signal(start_idx:end_idx)).^2);
end

% 找到能量最高的码片
[max_energy, max_chip_index] = max(energy);
best_chip_start_idx = (max_chip_index-1)*window_size + 1;
best_chip_end_idx = max_chip_index*window_size;
best_chip_values = filtered_signal(best_chip_start_idx:best_chip_end_idx);

best_chip_time_domain=ifft(best_chip_values);

figure;
plot(real(best_chip_time_domain));
title('Time-Domain Signal of Best Chip Values');
xlabel('Sample index');
ylabel('Amplitude');
grid on;
