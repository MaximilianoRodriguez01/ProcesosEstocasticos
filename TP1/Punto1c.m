close all
clear all

N = 1000;

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

figure
subplot(3,1,1);
histogram(X1,bines, 'Normalization', 'pdf');
hold on
title('Histograma de X1');
z1 = normpdf(y1,MeanX1,sqrt(VarX1));

plot(y1,z1,'r');
xline(MeanX1, '--');
xline(MeanX1-sqrt(VarX1), '--', 'Color', 'g');
xline(MeanX1 + sqrt(VarX1), '--', 'Color', 'b');

xline(0, '--', 'Color', 'k');
xline(0+sqrt(2), '--', 'Color', 'm');
xline(0-sqrt(2), '--', 'Color', 'c');

legend('Histograma de X1','Distribucion Normal de X1', 'Media estimada', 'Media estimada - Sigma estimado', 'Media estimada + Sigma estimado', 'Media teorica', 'Media teorica + Sigma teorica', 'Media teorica - Sigma teorica');

subplot(3,1,2);
histogram(X2,bines, 'Normalization', 'pdf');
hold on
title('Histograma de X2');
z2 = normpdf(y2,MeanX2,sqrt(VarX2));
plot(y2,z2,'r');
xline(MeanX2, '--');
xline(MeanX2-sqrt(VarX2), '--', 'Color', 'g');
xline(MeanX2 + sqrt(VarX2), '--', 'Color', 'b');
xline(1, '--', 'Color', 'k');
xline(1+sqrt(2), '--', 'Color', 'm');
xline(1-sqrt(2), '--', 'Color', 'c');
legend('Histograma de X2','Distribucion Normal de X2', 'Media estimada', 'Media estimada - Sigma estimado', 'Media estimada + Sigma estimado', 'Media teorica', 'Media teorica + Sigma teorica', 'Media teorica - Sigma teorica');

subplot(3,1,3);
histogram(X3,bines, 'Normalization', 'pdf');
hold on
title('Histograma de X3');
z3 = normpdf(y3,MeanX3,sqrt(VarX3));
plot(y3,z3,'r');
xline(MeanX3, '--');
xline(MeanX3-sqrt(VarX3), '--', 'Color', 'g');
xline(MeanX3 + sqrt(VarX3), '--', 'Color', 'b');
xline(1, '--', 'Color', 'k');
xline(1+sqrt(4), '--', 'Color', 'm');
xline(1-sqrt(4), '--', 'Color', 'c');
legend('Histograma de X3','Distribucion Normal de X3', 'Media estimada', 'Media estimada - Sigma estimado', 'Media estimada + Sigma estimado', 'Media teorica', 'Media teorica + Sigma teorica', 'Media teorica - Sigma teorica');








