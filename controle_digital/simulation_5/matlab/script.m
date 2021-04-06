T = 0.1;

s = tf('s');
z = tf('z', T);

G_s = zpk([], [0 -2], [10])
G_z = c2d(G_s, T, 'zoh')

[Z_g, P_g, K_g] = zpkdata(G_z, 'v')
Gc1_z = zpk([0.5 P_g(2)], [1 Z_g(1)], [2/K_g], T)

a1 = -Z_g(1)/(1-Z_g(1))
M1 = 1/(1-Z_g(1))
Gc2_z = zpk([P_g(2)], [-a1], [M1/K_g], T)