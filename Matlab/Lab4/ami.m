bit_stream = [0 0 0 1 0 1 1 1 0 0 0 0];
no_bits = length(bit_stream);
bit_rate = 5000;
pulse_per_bit = 1;
pulse_duration = 1/((pulse_per_bit)*(bit_rate*2));
no_pulses = no_bits*pulse_per_bit;
samples_per_pulse = 1000;
fs = (samples_per_pulse)/(pulse_duration);
t = 0:1/fs:(no_pulses)*(pulse_duration);
no_samples = length(t);
dig_sig = zeros(1,no_samples);
max_voltage = 4;
avg_voltage = 0;
min_voltage = -4;
last_bit = 0;
for i = 1:no_bits
if bit_stream(i) == 1
 if last_bit == 0
 dig_sig(((i-1)*(samples_per_pulse)+1):i*(samples_per_pulse)) = max_voltage*ones(1,samples_per_pulse);
 last_bit = 1;
 else
 dig_sig(((i-1)*(samples_per_pulse)+1):i*(samples_per_pulse)) = min_voltage*ones(1,samples_per_pulse);
 last_bit = 0;
 end
else
dig_sig(((i-1)*(samples_per_pulse)+1):i*(samples_per_pulse)) = avg_voltage*ones(1,samples_per_pulse);
end
end
plot(t,dig_sig,'linewidth',1.5)
grid on
xlabel('time in seconds')
ylabel('Voltage')
ylim([(min_voltage - (max_voltage)*0.2)
 (max_voltage+max_voltage*0.2)])
title(['AMI for ',num2str(bit_stream),''])
