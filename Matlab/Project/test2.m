clc;
clear all;
close all;

VAL1 = 6;
M=16;
k = log2(M);

Transmitted_Message= 'Shajaratul_Jakia_Fatema_Tahmid_Labonno'
x=asc2bn(Transmitted_Message);
bp=.000001;
disp(' Binary information at Trans mitter :');
disp(x);


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

nbit = 304;
dataSymbolsIn = reshape(x,log2(M), nbit/log2(M))';
figure;                    % Create new figure window.
stem(dataSymbolsIn(1:10));
title('Random Symbols');
xlabel('Symbol Index');
ylabel('Integer Value');


dataMod = qammod(dataSymbolsIn,M,'bin');
EbNo = 10;
snr = EbNo + 10*log10(k) - 10*log10(1);
receivedSignal = awgn(dataMod,snr,'measured');

dataSymbolsOut = qamdemod(receivedSignal,M);
Received_Message=bin2asc(dataSymbolsOut)


function dn = asc2bn(txt)
    dec=double(txt)
    p2=2.^(0:-1:-7)
    B=mod(floor(p2'*dec),2)
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