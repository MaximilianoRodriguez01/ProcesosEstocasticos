clear variables
close all
clc

P = 20;             % Orden del sistema AR
n_fft = 4096;       % Puntos para las FFTs
Fs = 14700;         % Frecuencia de muestreo
duracion = 0.5;
pitch_ = 100;
muestras = round(duracion * Fs); 

% Calculo los parámetros para el orden del sistema
[a, G, num_audios, x] = param_audios(P);

% Obtengo las señales sintetizadas.
senales = EJ_4A(a, G, Fs, n_fft, muestras, pitch_, num_audios);

% Obtengo una señal concatenada suavizando los bordes con un fade de 30
% y el pitch de 100 para cada vocal.
fade = 30;

senal_concatenada = EJ_4B(senales, muestras, num_audios, fade);
audiowrite("Audios_Sintetizados\Senal_Concatenada.wav", senal_concatenada, Fs);

% Cambio el pitch para cada vocal.
a_100 = EJ_4B_pitch_vocal(a(:,1), G(1), Fs, muestras, 100);
e_125 = EJ_4B_pitch_vocal(a(:,2), G(2), Fs, muestras, 125);
i_150 = EJ_4B_pitch_vocal(a(:,4), G(4), Fs, muestras, 150);
o_125 = EJ_4B_pitch_vocal(a(:,6), G(6), Fs, muestras, 125);
u_100 = EJ_4B_pitch_vocal(a(:,9), G(9), Fs, muestras, 100);

% Genero un nuevo audio con las nuevas vocales.
audio_nuevo = [a_100; e_125; senales(3,:); i_150; senales(5,:); o_125; senales(7,:); senales(8,:); u_100];

% Lo concateno.
audio_nuevo_concatenado = EJ_4B(audio_nuevo, muestras, num_audios, fade);
audiowrite("Audios_Sintetizados\Senal_Nueva_Concatenada.wav", audio_nuevo_concatenado, Fs);
graficar_concatenados(senal_concatenada, audio_nuevo_concatenado);

function senales = EJ_4A(a, G, Fs, n_fft, muestras, pitch, num_fonemas)
    
    % Matriz para guardar las señales
    senales = zeros(num_fonemas, muestras); 
    
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
    
            % Calculo PSD teórica y la estimada
            S_U = PSD(pulsos, muestras, n_fft);
            H = freqz(G(i), a(:, i), n_fft, "whole", Fs);
            S_teorica = abs(H).^2 .* S_U';
            S_estimada = PSD(senales(i, :), muestras, n_fft);
            
            f = linspace(-pi, pi, n_fft);

            % Gráficos
            figure;
            plot(f, 20 * log10(S_teorica), 'LineWidth', 1.5, 'DisplayName', 'Teórica', 'Color', '#22806b');
            hold on;
            plot(f, 20 * log10(S_estimada), '--', 'LineWidth', 1.5, 'DisplayName', 'Sintetizada', 'Color', '#ed7615');
            xlabel('Frecuencia [rad/s]');
            ylabel('Amplitud [dB]');
            title(['Fonema ' num2str(i)]);
            xlim([0 pi]);
            xticks([0, pi/4, pi/2, 3*pi/4, pi]);
            xticklabels({'0', '\pi/4', '\pi/2', '3\pi/4', '\pi'}); 
            legend('Location', 'Best');
            grid on;
        end
    
    % PARA LAS CONSONANTES
    
        for i = [3 5 7 8]

            %Genero un ruido blanco
            
            ruido = normrnd(0,1, 1, muestras);
         
            % Señal sintetizada con filtro LPC
            senales(i, :) = filter(G(i), a(:, i)', ruido);
    
            % Calculo PSD teórica y sintetizada
            H = freqz(G(i), a(:, i), n_fft, "whole", Fs);
    
            f = linspace(-pi, pi, n_fft);
          
            S_teorica = abs(H).^2;
            S_estimada = PSD(senales(i, :), muestras, n_fft);
    
            % Gráficos
            figure;
            plot(f, 20*log10(S_estimada), '--', 'LineWidth', 1.2, 'DisplayName', 'Sintetizada', 'Color', '#ed7615');
            hold on;
            plot(f, 20*log10(S_teorica), 'LineWidth', 2, 'DisplayName', 'Teórica', 'Color', '#22806b');
            xlabel('Frecuencia [rad/s]');
            ylabel('Amplitud [dB]');
            title(['Fonema ' num2str(i)]);
            xlim([0 pi]);
            xticks([0, pi/4, pi/2, 3*pi/4, pi]);
            xticklabels({'0', '\pi/4', '\pi/2', '3\pi/4', '\pi'}); 
            legend('Location', 'Best');
            grid on;
        end
        
    % Audios
    output_dir = 'Audios_sintetizados';
    if ~exist(output_dir, 'dir')
        mkdir(output_dir);
    end
    
    audiowrite(fullfile(output_dir, 'a_sint.wav'), senales(1,:), Fs);
    audiowrite(fullfile(output_dir, 'e_sint.wav'), senales(2,:), Fs);
    audiowrite(fullfile(output_dir, 'f_sint.wav'), senales(3,:), Fs);
    audiowrite(fullfile(output_dir, 'i_sint.wav'), senales(4,:), Fs);
    audiowrite(fullfile(output_dir, 'j_sint.wav'), senales(5,:), Fs);
    audiowrite(fullfile(output_dir, 'o_sint.wav'), senales(6,:), Fs);
    audiowrite(fullfile(output_dir, 's_sint.wav'), senales(7,:), Fs);
    audiowrite(fullfile(output_dir, 'sh_sint.wav'), senales(8,:), Fs);
    audiowrite(fullfile(output_dir, 'u_sint.wav'), senales(9,:), Fs);
end

function senal_concatenada = EJ_4B(senales, muestras, cantidad_de_fonemas, fade)
    
    % Inicializo las variables
    largo_senal_concatenada = muestras * cantidad_de_fonemas;
    senal_concatenada = zeros(1, largo_senal_concatenada);
    senal_suavizada = zeros(cantidad_de_fonemas, muestras);
    
    % Suavizo y concateno las señales
    for i = 1:cantidad_de_fonemas
        % Suavizo los bordes de la señal actual
        senal_suavizada(i, : ) = suavizar_bordes(senales(i, :), fade);
    
        % Calculo los índices para la concatenación
        inicio = (i - 1) * muestras + 1;
        fin = inicio + muestras - 1;     
    
        % Concateno la señal suavizada
        senal_concatenada(1, inicio:fin) = senal_suavizada(i, :);
    end
end

function senales = EJ_4B_pitch_vocal(a, G, Fs, muestras, pitch)
    
    % Matriz para guardar las señales
    senales = zeros(1, muestras); 
       
    %Genero un tren de pulsos, con el periodo y el pitch correspondiente
    muestras_por_periodo = round(Fs / pitch);
    T = 1/pitch;
    pulsos = zeros(1, muestras);
    for j = 1:muestras_por_periodo:muestras
        pulsos(j) = sqrt(T*Fs);
    end
     
    % Señal sintetizada con filtro LPC 
    senales(1, :) = filter(G, a, pulsos);
end

function graficar_concatenados(senal, audio)
    figure();
    plot(senal);
    xlabel('Muestras');
    ylabel('Amplitud');
    grid on
    hold on
    plot(audio);
    title('Comparación de las señales concatenadas');
    legend('Pitch = 100Hz', 'Distintos pitchs');
    hold off
end