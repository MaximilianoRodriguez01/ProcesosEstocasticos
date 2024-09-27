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
tira_ordenada = reshape(tira, 2, []);

%Hallar la matriz de covarianza de X
cov_X = cov(tira_ordenada');

%Hallar los autovalores y autovectores de la matriz de covarianza
[Px, LAMBDA] = eig(cov_X);

Y = Px'*tira_ordenada;


figure();
scatter(tira_ordenada(1,:), tira_ordenada(2,:));

figure();
scatter(Y(1,:), Y(2,:));

%Ordeno autovectores y autovalores

[Lambda_sorted, idx] = sort(diag(LAMBDA), 'descend');

Px_sorted = Px(:, idx);


% le quiero sacar la ultima componente a PX

PYR = Px_sorted(:, 1);

LAMBDA2 = diag(Lambda_sorted);

YR = Px_sorted'*tira_ordenada + mean(tira_ordenada);


%Rearmar imagen
figure();
img_out = reshape(YR', size(img_gris));

imshow(uint8(img_out));
