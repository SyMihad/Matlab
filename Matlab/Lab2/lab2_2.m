clc
clear all

A=2;
B=0;
C=4;
D=3;
E=1;
F=7;
G=0;
H=1;

a1 = A + C + 1;
a2 = A + D + 2;
a3 = A + E + 1;
f1 = A + E + 1;
f2 = A + D + 2;
f3 = A + C + 1;

fs=5000;
t=0:1/fs:2;

x1 = a1*cos(2*pi*f1*t);
x2 = a2*sin(2*pi*f2*t);
x3 = a3*cos(2*pi*f3*t);

signal_x = x1 + x2 + x3;


nx = length(t);
fx1 = fft(x1);
fx2 = fft(x2);
fx3 = fft(x3);
fx1 = fftshift(fx1)/(nx/2);
fx2 = fftshift(fx2)/(nx/2);
fx3 = fftshift(fx3)/(nx/2);
f = linspace(-fs/2,fs/2,nx);

bar(f, abs(fx1),2,'k')
hold on
bar(f, abs(fx2),2,'r')
hold on
bar(f,abs(fx3),2,'g')
hold off
axis([-15 15 0 8])
xlabel('Frequency (Hz)')
ylabel('Amplitude')
title('Frequency Domain Representation of Different Signals')
legend('Signal x1','Signal x2', 'Signal x3')

