clear variables
close all

P = 20;             % Orden del sistema AR
n_fft = 4096;       % Puntos para las FFTs

%Genero un vector de ceros para guardar la informacion de los 9 audios
%Observo que los vectores del .wav tienen 6667x1 elementos
x = zeros(6667, 9);
Fs = 14700;

[x(:,1)] = audioread("Audios/a.wav");
[x(:,2)] = audioread("Audios/e.wav");
[x(:,3)] = audioread("Audios/f.wav");
[x(:,4)] = audioread("Audios/i.wav");
[x(:,5)] = audioread("Audios/j.wav");
[x(:,6)] = audioread("Audios/o.wav");
[x(:,7)] = audioread("Audios/s.wav");
[x(:,8)] = audioread("Audios/sh.wav");
[x(:,9)] = audioread("Audios/u.wav");
x = x';
 
a = zeros(P+1, 9);
G = zeros(1, 9);


for i = 1:9
    [a(:,i),G(1,i)] = param_ar(x(i,:),P); % Estimo los parametros del sistema AR-P
    Ej_2(x(i,:), Fs, a(:,i), G(1,i), n_fft);
end

  
function f = Ej_2(x, Fs, a, G, n_fft)
    
    [R_X, lags_X] = xcorr(x, 'biased'); % Estimo la autocorrelacion
    S_X = PSD(x, length(x), n_fft);     % Estimo la PSD
    
    H = freqz(G, a, n_fft, 'whole', Fs); % Obtengo la transferencia del AR-P
    S_teo = abs(H).^2;                   % Obtengo la PSD teorica
    
    t = linspace(0, 1/Fs*length(x), length(x)); % Eje de tiempo
    f = linspace(-Fs/2, Fs/2, n_fft);           % Eje de frecuencia

    % Graficos
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
    xlim([0 Fs/2]);
    xlabel('Frecuencia [Hz]');
    ylabel('Amplitud [dB]');
    title('PSD');
    legend('Location', 'South', 'Orientation', 'Horizontal');

end