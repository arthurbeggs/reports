T = 0.2;

s = tf('s');
z = tf('z', T);

G_s = zpk([], [0 -1], [1])
G_z = c2d(G_s, T, 'zoh')
G_w = zpk(tf(bilin(ss(G_z), -1, 'S_Tust', [T 1])))

[Zw, Pw, Kw] = zpkdata(G_w, 'v');

Kv = 2;
K = Kv/(Kw*(-Zw(1))*(-Zw(2))/(-Pw(2)))

margin(K*G_w)

Gc_w = tf([1.3027 1], [0.4703 1])
Gc_z = zpk(tf(bilin(ss(Gc_w), 1, 'S_Tust', [T 1])))

bode(K*G_w, Gc_w, K*G_w*Gc_w)
grid on

bode(K*G_z, Gc_z, K*G_z*Gc_z)
grid on