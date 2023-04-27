clc
close all
clear all

%% Importing dataset and visu

data = readtable('07560.csv');

figure
plot(data.Time, data.Voltage_measured)
hold on
plot(data.Time, data.Current_measured)
title('Measured voltage and current over time')
grid

figure
plot(data.Time, data.Voltage_charge)
hold on
plot(data.Time, data.Current_charge)
title('Load voltage and current over time')
grid

figure
plot(data.Time, data.Voltage_measured)
hold on
plot(data.Time, data.Voltage_load)
title('Measured voltage and load voltage over time')
legend('V_M', 'V_L')
grid
%%
n = 1;

time = data.Time;
I = data.Current_measured;
v_vec = [];
upper_threshold = 5;
lower_threshold = min(data.Voltage_load);
V = upper_threshold;
t = 1;

% Sample time diff(data.Time)

while (V >= lower_threshold) && (t <= size(data.Time,1))
    V = Voc_fcn(n, t) - R_int(n)*I(t);
   if V < lower_threshold
       v_vec = [v_vec lower_threshold];
   elseif V > upper_threshold
       v_vec = [v_vec upper_threshold];
   else
       v_vec = [v_vec V];
   end
   t = t + 1;
   
end

plot(v_vec)
hold on
yline(threshold)
plot(data.Voltage_load)
hold off