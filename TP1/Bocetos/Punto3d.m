clear global
close all

N = 10000;

turnos = 20;

bines = ceil (sqrt(N));

Dado1 = randi([1 6],turnos,N);
Dado2 = randi([1 6],turnos,N);

SumaDados = Dado1 + Dado2;

%quiero los valores de la suma igual a 7 o igual a 11

%ProbabilidadSuma7 = sum(SumaDados == 7)/N;
%ProbabilidadSuma11 = sum(SumaDados == 11)/N;

%Si la suma de los dados da 7 u 11, entonces es un éxito

exitos = zeros(turnos,N);


for j = 1:turnos
    for i = 1:N
        if SumaDados(j,i) == 7 || SumaDados(j,i) == 11
            exitos(j,i) = 1;
        else
            exitos(j,i) = 0;
        end
    end
end

exitostotales = sum(exitos,1);

%y = pdf('Binomial',turnos, 2/9);
y = binopdf(0:turnos, turnos, 2/9);

figure(1);
histogram(exitostotales, bines, 'Normalization', 'probability', 'FaceColor', '#a9e2ac');
title('Histograma de la variable Binomial B');
xlabel('B');
ylabel('Probabilidad');
grid on
hold on
stem(0:turnos, y, '-o', 'color', '#c74f54', 'linewidth', 0.5);
legend('Histograma de B','Distribucion Binomial de B');

if ~exist('TP1/Images', 'dir')
	mkdir('TP1/Images');
end

saveas(1, 'TP1/Images/3d_Binomial.png');








