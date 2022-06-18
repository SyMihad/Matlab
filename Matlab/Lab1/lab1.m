clear all
clc

%{
x = 0:pi/100:2*pi;
y = sin(x);
plot(x,y)
xlabel("x")
ylabel('y')
title('y=sin(x)')


x1 = 0:pi/100:2*pi;
y1 = sin(x1);
y2 = sin(x1 - 0.25);
y3 = sin(x1 - 0.5);
plot(x1, y1, x1, y2, x1, y3)
%}

A = 2;
B = 0;
C = 4;
D = 2;
E = 9;
F = 5;
G = 8;
H = 1;

K1 = A+B;
K2 = G+H+2;
J1 = D+G+20;
J2 = 30;


