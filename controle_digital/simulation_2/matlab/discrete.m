clear
close all

SAMPLES = 100;
T = 0:SAMPLES-1;
t = 0:SAMPLES-1;
%% CONTINUOUS CASE
y = 300.*exp(-2*t /10) - 200.*exp(-3*t /10) ;
%% ZERO HOLD IN SERIES
yz = zeros (1 ,SAMPLES) ;
yz (1) = 100; yz (2) = 0 + yz (1) ;
for n = 3:SAMPLES
yz(n) = 1.5595*yz(n-1) - 0.6065*yz(n-2);
end
%% FORWARD RULE
yf = zeros (1 ,SAMPLES) ;
yf (1) = 100; yf (2) = 0 + yf (1) ;
for n = 3:SAMPLES
yf (n) = 1.5* yf (n-1) - 0.56* yf (n-2);
end
%% BACKWARD RULE
yb = zeros (1 ,SAMPLES) ;
yb(1) = 100; yb(2) = 0 + yb(1) ;
for n = 3:SAMPLES
yb(n) = (2.5*yb(n-1) - yb(n-2)) /(1.56) ;
end
%% TRAPEZOIDAL RULE
yt = zeros (1 ,SAMPLES) ;
yt (1) = 100;
yt (2) = 0 + yt (1) ;
for n = 3:SAMPLES
yt(n) = (788*yt(n-1) - 306*yt(n-2)) /(506) ;
end
%% PLOTTING
figure ;
hold all ;
plot(t ,y) ;
plot(T, yz) ;
plot(T, yf ) ;
plot(T,yb) ;
plot(T, yt) ;
axis ([0 35 0 101]) ;
title ( 'Resposta das FTs' ) ;
xlabel( 'Tempo (T = 0.1s) ' ) ;
ylabel( 'y(kT)' ) ;
legend( 'Contínuo' , 'ZOH' , 'Para Frente' , 'Para Trás' , 'Trapezoidal') ;
