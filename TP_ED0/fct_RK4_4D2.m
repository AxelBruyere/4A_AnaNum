function [x,y,u,v,t]=fct_RK4_4D2(x0,y0,u0,v0,tmin,tmax,h,f1,f2,f3,f4)


t = tmin:h:tmax;
x = zeros(1,length(t));
x(1) = x0;
y = zeros(1,length(t));
y(1) = y0;
u = zeros(1,length(t));
u(1) = u0;
v = zeros(1,length(t));
v(1) = v0;

for k = 1:length(t)-1
    
    kf1_1 = f1(t(k),x(k),y(k),u(k),v(k));
    kf2_1 = f2(t(k),x(k),y(k),u(k),v(k));
    kf3_1 = f3(t(k),x(k),y(k),u(k),v(k));
    kf4_1 = f4(t(k),x(k),y(k),u(k),v(k));
    
    kf1_2 = f1(t(k) + h / 2, x(k) + (h / 2) * kf1_1, y(k) + (h / 2) * kf2_1, u(k) + (h/2) * kf3_1, v(k) + (h/2) * kf4_1); 
    kf2_2 = f2(t(k) + h / 2, x(k) + (h / 2) * kf1_1, y(k) + (h / 2) * kf2_1, u(k) + (h/2) * kf3_1, v(k) + (h/2) * kf4_1);
    kf3_2 = f3(t(k) + h / 2, x(k) + (h / 2) * kf1_1, y(k) + (h / 2) * kf2_1, u(k) + (h/2) * kf3_1, v(k) + (h/2) * kf4_1); 
    kf4_2 = f4(t(k) + h / 2, x(k) + (h / 2) * kf1_1, y(k) + (h / 2) * kf2_1, u(k) + (h/2) * kf3_1, v(k) + (h/2) * kf4_1); 
    
    kf1_3 = f1(t(k) + h / 2, x(k) + (h / 2) * kf1_2, y(k) + (h / 2) * kf2_2, u(k) + (h/2) * kf3_2, v(k) + (h/2) * kf4_2); 
    kf2_3 = f2(t(k) + h / 2, x(k) + (h / 2) * kf1_2, y(k) + (h / 2) * kf2_2, u(k) + (h/2) * kf3_2, v(k) + (h/2) * kf4_2);
    kf3_3 = f3(t(k) + h / 2, x(k) + (h / 2) * kf1_2, y(k) + (h / 2) * kf2_2, u(k) + (h/2) * kf3_2, v(k) + (h/2) * kf4_2); 
    kf4_3 = f4(t(k) + h / 2, x(k) + (h / 2) * kf1_2, y(k) + (h / 2) * kf2_2, u(k) + (h/2) * kf3_2, v(k) + (h/2) * kf4_2);
    
    kf1_4 = f1(t(k) + h, x(k) + h * kf1_3, y(k) + h * kf2_3, u(k) + h * kf3_3, v(k) + h * kf4_3);
    kf2_4 = f2(t(k) + h, x(k) + h * kf1_3, y(k) + h * kf2_3, u(k) + h * kf3_3, v(k) + h * kf4_3);
    kf3_4 = f3(t(k) + h, x(k) + h * kf1_3, y(k) + h * kf2_3, u(k) + h * kf3_3, v(k) + h * kf4_3);
    kf4_4 = f4(t(k) + h, x(k) + h * kf1_3, y(k) + h * kf2_3, u(k) + h * kf3_3, v(k) + h * kf4_3);
    
    x(k+1) = x(k) + h / 6 * (kf1_1 + 2 * kf1_2 + 2 * kf1_3 + kf1_4);
    y(k+1) = y(k) + h / 6 * (kf2_1 + 2 * kf2_2 + 2 * kf2_3 + kf2_4);
    u(k+1) = u(k) + h / 6 * (kf3_1 + 2 * kf3_2 + 2 * kf3_3 + kf3_4);
    v(k+1) = v(k) + h / 6 * (kf4_1 + 2 * kf4_2 + 2 * kf4_3 + kf4_4);
    
end