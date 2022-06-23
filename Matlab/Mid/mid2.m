clear all
clc

z = 6;

T = 1/600;
t = linspace(0, T*2, 500);

signal1 = (z+10)*sin(2*pi*(z*100*t + pi/z));

signal2 = 8*sin(2*pi*1200*t+pi/z);

signal3 = signal1 + signal2;
sd = (z+5)/20;
noise = sd*randn(size(signal3));
