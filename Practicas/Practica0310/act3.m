close all
clear variables

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


% Grafico las primeras 5 Binomiales para ver cómo tiene que ser el Proceso de Poisson
figure();
for i = 1:5
    subplot(5, 1, i);
    plot(X(i, :));
    title(['Bernoulli de orden ', num2str(i)]);
end

Poisson = zeros(m, n);

for i = 1:m
    for j = 1:n
        if X(i, j) == 1 && j == 1
            Poisson(i, j) = 1;
        elseif X(i, j) == 1
            Poisson(i, j) = Poisson(i, j-1) + 1;
        elseif j > 1
            Poisson(i, j) = Poisson(i, j-1);
        end
    end
end

% Grafico las primeras 5 Poisson
figure();
title(['Primeras 5 realizaciones de un Proceso de Poisson con \lambda = ', num2str(lambda)]);
for i = 1:5
    plot(Poisson(i, :), 'LineWidth', 2, 'LineStyle', '--');
    hold on
end
legend('realiz. 1', 'realiz. 2', 'realiz. 3', 'realiz. 4', 'realiz. 5');

figure();
title(['Media de un Proceso de Poisson con \lambda = ', num2str(lambda)]);
plot(mean(Poisson(1:n,:)), 'LineWidth', 2, 'LineStyle', '--');




