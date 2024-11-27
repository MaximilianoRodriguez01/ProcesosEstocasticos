function [a, G, num_audios, x] = param_audios(orden)

    % Genero un vector de ceros para guardar la informacion de los 9 audios
    % Observo que los audios tienen un tamaño de 6667 muestras
    audio_files = dir('Audios\*.wav'); %tomo todos los audios de la carpeta Audios
    num_audios = length(audio_files); % cantidad de audios
    x = zeros(6667, num_audios); 
    
    for k = 1:num_audios
        x(:,k) = audioread(fullfile(audio_files(k).folder, audio_files(k).name));
    end
    
    x = x';
    
    % Genero vectores para guardar los parámetros LPC y las ganancias
    a = zeros(orden + 1, 9);
    G = zeros(1, 9);
    
    for i = 1:num_audios
        [a(:, i), G(1, i)] = param_ar(x(i, :), orden); % Estimo los parametros del sistema AR-P
    end

end