close all
clear all

n = 1000;

X1 = unifrnd(0,2,1,n);
X2 = unifrnd(0,3,1,n);

X = [X1; X2];

tita = pi/10;

R = [cos(tita) -sin(tita); 
    sin(tita) cos(tita)];

Y = R*X;



correlacionX = corrcoef(X1, X2);
correlacionY = corrcoef(Y(1,:), Y(2,:));

muXestimada = mean(X, 2);
muYestimada = mean(Y, 2);


Cx = (X - muXestimada) * (X - muXestimada)' / (n - 1);
Cy = (Y - muYestimada) * (Y - muYestimada)' / (n - 1);

%repita para tita = pi/4

tita2 = pi/4;

R2 = [cos(tita2) -sin(tita2); 
    sin(tita2) cos(tita2)];

Y2 = R2*X;


correlacionY2 = corrcoef(Y2(1,:), Y2(2,:));

muYestimada2 = mean(Y2, 2);

Cy2 = (Y2 - muYestimada2) * (Y2 - muYestimada2)' / (n - 1);

figure()
subplot(1,3,1);
scatter(Y(1,:), Y(2,:));
title('Dispersion de Y');
subtitle('Correlacion de Y: ' + string(correlacionY(1,2)));
axis([-2 3 -1 4]);

subplot(1,3,2);
scatter(Y2(1,:), Y2(2,:));
title('Dispersion de Y2');
subtitle('Correlacion de Y2: ' + string(correlacionY2(1,2)));
axis([-2 3 -1 4]);

subplot(1,3,3);
scatter(X1, X2);
title('Dispersion de X');
subtitle('Correlacion de X: ' + string(correlacionX(1,2)));
axis([-2 3 -1 4]);
