close all
clear global

n = 100000;

u=rand(1, n);
x=-log(1-u)/0.5;
media=mean(x);
varianza=var(x);

hold on

title('Actividad 2');

histogram(x, 30, 'Normalization', 'pdf');



xmin=0;
xmax=15;

y = linspace(xmin, xmax, n); % Dominio de la función
f = exppdf(y, 2); % Función de densidad
plot(y, f); % Grafica f(x)

legend('Histograma','Función de Densidad');



