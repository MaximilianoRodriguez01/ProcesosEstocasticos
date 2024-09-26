clear global
close all

N = 10000;

turnos = 20;

% Regla de la Raiz cuadrada para definir la cantidad de bines
bines = ceil (sqrt(N));

Dado1 = randi([1 6], turnos, N);
Dado2 = randi([1 6], turnos, N);

SumaDados = Dado1 + Dado2;

%Si la suma de los dados da 7 u 11, entonces es un éxito

exitos = zeros(turnos, N);

for j = 1:turnos
    for i = 1:N
        if SumaDados(j, i) == 7 || SumaDados(j, i) == 11
            exitos(j, i) = 1;
        else
            exitos(j, i) = 0;
        end
    end
end

exitostotales = sum(exitos, 1);

y = binopdf(0:turnos, turnos, 2/9);

% Gráfico
figure(1);
histogram(exitostotales, bines, 'Normalization', 'probability', 'FaceColor', '#ffd0ff');
title('Histograma de la variable Binomial B');
xlabel('B');
ylabel('Probabilidad');
grid on
hold on
stem(0:turnos, y, '-o', 'color', '#391338', 'linewidth', 0.75);
legend('Histograma de B', sprintf('B \\sim Bin(n = %d, p = %d/%d)', turnos, 2, 9));
