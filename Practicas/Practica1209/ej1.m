close all
clear global

n = 1000;

X1 = raylrnd(3,1,n);
X2 = raylrnd(2,1,n);

X = [X1; X2];	

B = [0.6 -0.2; 
    0.4 0.7];

H = [0.6 -0.2;
     0.4 0.2];

V = B*X;
U = H*X;

U1 = U(1,:);
U2 = U(2,:);

V1 = V(1,:);
V2 = V(2,:);


correlacionX = corrcoef(X1, X2);
correlacionV = corrcoef(V1, V2);
correlacionU = corrcoef(U1, U2);


figure()
subplot(1,3,1);
scatter(X1, X2);
title('Dispersion de X');
subtitle('Correlacion de X: ' + string(correlacionX(1,2)));
axis([-2 12 0 14]);

subplot(1,3,2);
scatter(V(1,:), V(2,:));
title('Dispersion de V');
subtitle('Correlacion de V: ' + string(correlacionV(1,2)));
axis([-2 12 0 14]);

subplot(1,3,3);
scatter(U(1,:), U(2,:));
title('Dispersion de U');
subtitle('Correlacion de U: ' + string(correlacionU(1,2)));
axis([-2 12 0 14]);





