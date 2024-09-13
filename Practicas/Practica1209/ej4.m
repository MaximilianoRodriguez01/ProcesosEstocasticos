close all
clear all

n = 1000;

x = linspace(-3,3,n);
y = linspace(-3,3,n);

[XX, YY] = meshgrid(x,y);

fz = 1/(2*pi) * exp(-0.5 * (XX.^2 + YY.^2));


figure;
contour(XX, YY, fz, 10);
title('Curvas de Nivel');

figure;
surf(XX, YY, fz);
title('Gráfico de Superficie');
xlabel('X');
ylabel('Y');
zlabel('fz');
colorbar;
shading interp; % Mejora la visualización de la superficie