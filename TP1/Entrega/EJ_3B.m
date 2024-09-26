clear global
close all

N = 10000;

% Regla de la Raiz cuadrada para definir la cantidad de bines
bines = ceil (sqrt(N));

Dado1 = randi([1 6],1,N);
Dado2 = randi([1 6],1,N);

SumaDados = Dado1 + Dado2;

% Si la suma de los dados da 7 u 11, entonces es un éxito

exitos = zeros(1,N);

for i = 1:N
    if SumaDados(i) == 7 || SumaDados(i) == 11
        exitos(i) = 1;
    else
        exitos(i) = 0;
    end
end

y = binopdf(0:1, 1, 2/9);

% Gráfico
figure(1);
histogram(exitos, bines, 'Normalization', 'probability', 'FaceColor', '#ffd0ff');
title('Histograma de la variable Bernoulli D');
xlabel('D');
ylabel('Probabilidad');
hold on
stem(0:1, y, '-o', 'Color', '#391338', 'linewidth', 1);
legend('Histograma de D', sprintf('D \\sim Ber(p = %d/%d)', 2, 9));
