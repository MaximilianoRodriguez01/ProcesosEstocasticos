clear variables
close all

N = 1000;

V = normrnd(0, sqrt(4), 1, N);

[RV_sesgado, Largo_V] = xcorr(V, "biased");

figure(1);
subplot(3,1,1);
plot(Largo_V, RV_sesgado, "LineWidth", 2);
title("RV sesgado");

Sw = 1 / N * abs(fft(V, 4096)).^2;

subplot(3,1,2);
plot(Sw);
hold on;
ylim([0 15]);
xlim([0 4096]);
hline = refline([0 4]);
hline.LineWidth = 2;
title("Sw");
legend("PSD Estimada", "PSD Teórica");

M = 100;

V_n = normrnd(0, sqrt(4), M, N);

RVN_I = zeros(M, 2*N-1);

for i = 1:M
    [RVN_I(i,:), Largo__V] = xcorr(V_n(i, :), "biased");
end

SW_I = zeros(M, 4096);

for i = 1:M
    SW_I(i, :) = 1 / N * abs(fft(V_n(i, :), 4096)).^2;
end

SW_PROMEDIO = mean(SW_I);

subplot(3,1,3);
plot(SW_PROMEDIO);
hold on;
ylim([0 15]);
xlim([0 4096]);
hline = refline([0 4]);
hline.LineWidth = 2;
title("SW Promedio");
legend("PSD Estimada", "PSD teórica");








