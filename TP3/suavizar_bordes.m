function s = suavizar_bordes(x, fade)
% Suaviza los bordes de una señal
% x: señal original
% fade: representa el tiempo de transición como un porcentaje del largo de x
% s: versión suavizada de x
M = length(x);
if fade > 50
    fade = 50;
elseif fade < 1
    fade = 1;
end
if size(x,1)~=1; x = x'; end
N = 2*floor(fade/100*M);
v = hamming(N)';
fade_in = v(1:floor(N/2));
fade_out = v(floor(N/2)+1:end);
s = [fade_in ones(1,M-length(v)) fade_out].*x;
end