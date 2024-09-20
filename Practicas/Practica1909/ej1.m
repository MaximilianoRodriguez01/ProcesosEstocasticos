clear all;
close all;

n = 2000;
bines = ceil(sqrt(n));

Z1 = normrnd(0, 1, 1, n);
Z2 = normrnd(0, 1, 1, n);
Z = [Z1; Z2];

MuY = [0.8; 1];
Cy = [0.7, 0.8; 0.8, 1.75];

[P, L] = eig(Cy);
A = P * L^(0.5);
Y = A * Z + MuY;

invCy = inv(Cy);

x = linspace(-3, 3, n);
y = linspace(-3, 3, n);
[XX, YY] = meshgrid(x, y);

fz = 1/(2*pi) * exp(-0.5 * (XX.^2 + YY.^2));
fy = 1/(2*pi*sqrt(det(Cy))) * exp(-0.5 * ((XX - MuY(1)).^2 * invCy(1,1) + (XX - MuY(1)) .* (YY - MuY(2)) * (invCy(1,2) + invCy(2,1)) + (YY - MuY(2)).^2 * invCy(2,2)));

figure(1);
subplot(3, 3, [4, 5, 7, 8]);
scatter(Z(1,:), Z(2,:));
hold on;
contour(XX, YY, fz, 10, 'LineWidth', 2);
title('Curvas de Nivel');

subplot(3, 3, [1, 2]);
histogram(Z1, bines, "Normalization", "pdf");
title('Histograma de Z1');
hold on;
densidadZ1 = normpdf(x, 0, 1);
plot(x, densidadZ1, "LineWidth", 1.25);

subplot(3, 3, [6, 9]);
histogram(Z2, bines, "Normalization", "pdf");
view(90, -90);
title('Histograma de Z2');
hold on;
densidadZ2 = normpdf(x, 0, 1);
plot(x, densidadZ2, "LineWidth", 1.25);

figure(2);
subplot(3, 3, [4, 5, 7, 8]);
scatter(Y(1,:), Y(2,:));
hold on;
contour(XX, YY, fy, 10, "LineWidth", 2);
title('Curvas de Nivel');

subplot(3, 3, [1, 2]);
histogram(Y(1,:), bines, "Normalization", "pdf");
title('Histograma de Y[1]');
hold on;
densidadY1 = normpdf(x, 0.8, 0.7);
plot(x, densidadY1, "LineWidth", 1.25);

subplot(3, 3, [6, 9]);
histogram(Y(2,:), bines, "Normalization", "pdf");
view(90, -90);
title('Histograma de Y[2]');
hold on;
densidadY2 = normpdf(x, 1, 1.75);
plot(x, densidadY2, "LineWidth", 1.25);