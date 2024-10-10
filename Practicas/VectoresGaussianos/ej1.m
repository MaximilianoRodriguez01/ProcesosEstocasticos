clear all
close all

N = 10e3;
bines = ceil(sqrt(N));

CX = [2 1; 1 1];
muX = [1; -2];

[P, LAMBDA] = eig(CX);

% Generar datos multivariados normales
Z = mvnrnd(muX', CX, N);

Z1 = Z(:,1);
Z2 = Z(:,2);

[XX, YY] = meshgrid(-4:0.1:6, -6:0.1:2);

CurvaDeNivel = XX.^2 - 2*XX.*YY - 6*XX + 2*YY.^2 + 10*YY + 13;

figure();
scatter(Z1, Z2, '.');
hold on;

% Plot the eigenvectors
v1 = P(:,1) * sqrt(LAMBDA(1,1));
v2 = P(:,2) * sqrt(LAMBDA(2,2));
plot([muX(1), v1(1) + muX(1)], [muX(2), v1(2) + muX(2)], 'r', 'LineWidth', 2);
plot([muX(1), v2(1) + muX(1)], [muX(2), v2(2) + muX(2)], 'g', 'LineWidth', 2);
title(['Mean of X1 = ' num2str(mean(Z1)) ', Var of X1 = ' num2str(var(Z1)) ', Mean of X2 = ' num2str(mean(Z2)) ', Var of X2 = ' num2str(var(Z2))], 'HorizontalAlignment', 'center');
contour(XX, YY, CurvaDeNivel, [1,2,3,4,5], 'LineWidth', 3);
hold off;