clear all
close all

N = 1000;
n = 1:N;

X = normrnd(0, 1, 1, N);

% PROCESO MA - SISTEMA IIR
YA = filter(1, [1 -0.5 -0.25], X);

[RX, k_X] = xcorr(X, 'biased');
[RYA, k_YA] = xcorr(YA, 'biased');

SW_X = 1/N * abs(fft(X, 4096)).^2;
SW_YA = 1/N * abs(fft(YA, 4096)).^2;

figure
subplot(2, 1, 1)
plot(n, X);
xlim([0, 200]);

subplot(2, 1, 2)
plot(n, YA);
xlim([0, 200]);

figure
subplot(2, 1, 1)
stem(k_X, RX);
xlim([-50, 50]);

subplot(2, 1, 2) 
stem(k_YA, RYA);
xlim([-50, 50]);

L_fft = 4096;
w = (0:L_fft-1) * (2 * pi / L_fft);

figure
subplot(2, 1, 1)
plot(w, SW_X);

subplot(2, 1, 2)
plot(w, SW_YA);
