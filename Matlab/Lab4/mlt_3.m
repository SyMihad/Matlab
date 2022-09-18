bit_stream = [0 0 0 1 0 1 1 1 0 0 0 0];
no_bits = length(bit_stream);
bit_rate = 10000;
pulse_per_bit = 1;
pulse_duration = 1/((pulse_per_bit)*(bit_rate));
no_pulses = no_bits*pulse_per_bit;
samples_per_pulse = 1000;
fs = (samples_per_pulse)/(pulse_duration);
t = 0:1/fs:(no_pulses)*(pulse_duration);
no_samples = length(t);
dig_sig = zeros(1,no_samples);
max_voltage = 4;
avg_voltage = 0;
min_voltage = -4;
last_b = 0;
current_level = avg_voltage;
last_nzero_level = min_voltage;
for i = 1:no_bits
 if bit_stream(i) == 1
 if last_b == 0
 if last_nzero_level == min_voltage
 dig_sig(((i-1)*(samples_per_pulse)+1):i*(samples_per_pulse)) = max_voltage*ones(1,samples_per_pulse);
 last_nzero_level = max_voltage;
 current_level = max_voltage;
 last_b = 1;
 else
 dig_sig(((i-1)*(samples_per_pulse)+1):i*(samples_per_pulse)) = min_voltage*ones(1,samples_per_pulse);
 last_nzero_level = min_voltage;
 last_b = 1;
 current_level = min_voltage;
 end
 else
 if last_nzero_level == max_voltage
 dig_sig(((i-1)*(samples_per_pulse)+1):i*(samples_per_pulse)) = avg_voltage*ones(1,samples_per_pulse);
 last_b = 0;
 current_level = avg_voltage;
 elseif last_nzero_level == min_voltage
 dig_sig(((i-1)*(samples_per_pulse)+1):i*(samples_per_pulse)) = avg_voltage*ones(1,samples_per_pulse);
 last_b = 0;
 current_level = avg_voltage;
 else
 dig_sig(((i-1)*(samples_per_pulse)+1):i*(samples_per_pulse)) = current_level*ones(1,samples_per_pulse);
 last_b = 1;
 current_level = last_nzero_level;
 last_nzero_level = current_level;
 end
 end
 else
 dig_sig(((i-1)*(samples_per_pulse)+1):i*(samples_per_pulse)) = current_level*ones(1,samples_per_pulse);
 end
end
plot(t,dig_sig,'linewidth',1.5)
grid on
xlabel('time in seconds')
ylabel('Voltage')
ylim([(min_voltage - (max_voltage)*0.2)
 (max_voltage+max_voltage*0.2)])
title(['MLT-3 for ',num2str(bit_stream),''])
