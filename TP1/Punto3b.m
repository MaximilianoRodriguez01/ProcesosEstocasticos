clear global
close all

N = 10000;

bines = ceil (sqrt(N));

Dado1 = randi([1 6],1,N);
Dado2 = randi([1 6],1,N);

SumaDados = Dado1 + Dado2;

%quiero los valores de la suma igual a 7 o igual a 11

%ProbabilidadSuma7 = sum(SumaDados == 7)/N;
%ProbabilidadSuma11 = sum(SumaDados == 11)/N;

%Si la suma de los dados da 7 u 11, entonces es un éxito

exitos = zeros(1,N);

for i = 1:N
    if SumaDados(i) == 7 || SumaDados(i) == 11
        exitos(i) = 1;
    else
        exitos(i) = 0;
    end
end

figure();
histogram(exitos, bines, 'Normalization', 'probability');
title('Histograma de la variable Bernoulli D');
xlabel('D');
ylabel('Probabilidad');
hold on



