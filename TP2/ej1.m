clear variables
close all

data = readmatrix('geiger.csv');

instante_detectado = data(:,1)';

% 27 minutos --- Chequear si usamos minutos o micros
tiempo_total = 1.64e9;

tau = diff(instante_detectado);

esperanza_tau = mean(tau);
varianza_tau = var(tau);

x = linspace(0, max(tau), 100);
exp = exppdf(x, esperanza_tau);

largo_total = length(tau);

bines = ceil(sqrt(largo_total));

% Histograma de los tau
figure(1);
histogram(tau, bines, 'Normalization', 'pdf', 'FaceColor', '#ffd0ff');
title('Histograma de los intervalos entre detecciones');
subtitle(sprintf('Esperanza: %d, Varianza: %d', esperanza_tau, varianza_tau));

hold on

plot(x, exp, 'LineWidth', 2, 'Color', '#ff00ff');
legend('Histograma', sprintf('Exponencial, \\lambda = %d', 1/esperanza_tau));
grid on;
xlabel('Intervalos entre detecciones');
ylabel('Probabilidad');

hold off












