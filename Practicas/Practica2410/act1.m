clear variables
clear all

N = 1000;
M = 1;

X = normrnd(0, sqrt(20), 1, N);

Y = normrnd(3, sqrt(20), 1, N);

[Rx_sesgado, Largo_X] = xcorr(X, "biased");

[Rx_insesgado, LargoX] = xcorr(X, "unbiased");

[Ry_sesgado, Largo_Y] = xcorr(Y, "biased");

[Ry_insesgado, LargoY] = xcorr(Y, "unbiased");

muX = mean(X);
muY = mean(Y);

varX = var(X);
varY = var(Y);



figure(1);
subplot(4,1,1);
plot(Largo_X, Rx_sesgado, "LineWidth", 2);
title("Rx sesgado");
hold on;
stem(0, 20);
hold off;
grid on;

subplot(4,1,2);
plot(LargoX, Rx_insesgado, "LineWidth", 2);
title("Rx Insesgado");
hold on;
stem(0, 20);
hold off;
grid on;

subplot(4,1,3);
plot(Largo_Y, Ry_sesgado, "LineWidth", 2);
title("Ry sesgado");
hold on;
stem(0, 20+muY^2);	
hold off;
grid on;

subplot(4,1,4);
plot(LargoY, Ry_insesgado, "LineWidth", 2);
title("Ry Insesgado");
hold on;
stem(0, 20+muY^2);
hold off;
grid on;

Barlett = zeros(1, 2*N-1);

for i = 1:N
    Barlett(i) = (N + (i-1000)) / N;
end

for i = N+1:2*N-1
    Barlett(i) = (N - (i-1000)) / N;
end

Ventaneo = Ry_insesgado .* Barlett;

figure(2);
subplot(3,1,1);
plot(LargoY, Ry_insesgado);
title("Ry Insesgada");

subplot(3,1,2);
plot(LargoY, Ventaneo, "LineWidth", 2);
title("Ventaneada");

subplot(3,1,3);
plot(LargoY, Ry_sesgado);
title("Ry Sesgada");



