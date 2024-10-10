clear variables
close all

% --------------------------- ITEM A ---------------------------

data = readmatrix('geiger.csv');
instante_detectado = data(:,1)';

%Separamos en intervalos de 2 S
T= 2e6;
tiempo_total = 1.64e9;

%Variable cantidad de intervalos
M = floor(tiempo_total/T);

%Para cada intervalo guardamos la cantidad de eventos en un vector
eventos = zeros(M,1);
for j=1:M
    for i=1:length(instante_detectado)
        if(instante_detectado(1, i) > (j-1) * T) && (instante_detectado(1, i) <= j * T)
            eventos(j, 1) = eventos(j, 1)+1;
        end
    end
end

%Calculamos la media y varianza de la cantidad de eventos por intervalo
mu_Nt = mean(eventos);
var_Nt = var(eventos);

% --------------------------- ITEM B ---------------------------

%Regla de la Raiz cuadrada para definir la cantidad de bines
bines = ceil(sqrt(M));

%Graficamos el histograma
figure(1);
histogram(eventos, bines, 'Normalization', 'probability', 'EdgeColor', '#020122', 'FaceColor', '#84BC9C');
title('Histograma');
xlabel('Cantidad de eventos por intervalo');
ylabel('Probabilidad');
legend('Histograma');
grid on;

% --------------------------- ITEM C ---------------------------

%Obtenemos la PMF teorica teniendo en cuenta que el soporte son todos los valores hasta el máximo de eventos.

valores_posibles= 0:max(eventos);
pmf_teorica = poisspdf(valores_posibles, mu_Nt);

%Graficamos junto con el histograma
figure(2);
histogram(eventos, bines, 'Normalization', 'probability', 'EdgeColor', '#020122', 'FaceColor', '#84BC9C');
hold on
stem(valores_posibles, pmf_teorica, 'filled', 'LineWidth', 2, 'Color', '#092327');
title('Histograma vs PMF teórica');
xlabel('Cantidad de eventos por intervalo');
ylabel('Probabilidad');
legend('Histograma', sprintf('PMF, N(t) ~ Poisson(\\lambda * t = %.2f)', mu_Nt));
grid on;
hold off