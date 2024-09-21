close all
clear all

N = 10000;

%Regla de la Raiz cuadrada
bines = ceil (sqrt(N));

sigma = rand(1,1);
mu = rand(1,1);

U1 = rand(1,N);
U2 = rand(1,N);

Z = sqrt(-2*log(U1)).*cos(2*pi*U2);

X = Z*sigma + mu;

VarX = var(X);
MeanX = mean(X);

x = linspace(min(X),max(X),N);

figure(1);
histogram(X,bines, 'Normalization', 'pdf', 'FaceColor', '#dad5b7');
hold on
title('Histograma de X');
y = normpdf(x,MeanX,sqrt(VarX));
plot(x,y,'Color', '#665e52', 'LineWidth', 1.25);
xline(MeanX, '--', 'Color', 'black', 'LineWidth', 1.15);
xline(MeanX-sigma, ':', 'Color', '#3a5f6f', 'LineWidth', 1.75);
xline(MeanX + sigma, ':', 'Color', '#3a5f6f', 'LineWidth', 1.75);
legend('Histograma de X', sprintf('X \\sim N(\\mu_{X} = %.2f, \\sigma^{2}_{X} = %.2f)', MeanX, VarX), '\mu_{X}', '\mu_X \pm \sigma_{X}');

if ~exist('TP1/Images', 'dir')
	mkdir('TP1/Images');
end

saveas(1, 'TP1/Images/1b_Normal.png');
