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

A1 = A+B+H;
A2 = B+C+H;
s = (C+D+H)/30;

fs = 8000;
t = 0:1/fs:1-1/fs;

x = A1*sin(2*pi*((C+D+H)*100)*t) + A2*cos(2*pi*((D+E+H)*100)*t) + s*randn(size(t));

snrX = snr(x)

bandWidth = obw(x,fs)

C = bandWidth * log2(1+snrX)

N = 0.8 * C;
L = round(2^(N/(2*bandWidth)))