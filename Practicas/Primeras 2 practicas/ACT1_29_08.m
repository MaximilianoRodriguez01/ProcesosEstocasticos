n=10000;
bins=30;


x = raylrnd(0.5, 1, n);

histogram(x,bins, 'Normalization','pdf');
hold on

xmin=0;
xmax=2;

y = linspace(xmin, xmax, n); % Dominio de la función
f = raylpdf(y, 0.5); % Función de densidad
plot(y, f) % Grafica f(x)

