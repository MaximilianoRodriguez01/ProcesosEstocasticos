clear global;
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

x = linspace(-4, 4, n);
y = linspace(-4, 4, n);
[XX, YY] = meshgrid(x, y);

fz = 1/(2*pi) * exp(-0.5 * (XX.^2 + YY.^2));
fy = 1/(2*pi*sqrt(det(Cy))) * exp(-0.5 * ((XX - MuY(1)).^2 * invCy(1,1) + (XX - MuY(1)) .* (YY - MuY(2)) * (invCy(1,2) + invCy(2,1)) + (YY - MuY(2)).^2 * invCy(2,2)));

%--------------------------------------Graficos---------------------------------------------

figure(1);
subplot(3, 3, [4, 5, 7, 8]);
scatter(Z(1,:), Z(2,:));
hold on;
contour(XX, YY, fz, 10, 'LineWidth', 2);
title('Curvas de Nivel');
legend('Dispersión de Z', 'Curvas de Nivel');

subplot(3, 3, [1, 2]);
histogram(Z1, bines, "Normalization", "pdf");
title('Histograma de Z1');
hold on;
densidadZ1 = normpdf(x, 0, 1);
plot(x, densidadZ1, "LineWidth", 1.25);
legend('Histograma de Z1', 'Densidad de Z1');

subplot(3, 3, [6, 9]);
histogram(Z2, bines, "Normalization", "pdf");
view(90, -90);
title('Histograma de Z2');
hold on;
densidadZ2 = normpdf(x, 0, 1);
plot(x, densidadZ2, "LineWidth", 1.25);
legend('Histograma de Z2', 'Densidad de Z2', 'Location', 'northwest');

subplot(3, 3, [3]);
surf(XX, YY, fz);
title('Superficie de Densidad de Z');
xlabel('Z1');
ylabel('Z2');
zlabel('f_Z(x,y)');
grid on;
shading interp;

%--------------------------------------------------------------------------

figure(2);
subplot(3, 3, [4, 5, 7, 8]);
scatter(Y(1,:), Y(2,:));
hold on;
contour(XX, YY, fy, 10, "LineWidth", 2);
title('Curvas de Nivel');
legend('Dispersión de Y', 'Curvas de Nivel');

subplot(3, 3, [1, 2]);
histogram(Y(1,:), bines, "Normalization", "pdf");
title('Histograma de Y[1]');
hold on;
densidadY1 = normpdf(x, 0.8, sqrt(0.7));
plot(x, densidadY1, "LineWidth", 1.25);
legend('Histograma de Y1', 'Densidad de Y1');

subplot(3, 3, [6, 9]);
histogram(Y(2,:), bines, "Normalization", "pdf");
view(90, -90);
title('Histograma de Y[2]');
hold on;
densidadY2 = normpdf(x, 1, sqrt(1.75));
plot(x, densidadY2, "LineWidth", 1.25);
legend('Histograma de Y2', 'Densidad de Y2', 'Location', 'northwest');

subplot(3, 3, [3]);
surf(XX, YY, fy);
title('Superficie de Densidad de Y');
xlabel('Y1');
ylabel('Y2');
zlabel('f_Y(x,y)');
grid on;
shading interp;
