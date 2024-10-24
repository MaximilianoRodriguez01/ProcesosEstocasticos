clear variables
clear all

N = 1000;
M = 1;

X = normrnd(0, sqrt(20), 1, N);

Y = normrnd(3, sqrt(20), 1, N);

estimador_sesgado = xcorr(X, "biased");

estimador_insesgado = xcorr(X, "unbiased");

plot(estimador_sesgado);



