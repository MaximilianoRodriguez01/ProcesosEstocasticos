close all
clear all

N = 10000;

%Regla de la Raiz cuadrada
bines = ceil (sqrt(N));

U1 = rand(1,N);	
U2 = rand(1,N);	

Z = sqrt(-2*log(U1)).*cos(2*pi*U2);

X1 = sqrt(2)*Z; 
X2 = sqrt(2)*Z + 1;
X3 = sqrt(4)*Z + 1;

VarX1 = var(X1);
VarX2 = var(X2);
VarX3 = var(X3);
MeanX1 = mean(X1);
MeanX2 = mean(X2);
MeanX3 = mean(X3);

y1 = linspace(min(X1),max(X1),N);
y2 = linspace(min(X2),max(X2),N);
y3 = linspace(min(X3),max(X3),N);

%Histograma de X1
figure('Position', [100, 100, 1200, 800]); % Aumentar el tamaño de la figura

subplot(3,1,1);
histogram(X1, bines, 'Normalization', 'pdf', 'FaceColor', '#c74f54');
hold on
title(sprintf('Histograma de X1 \\sim N(\\mu = %f, \\sigma^{2} = %.2f)', MeanX1, VarX1));
z1 = normpdf(y1, MeanX1, sqrt(VarX1));
plot(y1, z1, 'r', 'LineWidth', 1.25, 'Color', '#75234a');
xline(MeanX1, '--', 'Color', '#031D1E', 'LineWidth', 1.15);
xline(MeanX1 - sqrt(VarX1), ':', 'Color', '#481380', 'LineWidth', 1.25);
xline(MeanX1 + sqrt(VarX1), ':', 'Color', '#481380', 'LineWidth', 1.25);
legend('Histograma de X1', 'Distribucion Normal de X1', '\mu', '\mu \pm \sigma^2');

%Histograma de X2
subplot(3,1,2);
histogram(X2, bines, 'Normalization', 'pdf', 'FaceColor', '#b5838d');
hold on
title(sprintf('Histograma de X2 \\sim N(\\mu = %f, \\sigma^{2} = %.2f)', MeanX2, VarX2))
z2 = normpdf(y2, MeanX2, sqrt(VarX2));
plot(y2, z2, 'r', 'LineWidth', 1.25, 'Color', '#75234a');
xline(MeanX2, '--', 'Color', '#031D1E', 'LineWidth', 1.15);
xline(MeanX2 - sqrt(VarX2), ':', 'Color', '#c1224f', 'LineWidth', 1.25);
xline(MeanX2 + sqrt(VarX2), ':', 'Color', '#c1224f', 'LineWidth', 1.25);
legend('Histograma de X2', 'Distribucion Normal de X2', '\mu' , '\mu \pm \sigma^2');

%Histograma de X3
subplot(3,1,3);
histogram(X3, bines, 'Normalization', 'pdf', 'FaceColor', '#FFB4A2');
hold on
title(sprintf('Histograma de X3 \\sim N(\\mu = %f, \\sigma^{2} = %.2f)', MeanX3, VarX3));
z3 = normpdf(y3, MeanX3, sqrt(VarX3));
plot(y3, z3, 'r', 'LineWidth', 1.25, 'Color', '#75234a');
xline(MeanX3, '--', 'Color', 'k', 'LineWidth', 1.15);
xline(MeanX3 - sqrt(VarX3), ':', 'Color', '#c1224f', 'LineWidth', 1.25);
xline(MeanX3 + sqrt(VarX3), ':', 'Color', '#c1224f', 'LineWidth', 1.25);
legend('Histograma de X3', 'Distribucion Normal de X3', '\mu', '\mu \pm \sigma^2');

if ~exist('TP1/Images', 'dir')
	mkdir('TP1/Images');
end

saveas(gcf, 'TP1/Images/1c_Normal.png'); % Guardar la figura actual








