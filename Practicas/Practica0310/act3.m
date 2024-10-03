close all
clear all

n = 1000;
m = 2000;

lambda = 0.5;
T = 10;

delta = T/n;

p = lambda*delta;

X = zeros(1, n);

for i = 1:m
    Xi = binornd(1, p, 1, n);
    X(i, :) = Xi;
end

for i = 1:5
    stem(X(i, :));
    hold on;
end

