clear variables
close all

P = 20;             % Orden del sistema AR
n_fft = 4096;       % Puntos para las FFTs
M = [10 100 1000];
N = 6667;
K = floor(M/2);
L = floor(N./K)-1;

%Genero un vector de ceros para guardar la informacion de los 9 audios
%Observo que los audios tienen un tamaño de 6667 muestras
Fs = 14700;

audio_files = dir('C:\Users\Maxi\Desktop\PROCESOS ESTOCASTICOS\ProcesosEstocasticos\TP3\Audios\*.wav'); %tomo todos los audios de la carpeta Audios
num_audios = length(audio_files); %cantidad de audios
x = zeros(6667, num_audios); 

for k = 1:num_audios
    x(:,k) = audioread(fullfile(audio_files(k).folder, audio_files(k).name));
end
x = x';
 
a = zeros(P+1, 9);
G = zeros(1, 9);

for i = 1:num_audios
    [a(:,i),G(1,i)] = param_ar(x(i,:),P); % Estimo los parametros del sistema AR-P
    %Ej_2(x(i,:), Fs, a(:,i), G(1,i), n_fft);
end

e = x(2,:);
sh = x(8,:);

v1 = hamming(M(1));
v2 = hamming(M(2));
v3 = hamming(M(3));

v1 = v1';
v2 = v2';
v3 = v3';

%Ej_3(e, Fs, a(:,2), G(1,2), n_fft, M, K, L, v1, v2, v3);
%Ej_3(sh, Fs, a(:,8), G(1,8), n_fft, M, K, L, v1, v2, v3);


% Por enunciado
duracion = 0.5;
pitch_ = 100;
muestras = round(duracion * Fs); % Cant de muestras

senales = Ej_4A(a, G, Fs, n_fft, muestras, pitch_, num_audios);

audiowrite("Audios_sintetizados\a_sintetizada.wav", senales(1,:), Fs);

fade = 30;

senal_concatenada = EJ_4B(senales, muestras, num_audios, fade, Fs);


function Ej_2(x, Fs, a, G, n_fft)
    
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

function Ej_3(e, Fs, a, G, n_fft, M, K, L, v1, v2, v3)
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
        S_E_n_10(i,:) = PSD(E_n_10(i,:).*v1, M(1)*P1, n_fft);
    end
    for i = 1:L(2)
        S_E_n_100(i,:) = PSD(E_n_100(i,:).*v2, M(2)*P2, n_fft);
    end
    for i = 1:L(3)
        S_E_n_1000(i,:) = PSD(E_n_1000(i,:).*v3, M(3)*P3, n_fft);
    end

    S_E_n_10_prom = mean(S_E_n_10);
    S_E_n_100_prom = mean(S_E_n_100);
    S_E_n_1000_prom = mean(S_E_n_1000);

    He = freqz(G, a, n_fft, 'whole', Fs);
    S_E = abs(He).^2;

    figure();
    f = linspace(-Fs/2, Fs/2, n_fft);
    plot(f, 20*log10(S_E_n_10_prom), 'LineWidth', 1.2, 'DisplayName', 'Estimada');
    hold on;
    plot(f, 20*log10(S_E), 'DisplayName', 'Teórica');
    xlim([0 Fs/2]);
    xlabel('Frecuencia [Hz]');
    ylabel('Amplitud [dB]');

    figure();
    plot(f, 20*log10(S_E_n_100_prom), 'LineWidth', 1.2, 'DisplayName', 'Estimada');
    hold on
    plot(f, 20*log10(S_E), 'DisplayName', 'Teorica');
    xlim([0 Fs/2]);
    xlabel('Frecuencia [Hz]');
    ylabel('Amplitud [dB]');
    title('PSD');
    legend('Location', 'South', 'Orientation', 'Horizontal');

    figure();
    plot(f, 20*log10(S_E_n_1000_prom), 'LineWidth', 1.2, 'DisplayName', 'Estimada');
    hold on
    plot(f, 20*log10(S_E), 'DisplayName', 'Teorica');
    xlim([0 Fs/2]);
    xlabel('Frecuencia [Hz]');
    ylabel('Amplitud [dB]');
    title('PSD');
    legend('Location', 'South', 'Orientation', 'Horizontal');
end


function senales = Ej_4A(a, G, Fs, n_fft, muestras, pitch, num_fonemas)

senales = zeros(num_fonemas, muestras); % Matriz para guardar las señales
    

