clear variables
close all

% --------------------------- ITEM A ---------------------------

data = readmatrix('geiger.csv');
instante_detectado = data(:,1)';

%27 minutos a microsegundos

tiempo_total = 1.64e9;

%Tiempo entre pulsos
tau = diff(instante_detectado);

%Calculamos la media y varianza del tiempo entre pulsos
esperanza_tau = mean(tau);
varianza_tau = var(tau);

% --------------------------- ITEM B ---------------------------

%Regla de la Raiz cuadrada para definir la cantidad de bines
largo_total = length(tau);
bines = ceil(sqrt(largo_total));

%Graficamos el histograma
figure(1);
histogram(tau, bines, 'Normalization', 'pdf', 'FaceColor', '#ffd0ff');
title('Histograma de los intervalos entre detecciones');
subtitle(sprintf('\\mu_{\\tau} \\approx %.2e, \\sigma^{2}_{\\tau} \\approx %.2e', esperanza_tau, varianza_tau));
xlabel('Intervalos entre detecciones');
ylabel('Probabilidad');
grid on;

% --------------------------- ITEM C ---------------------------

%Obtenemos la PDF teorica teniendo en cuenta que el soporte son todos los valores hasta el máximo.

x = linspace(0, max(tau), 100);
exp = exppdf(x, esperanza_tau);

%Graficamos junto con el histograma
figure(2);
histogram(tau, bines, 'Normalization', 'pdf', 'FaceColor', '#ffd0ff');
title('Histograma vs PDF teórica');

hold on

plot(x, exp, 'LineWidth', 2, 'Color', '#ff00ff');
legend('Histograma', sprintf('PDF, \\tau ~ Exp(\\lambda \\approx %.2e)', 1 / esperanza_tau));
grid on;
xlabel('Intervalos entre detecciones');
ylabel('Probabilidad');

hold off












