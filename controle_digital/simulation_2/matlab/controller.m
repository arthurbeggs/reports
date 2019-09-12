function u = controller(v)
global newx a b kc T

x = newx;
uc = v(1);
y = v(2);
u = kc*(b/a*uc-y+x);
newx = x+T*((a-b)*y-a*x);