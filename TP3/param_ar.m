%% Parametros de sistema AR-P
% Para el sistema: X(n) + a1*X(n-1) + ... + ap*X(n-p) = G*Z(n)
% Con Z(n) PE blanco ~ N(0,1)
% Recibe las muestras 'x' y el orden del sistema 'P'
% Calcula los coeficientes [1 a1 ... ap] y la ganancia 'G'
%%
function [a, G] = param_ar(x, P)
    N = length(x);
    R_X = xcorr(x, 'biased'); % Estimo la correlación
    R = zeros(P, P);
    for i=0:P-1
       R(i+1, :) = R_X(N-i:N+(P-1)-i); % Defino la matriz R
    end
    r = R_X(N+1:N+P)'; % Defino el vector r
    a = -inv(R)*r;
    G = sqrt( R_X(N) + a'*r );
    a = [1; a];
end
%% Ecuaciones teoricas
%
%     |  R_X(0)  ... R_X(-P+1)|       | R_X(1) |
% R = |   ...    ...   ...    |   r = |  ...   |
%     | R_X(P-1) ...  R_X(0)  |       | R_X(P) |
%
% [a] = - inv(R) * r
%  G  = sqrt( R_X(0) + a' r )