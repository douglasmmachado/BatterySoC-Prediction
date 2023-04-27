clc
clear all
close all

%%

threshold = 2.8;
Tf = 4000;
Vo = 5;

for n = 0:20:200

    voc_vec = [];
    voc = Vo;
    t = 0;
    
    %while (t <= 3700)
    while (voc >= threshold) && (voc <= 5 ) && (t <= Tf)
       voc = Voc_fcn(n, t, Tf, Vo);
       
       if voc < threshold
           voc_vec = [voc_vec threshold];
       elseif voc > 5
           voc_vec = [voc_vec 5];
       else
           voc_vec = [voc_vec voc];
           
       end
       t = t + 1;
    end
    %disp(size(voc_vec))
    hold on
    if n == 0
        plot(voc_vec, 'r-', 'DisplayName', 'First cycle')
    elseif n == 200
        plot(voc_vec, 'b-', 'DisplayName', 'Final cycle')
    else
        plot(voc_vec, 'k--')
    end

end
yline(threshold)
legend({"First cycle", "Intermediate cycles", "" , "", "","","","","","","200th Cycle"})
grid

%% Internal resistance

r_int_vec = zeros(1,200);

for n = 1:200
    r_int_vec(n) = R_int(n);
end

plot(r_int_vec)
ylabel('Internal resistance [\Omega]')
xlabel('Charge cycles [n]')
title('Internal resistance')
grid;

%% SIMULATION

Vo = 5;  %[V] Initial voltage
Tf = 3800;  %[s] cycle maximum time
n = 200;  %N cycles
min = 2.8; %[V] minimum limit tension
Te = 0.02; 


sim('battery_simu.slx', Tf*n)

%%


time = out.tout;

%I = out.I.signals.values(:);
%V = out.V.signals.values(:);
voc = out.voc.Data(:);
figure
plot(voc)
yline(threshold)
xlabel("Time [s]")
ylabel("Voltage [V]")
legend("V_oc")
title("Battery voltage over time - simulink")
ylim([2.7 5.1])
xlim([0 length(voc)])
grid minor

r_int = out.rint.Data(:);


figure
plot(r_int)
xlabel("Time [s]")
ylabel("Resistance [\Omega]")
legend("R_int")
title("Battery internal resistance over time - simulink")
grid minor
%%
figure
subplot(2,1,1)
plot(0:0.02:3.2252e+03,voc(1:161261))
ylim([2.7 5.1])
yline(threshold)
xlabel("Time [s]")
ylabel("Voltage [V]")
legend("V_oc")
title("Battery voltage over time - first cycle")
grid minor

subplot(2,1,2)
plot(0:0.02:1.4986e+03,voc((end - 74931):end-1))
ylim([2.7 5.1])
yline(threshold)
xlabel("Time [s]")
ylabel("Voltage [V]")
legend("V_oc")
title("Battery voltage over time - last cycle")
grid minor