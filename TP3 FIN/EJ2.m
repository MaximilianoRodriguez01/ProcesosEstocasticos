clear variables
close all
clc

P = 20;             % Orden del sistema AR
n_fft = 4096;       % Puntos para las FFTs
Fs = 14700;         % Frecuencia de muestreo

% Calculo los parámetros para el orden del sistema.
[a, G, num_audios, x] = param_audios(P);

for i = 1:num_audios
    EJ_2(x(i,:), Fs, a(:,i), G(1,i), n_fft);
end

function EJ_2(x, Fs, a, G, n_fft)
    
    [R_X, lags_X] = xcorr(x, 'biased'); % Estimo la autocorrelacion
    S_X = PSD(x, length(x), n_fft);     % Estimo la PSD
    
    H = freqz(G, a, n_fft, 'whole', Fs); % Obtengo la transferencia del AR-P
    S_teo = abs(H).^2;                   % Obtengo la PSD teorica
    
    t = linspace(0, 1/Fs*length(x), length(x)); % Eje de tiempo
    f = linspace(-pi, pi, n_fft);           % Eje de frecuencia

    % Gráficos
    
    figure();
    subplot(3,1,1);
    plot(t, x);
    xlim([0 0.15]);
    xlabel('Tiempo [t]');
    ylabel('Amplitud');
    title('Señal temporal');

    subplot(3,1,2);
    plot(lags_X, R_X);
    xlim([-2000 2000]);
    xlabel('k');
    ylabel('Amplitud');
    title('Autocorrelacion');

    subplot(3,1,3);
    plot(f, 20*log10(S_X), 'DisplayName', 'Estimada');
    hold on;
    plot(f, 20*log10(S_teo), 'LineWidth', 1.2, 'DisplayName', 'Teorica');
    xlim([0 pi]);
    xticks([0, pi/4, pi/2, 3*pi/4, pi]);
    xticklabels({'0', '\pi/4', '\pi/2', '3\pi/4', '\pi'});
    xlabel('Frecuencia [rad/s]');
    ylabel('Amplitud [dB]');
    title('PSD');
    legend('Location', 'South', 'Orientation', 'Horizontal');
end