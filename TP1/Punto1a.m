close all
clear all

N = 1000;

%Regla de la Raiz cuadrada
bines = ceil (sqrt(N));


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

figure
subplot(2,1,1);
histogram(Z1,bines, 'Normalization', 'pdf');
hold on
title('Histograma de Z1');
y1 = normpdf(x1,MeanZ1,sqrt(VarZ1));

plot(x1,y1,'r');
legend('Histograma de Z1','Distribucion Normal de Z1');

subplot(2,1,2)
histogram(Z2,bines, 'Normalization', 'pdf');
hold on
y2 = normpdf(x2,MeanZ2,sqrt(VarZ2));


title('Histograma de Z2');
plot(x2,y2,'r');
legend('Histograma de Z2','Distribucion Normal de Z2');


figure();
scatter(Z1,Z2);
title('Scatter plot de Z1 y Z2');
xlabel('Z1');
ylabel('Z2');

coeficiente = corrcoef(Z1,Z2);

