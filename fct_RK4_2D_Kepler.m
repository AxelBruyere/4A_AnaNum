function [x,y,t]=fct_RK4_2D_Kepler(x0,y0,vx0,vy0,tmin,tmax,h,f,g)

%%Initialisation
t = tmin:h:tmax;
x = zeros(1,length(t)); x(1) = x0;
y = zeros(1,length(t)); y(1) = y0;
vx = zeros(1,length(t)); vx(1) = vx0;
vy = zeros(1,length(t)); vy(1) = vy0;

%%Algo keplerien
for k = 1:length(t)-1
    %%k1
    kf1 = f(t(k),x(k),y(k));
    kg1 = g(t(k),x(k),y(k));
    %%k2
    kf2 = f(t(k) + h/2, x(k) + (h/2)*kf1, y(k) + h/2*kg1);
    kg2 = g(t(k) + h/2, x(k) + (h/2)*kf1, y(k) + h/2*kg1);
    %%k3
    kf3 = f(t(k) + h/2, x(k) + (h/2)*kf2, y(k) + h/2*kg2);
    kg3 = g(t(k) + h/2, x(k) + (h/2)*kf2, y(k) + h/2*kg2);
    %%k4
    kf4 = f(t(k) + h, x(k) + h*kf3, y(k) + h*kg3);
    kg4 = g(t(k) + h, x(k) + h*kf3, y(k) + h*kg3);
    %%Calcul des nouvelles valeures n+1
    x(k+1) = x(k) + h*vx(k);
    vx(k+1) = vx(k) + (h/6) * (kf1 + 2*kf2 + 2*kf3 + kf4);
    y(k+1) = y(k) + h*vy(k);
    vy(k+1) = vy(k) + (h/6) * (kg1 + 2*kg2 + 2*kg3 + kg4);
    
end
  
    
    