close all
clear global

n = 1000;

x = linspace(-4,4,n);
y = linspace(-4,4,n);

[XX, YY] = meshgrid(x,y);

X = [XX(:), YY(:)];

fz = 1/(2*pi) * exp(-0.5 * (XX.^2 + YY.^2));


Cx2 = [0.7, 0.8;
       0.8, 1.75];

mux2 = [0.8, 1];
invCx2 = inv(Cx2);

fz2 = 1/(2*pi*sqrt(det(Cx2))) * exp(-0.5 * ((XX-mux2(1)).^2 * invCx2(1,1) + (XX-mux2(1)).*(YY-mux2(2)) * (invCx2(1,2) + invCx2(2,1)) + (YY-mux2(2)).^2 * invCx2(2,2)));

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

figure();
contour(XX, YY, fz2, 10);
title('Curvas de Nivel de X2');

figure();
surf(XX, YY, fz2);
title('Gráfico de Superficie de X2');
xlabel('X');
ylabel('Y');
zlabel('fz2');
colorbar;
shading interp;
