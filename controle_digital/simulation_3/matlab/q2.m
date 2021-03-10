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
z_dom = mod_z * cosd(angle_z) + j * sind(angle_z)

% Root locus e polos dominantes
hold on
rlocus(Gp_z)
plot(real(z_dom),imag(z_dom),'r*',real(z_dom),-imag(z_dom),'r*')

% Condiçao de fase
[Z_dom, P_dom, K_dom] = zpkdata(Gp_z, 'v');
% Generalizar
% controller_angle = -180 -( atand(imag(z_dom)/(max(real(z_dom),Z) - min(real(z_dom),Z))) -(180 - atand(imag(z_dom)/(max(real(z_dom),P(1)) - min(real(z_dom),P(1))))) - (180 - atand(imag(z_dom)/(max(real(z_dom),P(2)) - min(real(z_dom),P(2))))) 
controller_angle = -180 -( atand(imag(z_dom)/(max(real(z_dom),Z) - min(real(z_dom),Z))) -(180 - atand(imag(z_dom)/(max(real(z_dom),P(1)) - min(real(z_dom),P(1))))) )

p_c = (imag(z_dom)/tand(controller_angle)) + real(z_dom)
Gc_z = zpk([ P_dom(2) ], [p_c], [1], T)
Gs_z = Gc_z * Gp_z

% Root locus e polos dominantes
hold on
rlocus(Gs_z,(0:0.01:100))
plot(real(z_dom),imag(z_dom),'r*',real(z_dom),-imag(z_dom),'r*')

% Encontrando Kc
[Z_sys, P_sys, K_sys] = zpkdata(Gs_z, 'v');
Kc = ( abs(z_dom - P_sys(1)) * abs(z_dom - P_sys(2)) ) / ( K_sys * abs(z_dom - Z_sys(2)) )
