clc
close all

A=2;
B=0;
C=4;
D=3;
E=0;
F=0;
G=1;
H=1;


fs = 4001; 
t = 0:1/fs:1-1/fs;
Am1 = (F+2);
Am2 = (F+5);
Am3 = (F+8);
Am4 = (F+11);
fm1 = (G+1);
fm2 = (G+2);
fm3 = (G+3);
fm4 = (G+4);


m1 = Am1*cos(2*pi*fm1*t);
m2 = Am2*cos(2*pi*fm2*t);
m3 = Am3*cos(2*pi*fm3*t);
m4 = Am4*cos(2*pi*fm4*t);

Cm1 = 1;
fc1 = 100;
c1 = Cm1*cos(2*pi*fc1*t);
Cm2 = 1;
fc2 = 170;
c2 = Cm2*cos(2*pi*fc2*t);
Cm3 = 1;
fc3 = 250;
c3 = Cm3*cos(2*pi*fc3*t);
Cm4 = 1;
fc4 = 330;
c4 = Cm4*cos(2*pi*fc4*t);


x = (m1).*c1+(m2).*c2+(m3).*c3+(m4).*c4;
figure
subplot(3,2,1)
plot(t,m1)
xlabel('time')
ylabel('amplitude')
title('Message Signal 1 in Time Domain')
ylim([-Am1 Am1])
subplot(3,2,2)
plot(t,m2)
xlabel('time')
ylabel('amplitude')
title('Message Signal 2 in Time Domain')
ylim([-Am2 Am2])
subplot(3,2,3)
plot(t,m3)
xlabel('time')
ylabel('amplitude')
title('Message Signal 3 in Time Domain')
subplot(3,2,4)
plot(t,m4)
xlabel('time')
ylabel('amplitude')
title('Message Signal 4 in Time Domain')
ylim([-Am4 Am4])


M1 = abs(fftshift(fft(m1)))/(fs/2);
M2 = abs(fftshift(fft(m2)))/(fs/2); 
M3 = abs(fftshift(fft(m3)))/(fs/2);
M4 = abs(fftshift(fft(m4)))/(fs/2);
X = abs(fftshift(fft(x)))/(fs/2);
f = fs/2*linspace(-1,1,fs);
figure
subplot(3,2,1)
stem(f,M1)
xlabel('frequency')
ylabel('amplitude')
title('Message Signal 1 in Frequency Domain')
axis([-10 10 0 2.5])
subplot(3,2,2)
stem(f,M2)
xlabel('frequency')
ylabel('amplitude')
title('Message Signal 2 in Frequency Domain')
axis([-10 10 0 3.5])
subplot(3,2,3)
stem(f,M3)
xlabel('frequency')
ylabel('amplitude')
title('Message Signal 3 in Frequency Domain')
axis([-10 10 0 4.5])
subplot(3,2,4)
stem(f,M4)
xlabel('frequency')
ylabel('amplitude')
title('Message Signal 4 in Frequency Domain')
axis([-10 10 0 5.5])

figure
subplot(2,1,1)
plot(t,x)
xlabel('time')
ylabel('amplitude')
title('Composite Signal in Time Domain')
subplot(2,1,2)
stem(f,X)
xlabel('frequency')
ylabel('amplitude')
title('Composite Signal in Frequency Domain')
axis([-270 270 0 2.5])
[num1, den1] = butter(5, [(fc1-fm1-6)/(fs/2),(fc1+fm1+6)/(fs/2)]);
bpf1 = filter(num1,den1,x);
[num2, den2] = butter(5, [(fc2-fm2-6)/(fs/2),(fc2+fm2+6)/(fs/2)]);
bpf2 = filter(num2,den2,x);
[num3, den3] = butter(5, [(fc3-fm3-6)/(fs/2),(fc3+fm3+6)/(fs/2)]);
bpf3 = filter(num3,den3,x);
[num4, den4] = butter(5, [(fc3-fm4-6)/(fs/2),(fc4+fm4+6)/(fs/2)]);
bpf4 = filter(num4,den4,x);
z1 = 2*bpf1.*c1;
z2 = 2*bpf2.*c2;
z3 = 2*bpf3.*c3;
z4 = 2*bpf4.*c4;
[num4, den4] = butter(5, (fm1+3)/(fs/2)); 
rec1 = filter(num4,den4,z1); 
[num5, den5] = butter(5, (fm2+3)/(fs/2));
rec2 = filter(num5,den5,z2);
[num6, den6] = butter(5, (fm3+3)/(fs/2));
rec3 = filter(num6,den6,z3);
[num7, den7] = butter(5, (fm4+3)/(fs/2));
rec4 = filter(num7,den7,z4);
figure
subplot(3,2,1)
plot(t,rec1)
xlabel('time')
ylabel('amplitude')
title('received signal 1 in time domain')
ylim([-Am1 Am1])
subplot(3,2,2)
plot(t,rec2)
xlabel('time')
ylabel('amplitude')
title('received signal 2 in time domain')
ylim([-Am2 Am2])
subplot(3,2,3)
plot(t,rec3)
xlabel('time')
ylabel('amplitude')
title('received signal 3 in time domain')
ylim([-Am3 Am3])
subplot(3,2,4)
plot(t,rec4)
xlabel('time')
ylabel('amplitude')
title('received signal 4 in time domain')
ylim([-Am4 Am4])

R1 = abs(fftshift(fft(rec1)))/(fs/2);
R2 = abs(fftshift(fft(rec2)))/(fs/2);
R3 = abs(fftshift(fft(rec3)))/(fs/2);
R4 = abs(fftshift(fft(rec4)))/(fs/2);
figure
subplot(3,2,1)
stem(f,R1)
xlabel('frequency')
ylabel('amplitude')
title('received signal 1 in frequency domain')
xlim([-10 10])
subplot(3,2,2)
stem(f,R2)
xlabel('frequency')
ylabel('amplitude')
title('received signal 2 in frequency domain')
xlim([-10 10])
subplot(3,2,3)
stem(f,R3)
xlabel('frequency')
ylabel('amplitude')
title('received signal 3 in frequency domain')
xlim([-10 10])
subplot(3,2,4)
stem(f,R4)
xlabel('frequency')
ylabel('amplitude')
title('received signal 4 in frequency domain')
xlim([-10 10])