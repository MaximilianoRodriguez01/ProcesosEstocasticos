close all
clear global

n = 1000;

X1 = raylrnd(3,1,n);
X2 = raylrnd(2,1,n);

X = [X1; X2];	

B = [0.6 -0.2; 
    0.4 0.7];

H = [0.6 -0.2;
     0.4 0.2];

V = B*X;
U = H*X;

U1 = U(1,:);
U2 = U(2,:);

V1 = V(1,:);
V2 = V(2,:);


correlacionX = corrcoef(X1, X2);
correlacionV = corrcoef(V1, V2);
correlacionU = corrcoef(U1, U2);

%Estime la matriz de autocovarianza para los vectores aleatorios del ejercicio
%anterior: X, U y V.

% Estime la matriz de autocovarianza para los vectores aleatorios del ejercicio
% anterior: X, U y V.

muX = mean(X, 2);
muU = mean(U, 2);
muV = mean(V, 2);

varX1 = var(X1);
varX2 = var(X2);

covX = mean((X1 - mean(X1)) .* (X2 - mean(X2)));

Cx = (X - muX) * (X - muX)' / (n - 1);
Cu = (U - muU) * (U - muU)' / (n - 1);
Cv = (V - muV) * (V - muV)' / (n - 1);








