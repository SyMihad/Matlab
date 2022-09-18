clc;
clear all;
close all;

Transmitted_Message= 'six'
%Converting Information Message to bit%
x=asc2bn(Transmitted_Message); % Binary Information
bp=.000001; 
% bit period
disp(' Binary information at Trans mitter :');
disp(x);


%XX representation of transmitting binary information as digital signal XXX
bit=[]; 
for n=1:1:length(x)
 if x(n)==1;
 se=5*ones(1,100);
 else x(n)==0;
 se=zeros(1,100);
 end
 bit=[bit se];
end
t1=bp/100:bp/100:100*length(x)*(bp/100);
subplot(4,1,1);
plot(t1,bit,'lineWidth',2.5);grid on;
axis([ 0 bp*length(x) -.5 6]);
ylabel('amplitude(volt)');
xlabel(' time(sec)');
title('Transmitting information as digital signal');


%XXXXXXXXXXXXXXXXXXXXXXX Binary-ASK modulation XXXXXXXXXXXXXXXXXXXXXXXXXXX%
A1=5; % Amplitude of carrier signal for information 1
A2=0; % Amplitude of carrier signal for information 0
br=1/bp; % bit rate
%f=br*10; % carrier frequency
f=100;
t2=bp/99:bp/99:bp; 
ss=length(t2);
N = 6 ;
m=[];
for (i=1:1:length(x))
 if (x(i)==1)
 y=A1*cos(2*pi*N*f*t2);
 else
 y=A2*cos(2*pi*N*f*t2);
 end
 m=[m y];
end
carrier = 1*cos(2*pi*N*f*t2);
subplot(4,1,2);
plot(t2, carrier);
%axis([ 0 10 -10 10]);
xlabel('time(sec)');
ylabel('amplitude(volt)');
title('Carrier Signal');

t3=bp/99:bp/99:bp*length(x);
subplot(4,1,3);
plot(t3,m);
axis([ 0 bp*length(x) -6 6]);
xlabel('time(sec)');
ylabel('amplitude(volt)');
title('Modulated Signal at Transmitter');


scatterplot(m)



function dn = asc2bn(txt)
    dec=double(txt) %Text to ASCII (decimal)
    p2=2.^(0:-1:-7) % 2^0,2^-1,.......,2^-7
    B=mod(floor(p2'*dec),2) %Decimal to binary conversion
     %Columns of B are bits of chars
    dn=reshape(B,1,numel(B));%Bytes to serial conbversion
end