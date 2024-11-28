% Calcula el módulo al cuadrado de la fft de n_fft puntos
% y la divide por N
function S_X = PSD(X, N, n_fft)
    S_X = 1/N * abs( fft(X,n_fft) ).^2;
end