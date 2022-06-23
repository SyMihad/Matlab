clear all
clc

z = 6;

T = 1/600;
t = linspace(0, T*2, 500);

signal = (z+10)*sin(2*pi*(z*100*t + pi/z));


plot(t, signal)
%axis([0 3.4 0 16])
