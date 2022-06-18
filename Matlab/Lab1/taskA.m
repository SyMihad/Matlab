clear all
clc

A = 2;
B = 0;
C = 4;
D = 2;
E = 9;
F = 5;
G = 8;
H = 1;

T = 1/11;

t = linspace(0,T*3,300);



K1 = A+B;
K2 = G+H+2;
J1 = deg2rad(D+G+20);
J2 = deg2rad(30);

x1 = K1*cos(2*pi*(E+F+5)*t+J1);
x2 = K2*cos(2*pi*(C+D+5)*t+J2);

figure(1)
plot(t,x1,'r')

figure(2)
plot(t,x2,'g')
