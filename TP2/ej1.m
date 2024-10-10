clear variables
close all

data = readmatrix('geiger.csv');

instante_detectado = data(:,1)';

% 27 minutos --- Chequear si usamos minutos o micros
tiempo_total = 1.64e9;

largo_geiger = length(instante_detectado);

tau = zeros(1, largo_geiger);

for i = 1:largo_geiger
    if i == 1
        tau(i) = instante_detectado(i);
    else
        tau(i) = instante_detectado(i) - instante_detectado(i-1);
    end
end

esperanza_tau = mean(tau);
varianza_tau = var(tau);

x = linspace(0, max(tau), 100);
exp = exppdf(x, esperanza_tau);

% Histograma de los tau
figure(1);
histogram(tau, 'Normalization', 'pdf', 'FaceColor', '#ffd0ff');
title('Histograma de los intervalos entre detecciones');
subtitle(sprintf('Esperanza: %.2f, Varianza: %.2f', esperanza_tau, varianza_tau));
hold on
plot(x, exp, 'LineWidth', 2, 'Color', '#ff00ff');
hold off








