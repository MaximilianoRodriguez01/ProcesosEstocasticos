close all
clear all
clc

P = 20;             % Orden del sistema AR
n_fft = 4096;       % Puntos para las FFTs
Fs = 14700;         % Frecuencia de muestreo
M = [10 100 1000];  % Anchos de la ventana
N = 6667;           % Largo de los audios
K = floor(M/2);     % Superposición
L = floor(N./K) - 1;    % Cantidad de segmentos

% Calculo los parámetros para el orden del sistema.
[a, G, num_audios, x] = param_audios(P);

% Elijo la 'e' y la 'sh' como la vocal y la consonante a utilizar.
e = x(2,:);
sh = x(8,:);

% Defino las ventanas con su correspondiente ancho
v1 = hamming(M(1));
v2 = hamming(M(2));
v3 = hamming(M(3));

v1 = v1';
v2 = v2';
v3 = v3';

EJ_3(e, Fs, a(:,2), G(1,2), n_fft, M, K, L, v1, v2, v3);
EJ_3(sh, Fs, a(:,8), G(1,8), n_fft, M, K, L, v1, v2, v3);

function EJ_3(e, Fs, a, G, n_fft, M, K, L, v1, v2, v3)
    P1 = mean(abs(v1).^2);
    P2 = mean(abs(v2).^2);
    P3 = mean(abs(v3).^2);

    E_n_10 = zeros(L(1), M(1));
    E_n_100 = zeros(L(2), M(2));
    E_n_1000 = zeros(L(3), M(3));

    for i = 1:L(1)
        E_n_10(i,:) = e(1, (i-1)*K(1)+1 : (i-1)*K(1) + M(1)).*v1;
    end

    for i = 1:L(2)
        E_n_100(i,:) = e(1, (i-1)*K(2)+1 : (i-1)*K(2) + M(2)).*v2;
    end

    for i = 1:L(3)
        E_n_1000(i,:) = e(1, (i-1)*K(3)+1 : (i-1)*K(3) + M(3)).*v3;
    end

    S_E_n_10 = zeros(L(1), n_fft);
    S_E_n_100 = zeros(L(2), n_fft);
    S_E_n_1000 = zeros(L(3), n_fft);

    for i = 1:L(1)
        S_E_n_10(i, :) = PSD(E_n_10(i,:), M(1) * P1, n_fft);
    end
    for i = 1:L(2)
        S_E_n_100(i, :) = PSD(E_n_100(i,:), M(2) * P2, n_fft);
    end
    for i = 1:L(3)
        S_E_n_1000(i, :) = PSD(E_n_1000(i,:), M(3) * P3, n_fft);
    end

    S_E_n_10_prom = mean(S_E_n_10);
    S_E_n_100_prom = mean(S_E_n_100);
    S_E_n_1000_prom = mean(S_E_n_1000);

    He = freqz(G, a, n_fft, 'whole', Fs);
    S_E = abs(He).^2;

    % Gráficos
    figure();
    f = linspace(-pi, pi, n_fft);
    plot(f, 20*log10(S_E_n_10_prom), 'LineWidth', 1.2, 'DisplayName', 'Estimada');
    hold on;
    plot(f, 20*log10(S_E), 'DisplayName', 'Teórica');
    xlim([0 pi]);
    xticks([0, pi/4, pi/2, 3*pi/4, pi]);
    xticklabels({'0', '\pi/4', '\pi/2', '3\pi/4', '\pi'});
    xlabel('Frecuencia [rad/s]');
    ylabel('Amplitud [dB]');

    figure();
    plot(f, 20*log10(S_E_n_100_prom), 'LineWidth', 1.2, 'DisplayName', 'Estimada');
    hold on
    plot(f, 20*log10(S_E), 'DisplayName', 'Teorica');
    xlim([0 pi]);
    xticks([0, pi/4, pi/2, 3*pi/4, pi]);
    xticklabels({'0', '\pi/4', '\pi/2', '3\pi/4', '\pi'});
    xlabel('Frecuencia [rad/s]');
    ylabel('Amplitud [dB]');
    title('PSD');
    legend('Location', 'South', 'Orientation', 'Horizontal');

    figure();
    plot(f, 20*log10(S_E_n_1000_prom), 'LineWidth', 1.2, 'DisplayName', 'Estimada');
    hold on
    plot(f, 20*log10(S_E), 'DisplayName', 'Teorica');
    xlim([0 pi]);
    xticks([0, pi/4, pi/2, 3*pi/4, pi]);
    xticklabels({'0', '\pi/4', '\pi/2', '3\pi/4', '\pi'});
    xlabel('Frecuencia [rad/s]');
    ylabel('Amplitud [dB]');
    title('PSD');
    legend('Location', 'South', 'Orientation', 'Horizontal');
end
