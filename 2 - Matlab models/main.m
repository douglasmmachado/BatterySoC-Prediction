clc
clear all
close all

%% SIMULATION

Vo = 4.2;  %[V] Initial voltage
Tf = 3600;  %[s] cycle theorical maximum time
n = 200;  %N cycles
min = 3.2; %[V] minimum limit tension
Te = 1; 


sim('battery_soc.slx', Tf*n)
%sim('RLS_simu.slx', Tf*n)
disp('Finished')

%%

I = out.I.signals.values(:);
V = out.V.signals.values(:);
Voc = out.Voc.signals.values(:);
R_int = out.R_int.signals.values(:);
Zeta = out.Zeta.signals.values(:);
M = {'current_measured','voltage_measured','voc','rint','zeta'};

N = [I V Voc R_int Zeta];


csvwrite_with_headers('data.csv',N,M);

%%

time = out.tout;

%I = out.I.signals.values(:);
%V = out.V.signals.values(:);
voc = out.voc.Data(:);
voc_est = out.voc_est.Data(:);

figure
subplot(2,1,1)
plot(0:0.02:3.2252e+03,voc(1:161261),'DisplayName','Voc')
ylim([2.7 5.1])
yline(threshold, 'DisplayName','Threshold')
xlabel("Time [s]")
ylabel("Voltage [V]")
title("Battery voltage over time - first cycle")
grid minor
hold on
plot(0:0.02:3.2252e+03,voc_est(1:161261),'DisplayName','Voc_{est}')
legend
hold off


subplot(2,1,2)
plot(0:0.02:1.4986e+03,voc((end - 74931):end-1),'DisplayName','Voc')
ylim([2.7 5.1])
yline(threshold, 'DisplayName','Threshold')
xlabel("Time [s]")
ylabel("Voltage [V]")

title("Battery voltage over time - last cycle")
grid minor
hold on
plot(0:0.02:1.4986e+03,voc_est((end - 74931):end-1),'DisplayName','Voc_{est}')
hold off
legend

%%

E = rmse(voc_est(1:23779445),voc(1:23779445))
y = voc(1:23779445);
yhat = voc_est(1:23779445);

Errors = (y - yhat).^2; % Squared Error
mean((y - yhat).^2); % Mean Squared Error
RMSE = sqrt(mean((y - yhat).^2)); % Root Mean Squared Error
figure
plot(Errors)