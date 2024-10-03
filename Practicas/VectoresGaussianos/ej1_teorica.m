close all
clear all

N = 1000;

Z1 = normrnd(0, 1, 1, N);

Z2 = 2*Z1 + 1;

Z = [Z1; Z2];

Cx = cov(Z');

detCx = det(Cx);
