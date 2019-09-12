clear
close all

global newx a b kc T

J = 1;
kp = 1;
w0 = 1;
a = 2*w0;
b = w0/2;
kc = 2*J*w0^2/kp;

syscl = tf([w0^2/2 w0^3],[1 2*w0 2*w0^2 w0^3]);
bode(syscl)

[mag,phase,wout] = bode(syscl);                                 % Get Plot Data
mag = squeeze(mag);                                             % Reduce (1x1xN) Matrix To (1xN)
phase= squeeze(phase);
magr2 = (mag/max(mag)).^2;                                      % Calculate Power Of Ratio Of ‘mag/max(mag)’
dB3 = interp1(magr2, [wout phase mag], 0.5, 'spline');          % Find Frequency & Phase & Amplitude of Half-Power (-3 dB) Point
figure(1)
subplot(2,1,1)
semilogx(wout, 20*log10(mag), '-b',  dB3(1), 20*log10(dB3(3)), '+r', 'MarkerSize',10)
grid
subplot(2,1,2)
semilogx(wout, phase, '-b',  dB3(1), dB3(2), '+r', 'MarkerSize',10)
grid


newx = 0;
tf = 10;
T = 0.2/w0;
sim('exsim2model')
figure
subplot(211)
plot(y(:,1),y(:,2),y(:,1),y(:,3))
title('T = 0.2/\omega_0')
xlabel('t(s)')
ylabel('y')
grid
legend('continuo','discretizado')
subplot(212)
stairs(u(:,1),u(:,3),'r')
hold on
plot(u(:,1),u(:,2))
xlabel('t(s)')
ylabel('u')
grid

newx = 0;
tf = 10;
T = 0.5/w0;
sim('exsim2model')
figure
subplot(211)
plot(y(:,1),y(:,2),y(:,1),y(:,3))
title('T = 0.5/\omega_0')
xlabel('t(s)')
ylabel('y')
grid
legend('continuo','discretizado')
subplot(212)
stairs(u(:,1),u(:,3),'r')
hold on
plot(u(:,1),u(:,2))
xlabel('t(s)')
ylabel('u')
grid

newx = 0;
tf = 15;
T = 1.08/w0;
sim('exsim2model')
figure
subplot(211)
plot(y(:,1),y(:,2),y(:,1),y(:,3))
title('T = 1.08/\omega_0')
xlabel('t(s)')
ylabel('y')
grid
legend('continuo','discretizado')
subplot(212)
stairs(u(:,1),u(:,3),'r')
hold on
plot(u(:,1),u(:,2))
xlabel('t(s)')
ylabel('u')
grid
