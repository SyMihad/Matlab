clc;
clear all;
close all;

VAL1 = 6;

Transmitted_Message= 'Shajaratul_Jakia_Fatema_Tahmid_Labonno'
%dec=double(Transmitted_Message)
x=asc2bn(Transmitted_Message);
bp=.000001;
%disp(' Binary information at Trans mitter :');
%disp(x);
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



% binary information convert into symbolic form for 16QAM modulation
M=16;                                             % order of QAM modulation
nbit = 304;
msg_reshape=reshape(x,log2(M), nbit/log2(M))';
%disp(' information are reshaped for convert symbolic form');
%disp(msg_reshape);
fprintf('\n\n');

size(msg_reshape);
for(j=1:1:nbit/log2(M))
   for(i=1:1:log2(M))
       a(j,i)=num2str(msg_reshape(j,i));
   end
end


as=bin2dec(a);
ass=as';
subplot(3,1,2);
stem(ass,'Linewidth',2.0);
title('serial symbol for 16QAM modulation at transmitter');
xlabel('n(discrete time)');
ylabel(' magnitude');


%disp('symbolic form information for M-array QAM ');
%disp(ass);
%fprintf('\n\n');


%XXXXXXXXXXXXXX Mapping for 16QAM modulation XXXXXXXXXXXXXXXXXXXXXXXX
M=M;                                               %order of QAM modulation
x1=[0:M-1];
p=qammod(ass,M);     %constalation design for M-array QAM acording to symbol
sym=0:1:M-1;     % considerable symbol of M-array QAM, just for scatterplot
pp=qammod(sym,M); %constalation diagram for M-array QAM  

%scatterplot(pp),grid on;
%hold on
%title('consttelation diagram for 16QAM');

% Adding noise %
snr = 6;
p = awgn(p, snr);

scatterplot(p);
title('consttelation diagram after adding noise');


%XXXXXXXXXXXXXXXXXXXXXX  16QAM modulation XXXXXXXXXXXXXXXXXXXXXXXXXXX
RR=real(p);
II=imag(p);
sp=bp*2;                                     %symbol period for M-array QAM
sr=1/sp;                                                      % symbol rate
f=sr*2;
t=sp/100:sp/100:sp;
ss=length(t);
m=[];
for(k=1:1:length(RR))
    yr=RR(k)*cos(2*pi*f*t);                     % inphase or real component
    yim=II(k)*sin(2*pi*f*t);            % Quadrature or imagenary component 
    y=yr+yim;
    m=[m y];
end
tt=sp/100:sp/100:sp*length(RR);
figure(4);
subplot(3,1,3);
plot(tt,m);
title('waveform for 16QAM modulation acording to symbolic information');
xlabel('time(sec)');
ylabel('amplitude(volt)');



%XXXXXXXXXXXXXXXXXXXX M-array QAM demodulation XXXXXXXXXXXXXXXXXXXXXXXXXXXX
m1=[];
m2=[];
for n=ss:ss:length(m)
  t=sp/100:sp/100:sp;
  y1=cos(2*pi*f*t);                                     % inphase component
  y2=sin(2*pi*f*t);                                  % quadrature component
  mm1=y1.*m((n-(ss-1)):n);                                    
  mm2=y2.*m((n-(ss-1)):n);                                    
  z1=trapz(t,mm1);                                             % integration
  z2=trapz(t,mm2);                                             % integration
  zz1=round(2*z1/sp);
  zz2=round(2*z2/sp);
  m1=[m1 zz1];
  m2=[m2 zz2];
end


%XXXXXXXXXXXXXXXXXXX de-mapping for M-array QAM modulation XXXXXXXXXXXXXXXX
clear i;
clear j;
for (k=1:1:length(m1))  
gt(k)=m1(k)+j*m2(k);
end
gt;

ax=qamdemod(gt,M);
figure(3);
subplot(3,1,2);
stem(ax,'linewidth',2);
title(' re-obtain symbol after 16QAM demodulation ');
xlabel('n(discrete time)');
ylabel(' magnitude');

%disp('re-obtain symbol after M-array QAM demodulation ');
%disp(ax);
%fprintf('\n\n');


bi_in=dec2bin(ax);
[row col]=size(bi_in);
p=1;
 for(i=1:1:row)
     for(j=1:1:col)
         re_bi_in(p)=str2num(bi_in(i,j));
         p=p+1;
     end
 end 
%disp('re-obtain binary information after 16QAM demodulation');
%disp(re_bi_in')
%fprintf('\n\n');



%XX representation of receiving binary information as digital signal XXXXXX
x=re_bi_in;
bp=.000001;                                                    % bit period
bit=[]; 
for n=1:1:length(x)
    if x(n)==1;
       se=ones(1,100);
    else x(n)==0;
        se=zeros(1,100);
    end
     bit=[bit se];

end
t1=bp/100:bp/100:100*length(x)*(bp/100);
figure(4)
subplot(3,1,3);
plot(t1,bit,'lineWidth',2.5);grid on;
axis([ 0 bp*length(x) -.5 1.5]);
ylabel('amplitude(volt)');
xlabel(' time(sec)');
title('receiving information as digital signal after 16QAM demoduation');


%Converting Information bit to Message%
Received_Message=bin2asc(re_bi_in)

isMatch = strcmp(Transmitted_Message, Received_Message)

%>>>>>>>> end of program >>>>>>>>>>>>>>>>%



function dn = asc2bn(txt)
    dec=double(txt);
    p2=2.^(0:-1:-7);
    B=mod(floor(p2'*dec),2);
    dn=reshape(B,1,numel(B));
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
