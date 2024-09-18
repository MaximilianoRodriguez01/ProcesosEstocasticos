close all
clear all

N = 10000;

%Regla de la Raiz cuadrada
bines = ceil(sqrt(N));

%Defino Realizaciones Uniformes U1 y U2
U1 = rand(1,N);	
U2 = rand(1,N);	

%Genero las variables aleatorias R y Theta
R = sqrt(-2*log(U1));
Theta = 2*pi*U2;

%Genero las variables aleatorias Z1 y Z2
Z1 = R.*cos(Theta);
Z2 = R.*sin(Theta);


%Calculo la varianza y la media de Z1 y Z2
VarZ1 = var(Z1);
VarZ2 = var(Z2);

MeanZ1 = mean(Z1);
MeanZ2 = mean(Z2);

%Genero los valores de x para graficar las pdfs
x1 = linspace(min(Z1),max(Z1),N);
x2 = linspace(min(Z2),max(Z2),N);


%Grafico los histogramas de R y Theta
figure();
subplot(2,1,1);
histogram(R, bines, 'Normalization', 'pdf', 'FaceColor', '#c0688d');
title('Histograma de R');
xlim([0 5]);
xlabel('R');
hold on
yR = raylpdf(x1,1);
plot(x1,yR,'Color', '#75234a', 'LineWidth', 1.25);
legend('Histograma de R', 'Rayleigh R');


subplot(2,1,2);
histogram(Theta, bines, 'Normalization', 'pdf', 'FaceColor', '#a9e2ac');
title('Histograma de Theta');
xlabel('Theta');
hold on
yTheta = unifpdf(x2,0,2*pi);
xlim([0 2*pi]);
plot(x2,yTheta,'Color', '#4a893d', 'LineWidth', 1.25);
legend('Histograma de Theta', 'Uniforme Theta');

%Grafico los histogramas de Z1 y Z2
figure();
subplot(2,1,1);
histogram(Z1,bines, 'Normalization', 'pdf', 'FaceColor', '#c0688d');
hold on
title('Histograma de Z_1');
y1 = normpdf(x1,MeanZ1,sqrt(VarZ1));
plot(x1,y1,'Color', '#75234a', 'LineWidth', 1.25);  
legend('Histograma de Z_1', sprintf('Z_1 \\sim N(\\mu = %.1e, \\sigma^{2} = %.2f)', MeanZ1, VarZ1));


subplot(2,1,2)
histogram(Z2, bines, 'Normalization', 'pdf', 'FaceColor', '#a9e2ac'); 
hold on
y2 = normpdf(x2,MeanZ2,sqrt(VarZ2));
title('Histograma de Z_2');
plot(x2, y2, 'Color', '#4a893d', 'LineWidth', 1.25);
legend('Histograma de Z_2', sprintf('Z_2 \\sim N(\\mu = %.1e, \\sigma^{2} = %.2f)', MeanZ2, VarZ2));
coeficiente = corrcoef(Z1,Z2);

figure();
scatter(Z1,Z2, 'MarkerEdgeColor', '#0c3fc8');
title('Gráfico de Dispersión: Z_2 vs Z_1');
subtitle(sprintf('Coeficiente de Correlación de Pearson: \\rho = %.1e', coeficiente(1,2)));
xlabel('Z_1');
ylabel('Z_2');
