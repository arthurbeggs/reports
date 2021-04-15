G = [[0.5 1]; [0.5 0.7]]
H1 = [0.2; 0.1]
H2 = [1; 0]
C = [1 0]
D = 0

% Analise de controlabilidade de G, H1)
[H1 G*H1]
det([H1 G*H1])

% Polos de Malha Aberta
syms z
vpa(det(z*eye(2) - G))
roots(sym2poly(det(z*eye(2) - G)))

% Polos de Malha Fechada
syms f1 f2
F = [f1 f2]
delta_f = vpa(collect(det(z*eye(2) - G + H1*F), z))
%calcular polinomios na mao
F = [ ((0.2-1.3)/0.28) ((((0.2-1.3)/0.28)*0.08 + 1.3)/0.1) ]
N = 1/(C * inv(eye(2) - G + H1*F) * H1)

erro = - C * inv(eye(2) -G + H1*F) * H2


%Questao 2
syms f1 f2 fa
F = [f1 f2]
delta_f2 = vpa(collect(det(z*eye(2) -G + H1*F)*(z-1) + C * adjoint(z*eye(2) -G + H1*F)*H1*fa, z))

f2 = 0.212/0.056
f1 = 6- 0.5*f2
fa = -0.35*f2 + 4.45
F = [f1 f2]

syms l1 l2
L = [l1; l2]
delta_o = vpa(collect(det(z*eye(2) -G + L*C), z))

l1 = 1.2 -0.4
l2 = 0.08 + 0.15 + 0.7*l1
L = [l1; l2]
