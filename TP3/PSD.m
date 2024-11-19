function S_X = PSD(X, N, n_fft)
    S_X = 1/N * abs( fft(X,n_fft) ).^2;
    periodogram
end