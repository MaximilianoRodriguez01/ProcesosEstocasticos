clear all
close all

N = 50;
M = 20;
p = 0.2;

Z = binornd(1, p, [M, N]);
X = 2*Z - 1;

Y = cumsum(X, 2);

mean_Y = mean(Y);
var_Y = var(Y);

var_X = var(X);

stairs(Y');

Chequeo_Mu_Y = N*(2*p - 1);
Chequeo_sigma_Y = N*(var_X);

