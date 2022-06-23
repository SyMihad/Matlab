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

nx = length(t);
fftSignal = fft(signal3);
fftSignal = fftshift(fftSignal)/(nx/2);
f = linspace(-fs/2,fs/2,nx);
plot(f, abs(fftSignal),'linewidth',1);

bandwidth = obw(signal3, fs)

