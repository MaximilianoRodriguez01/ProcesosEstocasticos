close all
clear variables

% Genere M=20 realizaciones de un proceso random walk Y(n), de largo N=50, con
% parámetro p (considere los casos p = {0.2, 0.5, 0.8}) y comparelas gráficamente con
% la media teórica.

n = 50;
m = 200;


contador = 0; 

% Grafico de los procesos
figure();
for p = [0.2, 0.5, 0.8]
    contador = contador + 1;

    Z_n = zeros(m, n);

    for i = 1:m
        Z_n(i, :) = binornd(1, p, 1, n);
    end

    X = 2*Z_n - 1; 

    Y = cumsum(X, 2);

    % Crear subplot en la figura
    subplot(3, 1, contador)
    for w = 1:m
        stairs(Y(w, :)); 
        hold on;
    end

    media_teorica = (2*p - 1) * (1:n);
    plot(media_teorica, 'k', 'LineWidth', 2);
    title(['Random Walk para p = ', num2str(p)]);
    xlabel('n');
    ylabel('Y(n)');
    legend('Realizaciones', 'Media Teórica');
    grid on
    hold off;
end

% Grafico de las medias
figure();
contador = 0;
for p = [0.2, 0.5, 0.8]
    contador = contador + 1;

    Z_n = zeros(m, n);

    for i = 1:m
        Z_n(i, :) = binornd(1, p, 1, n);
    end

    X = 2*Z_n - 1; 

    Y = cumsum(X, 2);

    subplot(3, 1, contador)
    plot(mean(Y), 'r--', 'LineWidth', 1);
    hold on;
    media_teorica = (2*p - 1) * (1:n);
    plot(media_teorica, 'k', 'LineWidth', 1);
    title(['Media de las Realizaciones vs Media Teórica para p = ', num2str(p)]);
    xlabel('n');
    ylabel('Media');
    legend('Media de las Realizaciones', 'Media Teórica');
    grid on
    hold off;
end