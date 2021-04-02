function [x,y,t]=fct_Euler_Kepler(x0,y0,vx0,vy0,tmin,tmax,h,f,g)

%%Initialisation
t = tmin:h:tmax;
x = zeros(1,length(t)); x(1) = x0;
y = zeros(1,length(t)); y(1) = y0;
vx = zeros(1,length(t)); vx(1) = vx0;
vy = zeros(1,length(t)); vy(1) = vy0;

%%Calcul des valeurs n+1
for k = 1:length(t)-1
    x(k+1) = x(k) + h*vx(k);
    vx(k+1) = vx(k) + h*f(t(k),x(k),y(k));
    y(k+1) = y(k) + h*vy(k);
    vy(k+1) = vy(k) + h*g(t(k),x(k),y(k));
end