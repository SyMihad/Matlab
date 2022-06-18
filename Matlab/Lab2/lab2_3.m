clc
clear all

A=2;
B=0;
C=4;
D=3;
E=0;
F=0;
G=1;
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

l=8;
step = (max(signal_x)-min(signal_x))/(l-1);

partition = (min(signal_x)+step/2):step:(max(signal_x)-step/2);
codebook = min(signal_x):step:max(signal_x);
[index,quants] = quantiz(signal_x,partition,codebook);
plot(t,signal_x,'-',t,quants,'LineWidth',2)
legend('Original signal','Quantized signal')
