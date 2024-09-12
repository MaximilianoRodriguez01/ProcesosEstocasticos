close all
clear all

N = 1000;

%Regla de la Raiz cuadrada
bines = ceil (sqrt(N));

sigma = rand(1,1);
mu = rand(1,1);


X = randn(1,N)*sigma + mu;

VarX = var(X);
MeanX = mean(X);

x = linspace(min(X),max(X),N);

figure
histogram(X,bines, 'Normalization', 'pdf');
hold on
title('Histograma de X');
y = normpdf(x,MeanX,sqrt(VarX));
plot(x,y,'r');
xline(MeanX, '--');
xline(MeanX-sigma, '--', 'Color', 'g');
xline(MeanX + sigma, '--', 'Color', 'b');
legend('Histograma de X','Distribucion Normal de X', 'Media', 'Media - Sigma', 'Media + Sigma');






