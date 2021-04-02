function [x,y,u,v,t]=fct_RK4_4D(x0,y0,u0,v0,tmin,tmax,pas,f,g,h,i)


t = tmin:pas:tmax;
x = zeros(1,length(t));
x(1) = x0;
y = zeros(1,length(t));
y(1) = y0;
u = zeros(1,length(t));
u(1) = u0;
v = zeros(1,length(t));
v(1) = v0;

for k = 1:length(t)-1
    
    kf1 = f(t(k),x(k),y(k),u(k),v(k));
    kg1 = g(t(k),x(k),y(k),u(k),v(k));
    kh1 = h(t(k),x(k),y(k),u(k),v(k));
    ki1 = i(t(k),x(k),y(k),u(k),v(k));
    
    kf2 = f(t(k) + pas / 2, x(k) + (pas / 2) * kf1, y(k) + (pas / 2) * kg1, u(k) + (pas/2) * kh1, v(k) + (pas/2) * ki1); 
    kg2 = g(t(k) + pas / 2, x(k) + (pas / 2) * kf1, y(k) + (pas / 2) * kg1, u(k) + (pas/2) * kh1, v(k) + (pas/2) * ki1);
    kh2 = h(t(k) + pas / 2, x(k) + (pas / 2) * kf1, y(k) + (pas / 2) * kg1, u(k) + (pas/2) * kh1, v(k) + (pas/2) * ki1); 
    ki2 = i(t(k) + pas / 2, x(k) + (pas / 2) * kf1, y(k) + (pas / 2) * kg1, u(k) + (pas/2) * kh1, v(k) + (pas/2) * ki1); 
    
    kf3 = f(t(k) + pas / 2, x(k) + (pas / 2) * kf2, y(k) + (pas / 2) * kg2, u(k) + (pas/2) * kh2, v(k) + (pas/2) * ki2); 
    kg3 = g(t(k) + pas / 2, x(k) + (pas / 2) * kf2, y(k) + (pas / 2) * kg2, u(k) + (pas/2) * kh2, v(k) + (pas/2) * ki2);
    kh3 = h(t(k) + pas / 2, x(k) + (pas / 2) * kf2, y(k) + (pas / 2) * kg2, u(k) + (pas/2) * kh2, v(k) + (pas/2) * ki2); 
    ki3 = i(t(k) + pas / 2, x(k) + (pas / 2) * kf2, y(k) + (pas / 2) * kg2, u(k) + (pas/2) * kh2, v(k) + (pas/2) * ki2);
    
    kf4 = f(t(k) + pas, x(k) + pas * kf3, y(k) + pas * kg3, u(k) + pas * kh3, v(k) + pas * ki3);
    kg4 = g(t(k) + pas, x(k) + pas * kf3, y(k) + pas * kg3, u(k) + pas * kh3, v(k) + pas * ki3);
    kh4 = h(t(k) + pas, x(k) + pas * kf3, y(k) + pas * kg3, u(k) + pas * kh3, v(k) + pas * ki3);
    ki4 = i(t(k) + pas, x(k) + pas * kf3, y(k) + pas * kg3, u(k) + pas * kh3, v(k) + pas * ki3);
    
    x(k+1) = x(k) + pas / 6 * (kf1 + 2 * kf2 + 2 * kf3 + kf4);
    y(k+1) = y(k) + pas / 6 * (kg1 + 2 * kg2 + 2 * kg3 + kg4);
    u(k+1) = u(k) + pas / 6 * (kh1 + 2 * kh2 + 2 * kh3 + kh4);
    v(k+1) = v(k) + pas / 6 * (ki1 + 2 * ki2 + 2 * ki3 + ki4);
    
end