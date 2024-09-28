clear variables
close all

%Abrir una imagen
img = imread('img_01.jpg');

%Convertir a escala de grises
img_gris = rgb2gray(img);

%Convertir a double
data = double(img_gris);

%Aplanar la matriz
tira = data(:);

%hago una matriz de 2xn tomando cada 2 valores de la tira
X = reshape(tira, 2, []);

%Hallar la matriz de covarianza de X
cov_X = cov(X');

%Hallar los autovalores y autovectores de la matriz de covarianza
[Px, LAMBDA] = eig(cov_X);

Y = Px' * X;


figure();
scatter(X(1,:), X(2,:));
title('Original');

figure();
scatter(Y(1,:), Y(2,:));
title('Transformada');

%Ordeno autovectores y autovalores
[Lambda_sorted, idx] = sort(diag(LAMBDA), 'descend');
Px_sorted = Px(:, idx);


% le quiero sacar la ultima componente a PX
V = Px_sorted(:, 1);

LAMBDA2 = diag(Lambda_sorted);

YR = V'*(X - mean(X));

%Reconstruir X a partir de YR
XR = V*YR + mean(X);

%Rearmar imagen
figure();
[fil, col] = size(img_gris);
img_out = reshape(XR, [fil col]);

imshow(uint8(img_out));