% PARA LAS VOCALES

    for i = [1 2 4 6 9]
        %Genero un tren de pulsos, con el periodo correspondiente
        
        muestras_por_periodo = round(Fs / pitch);
        T = 1/pitch;
        pulsos = zeros(1, muestras);
        for j = 1:muestras_por_periodo:muestras
            pulsos(j) = sqrt(T*Fs);
        end
     
        % Señal sintetizada con filtro LPC 
        senales(i, :) = filter(G(i), a(:, i)', pulsos);

        % Calculo PSD teórica y sintetizada
        H = freqz(G(i), a(:, i), n_fft, "whole", Fs);

        f = linspace(-Fs/2, Fs/2, n_fft);
        
        

        %S_U = PSD(pulsos, muestras, n_fft);

        S_teorica = abs(H).^2;
        S_estimada = PSD(senales(i, :), muestras, n_fft);

        % Graficos
        figure;
        plot(f, 20*log10(S_teorica), 'LineWidth', 1.5, 'DisplayName', 'Teórica');
        hold on;
        plot(f, 20*log10(S_estimada), '--', 'LineWidth', 1.2, 'DisplayName', 'Sintetizada');
        xlabel('Frecuencia [Hz]');
        ylabel('Amplitud [dB]');
        title(['Fonema ' num2str(i)]);
        xlim([0 Fs/2]);
        legend('Location', 'Best');
        grid on;
    end

    % PARA LAS CONSONANTES

    for i = [3 5 7 8]
        %Genero un tren de pulsos, con el periodo correspondiente
        
        ruido = normrnd(0,1, 1, muestras);
     

        % Señal sintetizada con filtro LPC
        senales(i, :) = filter(G(i), a(:, i)', ruido);

        % Calculo PSD teórica y sintetizada
        H = freqz(G(i), a(:, i), n_fft, "whole", Fs);

        f = linspace(-Fs/2, Fs/2, n_fft);
      
        S_teorica = abs(H).^2;
        S_estimada = PSD(senales(i, :), muestras, n_fft);

        % Graficos
        figure;
        plot(f, 20*log10(S_teorica), 'LineWidth', 1.5, 'DisplayName', 'Teórica');
        hold on;
        plot(f, 20*log10(S_estimada), '--', 'LineWidth', 1.2, 'DisplayName', 'Sintetizada');
        xlabel('Frecuencia [Hz]');
        ylabel('Amplitud [dB]');
        title(['Fonema ' num2str(i)]);
        xlim([0 Fs/2]);
        legend('Location', 'Best');
        grid on;
    end

    audiowrite("Audios_sintetizados\a.wav", senales(1,:), Fs);
    audiowrite("Audios_sintetizados\e.wav", senales(2,:), Fs);
    audiowrite("Audios_sintetizados\f.wav", senales(3,:), Fs);
    audiowrite("Audios_sintetizados\i.wav", senales(4,:), Fs);
    audiowrite("Audios_sintetizados\j.wav", senales(5,:), Fs);
    audiowrite("Audios_sintetizados\o.wav", senales(6,:), Fs);
    audiowrite("Audios_sintetizados\s.wav", senales(7,:), Fs);
    audiowrite("Audios_sintetizados\sh.wav", senales(8,:), Fs);
    audiowrite("Audios_sintetizados\u.wav", senales(9,:), Fs);
end

function senal_concatenada = EJ_4B(senales, muestras, cantidad_de_fonemas, fade, Fs)
    largo_senal_concatenada = muestras*cantidad_de_fonemas;
    senal_concatenada = zeros(1, largo_senal_concatenada);

    senal_suavizada = zeros(cantidad_de_fonemas, muestras);

    for i = 1:cantidad_de_fonemas, j = 1:muestras:largo_senal_concatenada-muestras;
        senal_suavizada(i,:) = suavizar_bordes(senales(i,:),fade);
        senal_concatenada(1, [j:j+(muestras-1)]) = senal_suavizada(i,:);
    end

  


    % senal_concatenada = [senal_suavizada(1,:) 
    %                      senal_suavizada(2,:) 
    %                      senal_suavizada(3,:) 
    %                      senal_suavizada(4,:) 
    %                      senal_suavizada(5,:) 
    %                      senal_suavizada(6,:) 
    %                      senal_suavizada(7,:) 
    %                      senal_suavizada(8,:) 
    %                      senal_suavizada(9,:) ];
    audiowrite("Audios_sintetizados\senal_concatenada.wav", senal_concatenada, Fs);

end



