clear all
clc

z = 6;
fs = 12000;
T = 1/600;
t = linspace(0, T*2, 500);

signal1 = (z+10)*sin(2*pi*(z*100*t + pi/z));

signal2 = 8*sin(2*pi*1200*t+pi/z);

signalA = signal1 + signal2;
sd = (z+5)/20;
noise = sd*randn(size(signalA));
signal3 = signal1 + signal2+noise;



bandWidth = obw(signal3, fs);

snrX = snr(signal3)
C = bandWidth * log2(1+snrX)

