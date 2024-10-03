close all
clear variables

n = 100;
m = 1000;

p = 0.7;

% Generar una secuencia binaria aleatoria
Z = binornd(1, p, 1, n);

% Visualizar la secuencia binaria
figure(1);
stem(Z);
xlabel('Índice');
ylabel('Valor');

% Inicializar la matriz para almacenar múltiples secuencias
Z_n = zeros(m, n);

% Visualizar múltiples secuencias y sus medias
figure(2);
hold on;

for i = 1:m
    Z_i = binornd(1, p, 1, n);
    Z_n(i, :) = Z_i;
    stem(Z_i);
end

% Calcular y visualizar la media de las secuencias
mean_Z_n = mean(Z_n);
plot(mean_Z_n, 'k', 'LineWidth', 2, 'DisplayName', 'Media de Secuencias');

var_Z_n = var(Z_n);
plot(var_Z_n, 'b', 'LineWidth', 2, 'DisplayName', 'Varianza de Secuencias');
xlabel('Índice');
ylabel('Valor');
hold off;