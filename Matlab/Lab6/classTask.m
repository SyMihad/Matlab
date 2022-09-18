close all;
clc;
f=5;
f2=10;
x=[001 100 010 011 011 100 110 000]; % input signal ;
nx=size(x,2);
i=1;
while i<nx+1
     t = i:0.001:i+1;
     if num2str(x(i),'%03.f')=='000'
         ask=0*sin(2*pi*1*t);
         fsk=sin(2*pi*f*t);
         psk=sin(2*pi*f*t);
     elseif num2str(x(i),'%03.f')=='001'
         ask=1*sin(2*pi*f*t);
         fsk=sin(2*pi*2*t);
         psk=sin(2*pi*f*t+(pi/4));
     elseif num2str(x(i),'%03.f')=='010'
         ask=2*sin(2*pi*f*t);
         fsk=sin(2*pi*3*t);
         psk=sin(2*pi*f*t+(3*pi/4));
     elseif num2str(x(i),'%03.f')=='011'
         ask=3*sin(2*pi*f*t);
         fsk=sin(2*pi*4*t);
         psk=sin(2*pi*f*t+(pi/2));
     elseif num2str(x(i),'%03.f')=='100'
         ask=4*sin(2*pi*f*t);
         fsk=sin(2*pi*5*t);
         psk=sin(2*pi*f*t-(pi/4));
     elseif num2str(x(i),'%03.f')=='101'
         ask=5*sin(2*pi*f*t);
         fsk=sin(2*pi*6*t);
         psk=sin(2*pi*f*t-(pi/2));
     elseif num2str(x(i),'%03.f')=='110'
         ask=6*sin(2*pi*f*t);
         fsk=sin(2*pi*7*t);
         psk=sin(2*pi*f*t+pi);
     elseif num2str(x(i),'%03.f')=='111'
         ask=7*sin(2*pi*f*t);
         fsk=sin(2*pi*8*t);
         psk=sin(2*pi*f*t-(3*pi/4));
     end
     subplot(3,1,1);
     plot(t,ask);
     hold on;
     grid on;
     axis([1 10 -7 7]);
     title('Amplitude Shift Key')
     subplot(3,1,2);
     plot(t,fsk);
     hold on;
     grid on;
     axis([1 10 -1 1]);
     title('Frequency Shift Key')
     subplot(3,1,3);
     plot(t,psk);
     hold on;
     grid on;
     axis([1 10 -1 1]);
     title('Phase Shift Key')
     i=i+1;
end

