clear all
close all
%1

n = 1:50;

x1 = sin(2*pi*0.1*n);
x2 = sin(2*pi*0.05*n);
x3 = sin(2*pi*0.02*n);
x4 = x1+x2+x3;

%plot(x1);
%stem (x1);
%plot(x2);
%stem(x2);
%plot(x3);
%stem(x3);
%plot(x4);
%stem(x4);
%stem(y1);
plot(n, [x1' x2' x3' x4'])
%%
%2
m = 1:10;
y1 = sin(2*pi*0.2*m);
y2= fft(y1, 80);
freqx = linspace(-pi, pi, 80);
plot(freqx, abs(y2), 'o-');

%3
h=[4,3, 3.5, 4, 3, 2.5, 0.5, 0.3, 0.2];
n=9;
stem(h);
H=fft(h, 2000);
frecs=linspace(-pi, pi, 2000);
plot(frecs, abs(H));
zplane(h, 1);
M=100;
n=1:M;
x5=square(2*pi*0.02*n);
y=conv(h, x5);
stem(y);
y=filter(h, 1, x5);
stem(y);
%4
b=[3, 1.5, 2];
a=[1, -1.2];
[H, w]=freqz(b, a, 512);
plot(w, abs(H));
zplane(b, a);
[X5, w2]=freqz(x5, 512);
Y=times(H, X5);
plot(abs(Y));

