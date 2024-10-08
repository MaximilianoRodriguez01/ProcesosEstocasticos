close all
clear all

N = 10000;

%Regla de la Raiz cuadrada para definir la cantidad de bines
bines = ceil(sqrt(N));

U1 = rand(1,N);	
U2 = rand(1,N);	

Z1 = sqrt(-2*log(U1)).*cos(2*pi*U2);
Z2 = sqrt(-2*log(U1)).*sin(2*pi*U2);

VarZ1 = var(Z1);
VarZ2 = var(Z2);

MeanZ1 = mean(Z1);
MeanZ2 = mean(Z2);

x1 = linspace(min(Z1),max(Z1),N);
x2 = linspace(min(Z2),max(Z2),N);

% Histograma de Z1
figure();
subplot(2, 1, 1);
histogram(Z1, bines, 'Normalization', 'pdf', 'FaceColor', '#c0688d');
hold on
title('Histograma de Z_1');
y1 = normpdf(x1, MeanZ1, sqrt(VarZ1));
plot(x1, y1, 'Color', '#75234a', 'LineWidth', 1.25);  
legend('Histograma de Z_1', sprintf('Z_1 \\sim N(\\mu = %.1e, \\sigma^{2} = %.2f)', MeanZ1, VarZ1));

% Histograma de Z2
subplot(2,1,2)
histogram(Z2, bines, 'Normalization', 'pdf', 'FaceColor', '#a9e2ac'); 
hold on
y2 = normpdf(x2, MeanZ2, sqrt(VarZ2));
title('Histograma de Z_2');
plot(x2, y2, 'Color', '#4a893d', 'LineWidth', 1.25);
legend('Histograma de Z_2', sprintf('Z_2 \\sim N(\\mu = %.1e, \\sigma^{2} = %.2f)', MeanZ2, VarZ2));
coeficiente = corrcoef(Z1,Z2);

% Gráfico de Dispersión
figure();
scatter(Z1, Z2, 'MarkerEdgeColor', '#0c3fc8');
title('Gráfico de Dispersión: Z_2 vs Z_1');
subtitle(sprintf('Coeficiente de Correlación de Pearson: \\rho = %.1e', coeficiente(1,2)));
xlabel('Z_1');
ylabel('Z_2');
