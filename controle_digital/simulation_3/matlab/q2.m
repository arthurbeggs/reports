% Parte 1
T = 0.2;
s = tf('s');
z = tf('z', T);
Gp_s = zpk([ ], [0 -2], [1]);
Gp_z = c2d(Gp_s, T, 'zoh')

zeta = 0.5;
t_s = 2;
j = sqrt(-1);
omega_n = 4/(zeta * t_s)
omega_d = omega_n * sqrt(1 - zeta^2)
mod_z = exp(-zeta * omega_n * T)
angle_z = rad2deg(omega_d * T)
z_dom = mod_z * cosd(angle_z) + j * mod_z * sind(angle_z)

% Root locus e polos dominantes
hold on;
rlocus(Gp_z)
plot(real(z_dom),imag(z_dom),'r*',real(z_dom),-imag(z_dom),'r*')
hold off;

% Condiçao de fase
[Z_dom, P_dom, K_dom] = zpkdata(Gp_z, 'v');
% Generalizar
controller_angle = -180 -( atand(imag(z_dom)/(max(real(z_dom),Z_dom(1)) - min(real(z_dom),Z_dom(1)))) -(180 - atand(imag(z_dom)/(max(real(z_dom),P_dom(1)) - min(real(z_dom),P_dom(1))))) )

p_c = (imag(z_dom)/tand(controller_angle)) + real(z_dom)
Gc_z = zpk([ P_dom(2) ], [p_c], [1], T)
Gs_z = Gc_z * Gp_z

% Root locus e polos dominantes
hold on;
rlocus(Gs_z,(0:0.01:100))
plot(real(z_dom),imag(z_dom),'r*',real(z_dom),-imag(z_dom),'r*')
hold off;

% Encontrando Kc
[Z_sys, P_sys, K_sys] = zpkdata(Gs_z, 'v');
Kc = ( abs(z_dom - P_sys(1)) * abs(z_dom - P_sys(2)) ) / ( K_sys * abs(z_dom - Z_sys(2)) )
Gc_z = Kc * Gc_z
Gs_z = Gc_z * Gp_z


% Parte 2
step(feedback(Gs_z, 1))
step_info = stepinfo(feedback(Gs_z, 1))
ts_response = step_info(1).SettlingTime;
zeta_response = (-log(step_info(1).Overshoot/100)/sqrt(pi^2 + log(step_info(1).Overshoot/100).^2))


% Parte 3
time = (0:T:10);
ramp_output = lsim(feedback(Gs_z, 1), time, time);

lsim(feedback(Gs_z, 1), time, time)

% Retira as amostras antes do tempo de acomodaçao
time_slice = time((step_info.SettlingTime/T):end);
ramp_slice = ramp_output((step_info.SettlingTime/T):end);
e_ss = mean(arrayfun(@(x,y) x - y, time_slice, ramp_slice.'))

% Cálculo do e_ss
syms z;
[Num_Gs, Den_Gs] = tfdata(Gs_z);
symbolic_Gs_z = vpa(poly2sym(cell2mat(Num_Gs),z)/poly2sym(cell2mat(Den_Gs),z));
z = 0.99999999999; % Poor man's limit
Kv = subs(collect(1/T * (z-1)/z * symbolic_Gs_z))
e_ss_calculated = 1/Kv

% Consertando z
z = tf('z', T);


% Parte 4
Gc2_z = Gc_z * zpk([0.94], [0.98], [1], T)

hold on;
rlocus(Gp_z*Gc2_z)
plot(real(z_dom),imag(z_dom),'r*',real(z_dom),-imag(z_dom),'r*')
hold off;

lsim(feedback(Gp_z*Gc2_z, 1), time, time)

time_longer = (0:T:25);
ramp_output_new = lsim(feedback(Gp_z*Gc2_z, 1), time_longer, time_longer);

step(feedback(Gp_z*Gc2_z, 1))

step_info_new = stepinfo(feedback(Gp_z*Gc2_z, 1))
ts_response_new = step_info_new(1).SettlingTime;
zeta_response_new = (-log(step_info_new(1).Overshoot/100)/sqrt(pi^2 + log(step_info_new(1).Overshoot/100).^2))

time_slice_new = time_longer((step_info_new.SettlingTime/T):end);
ramp_slice_new = ramp_output_new((step_info_new.SettlingTime/T):end);
e_ss_new = mean(arrayfun(@(x,y) x - y, time_slice_new, ramp_slice_new.'))
