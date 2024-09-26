close all
clear all

% Se definen los parametros de la VA
media = 2;
varianza = 3;

% Ver definicion de la funcion de densidad al final

% Puntos a, b y c
N = 1e4;
I = zeros(1,3);
for k=1:3
    % Se generan muestras de la uniforme
    a = media - k*sqrt(varianza);
    b = media + k*sqrt(varianza);
    x = unifrnd (a,b,1,N);
    % Se evalua la densidad en los x_i
    gx = fx(x, media, varianza);
    % Se calcula la aproximacion de la integral
    I(k) = (b-a)*mean(gx);
    
    % Graficos
    x1 = linspace(-4,8,N);
    y1 = normpdf(x1,media,sqrt(varianza));
    l = size(y1);
    
    figure(k);
    subplot(2,1,1)
    hold on
    plot(x1,y1,'linewidth',1.5,'color','black')
    area(x,gx,'facecolor','#c74f54','facealpha',0.5)
    legend('Función de densidad', 'Area de integración')
    axis([-4 8 0 0.3])
    
    subplot(2,1,2)
    hold on
    plot(x1,y1,'linewidth',1.5,'color','black')
    stem(x(1:100:end),gx(1:100:end),'color','#c74f54')
    xlim([-4,8])
    legend('Función de densidad', '100 Muestras aleatorias')
    title(['I = ',num2str(I(k),15)])
    axis([-4 8 0 0.3])
end

fprintf("Puntos a, b y c:\nIa = %.15f\nIb = %.15f\nIc = %.15f\n", I(1), I(2), I(3));

% Punto d
M = 50;
N_d = [1e1 1e2 1e3 1e4 1e5 1e6];
% Se definen los extremos de la uniforme
a_d = media - sqrt(varianza);
b_d = media + sqrt(varianza);

I_d = zeros(size(N_d,2),M);

for j=1:M
    for i=1:size(N_d,2)
        x_d = unifrnd(a_d, b_d, 1, N_d(i));
        gx_d = fx(x_d, media, varianza);
        I_d(i,j) = (b_d - a_d)*mean(gx_d);
    end
end

% Se asume un resultado teorico de la integral por enunciado
I_teorico = 0.682687273250961;
% Se aproxima el error cuadratico medio mediante la LGN
E = (I_d - I_teorico).^2;
MSE = 1/M * sum(E, 2);

fprintf('\nPunto d:\n');
for i=1:6
    fprintf("Error cuadratico medio (N=%d): %.15f\n", N_d(i), MSE(i));
end

figure(4);
loglog(N_d,MSE,'color','black','linewidth',1,'marker','o','markersize',5)
grid on
text(N_d(1:3),MSE(1:3),num2str(MSE(1:3),'%10.3e\n'),'horizontalAlignment','left','verticalAlignment','bottom','color','#c74f54')
text(N_d(4:6),MSE(4:6),num2str(MSE(4:6),'%10.3e\n'),'horizontalAlignment','right','verticalAlignment','top','color','#c74f54')
xlabel('# de muestras')
ylabel('MSE')
title('Error cuadrático medio en función de N')
axis([3 4e6 1e-9 1e-2])
xticks(N_d)

if ~exist('TP1/Images', 'dir')
	mkdir('TP1/Images');
end

% saveas(1, 'TP1/Images/2a.png');
% saveas(2, 'TP1/Images/2b.png');
% saveas(3, 'TP1/Images/2c.png');
% saveas(4, 'TP1/Images/2d_MSE.png');

% Definición de la densidad
function densidad = fx(x, media, varianza)
    densidad = 1/sqrt(2*pi*varianza) * exp( -(x-media).^2/(2*varianza) );
end
