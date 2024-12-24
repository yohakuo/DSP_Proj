function plot_fft(x, N)
    x = real(x);
    x = x(:);
    n = 0:length(x)-1; 
    w = 2*pi*(0:500)/500; % X(e^jw)的频率
    e=exp(-1j*n'*w);      % '是复共轭转置
    X = real(x.' * e);    % DTFT
    Xk = fft(x, N);
    Xk = real(Xk);
    %X(k)是对X(e^jw)在区间[0,2π]上进行的N点的采样 
    % X(e^jw)
    figure;
    subplot(2,1,1);
    plot(w/pi, X);
    title(['X(e^{j\omega}) 当 N = ', num2str(N)]);
    xlabel('\omega / \pi');
    ylabel('X(e^{j\omega})');
    grid on;
    % X(k)
    subplot(2,1,2);
    stem(0:N-1, Xk, 'MarkerEdgeColor','red');
    title(['X(k) 当 N = ', num2str(N)]);
    xlabel('k');
    ylabel('X(k)');
    grid on;
end
