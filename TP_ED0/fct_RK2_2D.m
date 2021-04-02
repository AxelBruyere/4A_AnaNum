function [x,y,t]=fct_RK2_2D(x0,y0,tmin,tmax,pas,beta,f,g)


t = tmin:pas:tmax;
x = zeros(1,length(t));
x(1) = x0;
y = zeros(1,length(t));
y(1) = y0;

for k = 1:length(t) - 1
    
    f1 = f(t(k),x(k),y(k));
    g1 = g(t(k),x(k),y(k));
    f2=f(t(k) + pas / (2 * beta) , x(k) + (pas / (2 * beta)) * f(t(k) , x(k) , y(k)), y(k) + (pas/ 2*beta) * f(t(k) , x(k) , y(k)));
    g2=g(t(k) + pas / (2 * beta) , x(k) + (pas / (2 * beta)) * g(t(k) , x(k) , y(k)), y(k) + (pas/ 2*beta) * g(t(k) , x(k) , y(k)));
    
    x(k+1) = x(k) + pas * ((1 - beta) * f1 + beta * f2);
    y(k+1) = y(k) + pas * ((1 - beta) * g1 + beta * g2);
end