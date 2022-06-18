clc
clear all

A=1;
B=9;
C=4;
D=1;
E=7;
F=8;
G=4;
H=3;

a1 = A + C + 1;
a2 = A + D + 2;
a3 = A + E + 1;
f1 = A + E + 1;
f2 = A + D + 2;
f3 = A + C + 1;

fstime=500;
ttime=0:1/fstime:0.5;

fsFreq=5000;
tFreq=0:1/fsFreq:2;

x1Time = a1*cos(2*pi*f1*ttime);
x2Time = a2*sin(2*pi*f2*ttime);
x3Time = a3*cos(2*pi*f3*ttime);

x1Freq = a1*cos(2*pi*f1*tFreq);
x2Freq = a2*sin(2*pi*f2*tFreq);
x3Freq = a3*cos(2*pi*f3*tFreq);

nx = length(tFreq);
fx1 = fft(x1Freq);
fx2 = fft(x2Freq);
fx3 = fft(x3Freq);
fx1 = fftshift(fx1)/(nx/2);
fx2 = fftshift(fx2)/(nx/2);
fx3 = fftshift(fx3)/(nx/2);
f = linspace(-fsFreq/2,fsFreq/2,nx);


subplot(311)
hold on
plot(ttime,x1Time,'k--o','LineWidth',1)
hold on
plot(ttime,x2Time,'b-*','LineWidth',1)
hold on
plot(ttime,x3Time,'r-','LineWidth',2)
hold off
xlabel('time in seconds')
ylabel('Amplitude in volts')
title('Signals of different Frequencies')
legend('Signal x1','Signal x2','Signal x3')


subplot(313)
hold on
bar(f, abs(fx1),2,'k')
hold on
bar(f, abs(fx2),2,'r')
hold on
bar(f,abs(fx3),2,'g')
hold off
axis([-15 15 0 10])
xlabel('Frequency (Hz)')
ylabel('Amplitude')
title('Frequency Domain Representation of Different Signals')
legend('Signal x1','Signal x2', 'Signal x3')




