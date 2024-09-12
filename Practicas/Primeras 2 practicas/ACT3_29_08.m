close all
clear all

U1=unifrnd(0,1,1, 200);
U2=unifrnd(0,2,1, 200);
U=[U1; U2];

X1=0.5*U1-0.3*U2;
X2=0.7*U1+0.2*U2;
X=[X1; X2];

Y1=1.2*U1-0.1*U2;
Y2=U1+0.1*U2;
Y=[Y1;Y2];


sgtitle('Dispersión');

subplot(1,3,1);
scatter(U1, U2);
title('Dispersion de U');
axis([-1 3 -1 3]);

subplot(1,3,2);
scatter(X1, X2);
title('Dispersion de X');
axis([-1 3 -1 3]);


subplot(1,3,3);
scatter(Y1, Y2);
title('Dispersion de Y');
axis([-1 3 -1 3]);

coefu=corrcoef(U1, U2);
coefx=corrcoef(X1, X2);
coefy=corrcoef(Y1, Y2);