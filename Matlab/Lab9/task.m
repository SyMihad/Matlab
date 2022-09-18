clc;
clear all;
close all;




Transmitted_Message= 'Shajaratul_Jakia_Fatema_Tahmid_Labonno'
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
 y=A1*cos(2*pi*f*t2);
 else
 y=A2*cos(2*pi*f*t2);
 end
 m=[m y];
end
t3=bp/99:bp/99:bp*length(x);
subplot(4,1,2);
plot(t3,m);
axis([ 0 bp*length(x) -6 6]);
xlabel('time(sec)');
ylabel('amplitude(volt)');
title('Modulated Signal at Transmitter');



disp('**********')
disp(' Message transmitted through a Transmission medium');
disp('**********')
%Channel Noise%
t4=bp/99:bp/99:bp*length(x);
Rec=awgn(m,10);
subplot(4,1,3);
plot(t4,Rec);
axis([ 0 bp*length(x) -6 6]);
xlabel('time(sec)');
ylabel('amplitude(volt)');
title('Received signal at Receiver');


%XXXXXXXXXXXXXXXXXXXX Binary ASK demodulation XXXXXXXXXXXXXXXXXXXXXXXXXXXXX
mn=[];
for n=ss:ss:length(Rec)
 t=bp/99:bp/99:bp;
 y=cos(2*pi*f*t); % carrier siignal 
 mm=y.*Rec((n-(ss-1)):n);
 t5=bp/99:bp/99:bp;
 z=trapz(t5,mm) ; 
% intregation 
 zz=round((2*z/bp)); 
 if(zz>2.5) % logic level = (A1+A2)/2=7.5
 a=1;
 else
 a=0;
 end
 mn=[mn a];
end
disp(' Binary information at Reciver :');
disp(mn);
%XXXXX Representation of binary information as digital signal which achived 
%after ASK demodulation XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
bit=[];
for n=1:length(mn);
 if mn(n)==1;
 se=5*ones(1,100);
 else mn(n)==0;
 se=zeros(1,100);
 end
 bit=[bit se];
end
t5=bp/100:bp/100:100*length(mn)*(bp/100);
subplot(4,1,4)
plot(t5,bit,'LineWidth',2.5);grid on;
axis([ 0 bp*length(mn) -.5 6]);
ylabel('amplitude(volt)');
xlabel(' time(sec)');
title('Demodulated signal at receiver');

%Converting Information bit to Message%
Received_Message=bin2asc(mn)
%>>>>>>>> end of program >>>>>>>>>>>>>>>>%




function dn = asc2bn(txt)
    dec=double(txt) %Text to ASCII (decimal)
    p2=2.^(0:-1:-7) % 2^0,2^-1,.......,2^-7
    B=mod(floor(p2'*dec),2) %Decimal to binary conversion
     %Columns of B are bits of chars
    dn=reshape(B,1,numel(B));%Bytes to serial conbversion
end

function txt = bin2asc(dn)
%bin2asc Serial binary to ASCII to text conversion
% 8 bits per char , LSB first
% >> txt= bin2asc(dn) <<
% where dn is binary input sequence
% txt is output text string
L=length(dn); %Length of input string
L8=8*floor(L/8); %Multiple of 8 Length
B=reshape(dn(1:L8),8,L8/8); %Cols of B are bits of chars
p2=2.^(0:7); %power of 2
dec=p2*B; %Binary to decimal conversion
txt=char(dec); %ASCII (decimal) to txt
end