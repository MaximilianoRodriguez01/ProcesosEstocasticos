clear global
close all

n = 2000;

bines = ceil(sqrt(n));

X1 = normrnd(0.8, sqrt(0.7), 1, n);
X2 = normrnd(1, sqrt(1.75), 1, n);

X = [X1; X2];

CX = [0.7, 0.9; 0.9, 1.75];

invCX = inv(CX);

MuX = [0.8; 1];

[P, LAMBDA] = eig(CX);

A = LAMBDA^(-0.5) * P';

b = -A * MuX;

MuY = [0; 0];

Y = A * X + b;

Y1 = Y(1,:);
Y2 = Y(2,:);

CY = [1, 0; 0, 1];
invCY = inv(CY);

x = linspace(-4, 4, n);
y = linspace(-4, 4, n);
[XX, YY] = meshgrid(x, y);

fx = 1/(2*pi*sqrt(det(CX))) * exp(-0.5 * ((XX - MuX(1)).^2 .* invCX(1,1) + (XX - MuX(1)) .* (YY - MuX(2)) .* (invCX(1,2) + invCX(2,1)) + (YY - MuX(2)).^2 .* invCX(2,2)));

fy = 1/(2*pi*sqrt(det(CY))) * exp(-0.5 * ((XX - MuY(1)).^2 * invCY(1,1) + (XX - MuY(1)) .* (YY - MuY(2)) * (invCY(1,2) + invCY(2,1)) + (YY - MuY(2)).^2 * invCY(2,2)));

figure(1);
subplot(3, 3, [4, 5, 7, 8]);
scatter(X1, X2);
hold on;
contour(XX, YY, fx, 10, 'LineWidth', 2);
title('Curvas de Nivel');
legend('Dispersión de X', 'Curvas de Nivel');

subplot(3, 3, [1, 2]);
histogram(X(1,:), bines, "Normalization", "pdf");
title('Histograma de X1');
hold on;
densidadX1 = normpdf(x, 0.8, sqrt(0.7));
plot(x, densidadX1, "LineWidth", 1.25);
legend('Histograma de X1', 'Densidad de X1');

subplot(3, 3, [6, 9]);
histogram(X(2,:), bines, "Normalization", "pdf");
view(90, -90);
title('Histograma de X2');
hold on;
densidadX2 = normpdf(x, 1, sqrt(1.75));
plot(x, densidadX2, "LineWidth", 1.25);
legend('Histograma de X2', 'Densidad de X2', 'Location', 'northwest');

subplot(3, 3, 3);
surf(XX, YY, fx);
title('Superficie de Densidad de X');
xlabel('X1');
ylabel('X2');
zlabel('f_X(x,y)');
grid on;
shading interp;

figure(2);
subplot(3, 3, [4, 5, 7, 8]);
scatter(Y1, Y2);
hold on;
contour(XX, YY, fy, 10, 'LineWidth', 2);
title('Curvas de Nivel');
legend('Dispersión de Y', 'Curvas de Nivel');

subplot(3, 3, [1, 2]);
histogram(Y1, bines, "Normalization", "pdf");
title('Histograma de Y1');
hold on;
densidadY1 = normpdf(x, 0, 1);
plot(x, densidadY1, "LineWidth", 1.25);

subplot(3, 3, [6, 9]);
histogram(Y2, bines, "Normalization", "pdf");
view(90, -90);
title('Histograma de Y2');
hold on;
densidadY2 = normpdf(x, 0, 1);
plot(x, densidadY2, "LineWidth", 1.25);
legend('Histograma de Y2', 'Densidad de Y2', 'Location', 'northwest');

subplot(3, 3, 3);
surf(XX, YY, fy);
title('Superficie de Densidad de Y');
xlabel('Y1');
ylabel('Y2');
zlabel('f_Y(x,y)');
grid on;
shading interp;






    
