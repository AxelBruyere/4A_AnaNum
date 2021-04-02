function [yRK,t3]=fct_RK2(y0,tmin,tmax,h,beta,f)


t3 = tmin:h:tmax;
yRK = zeros(1,length(t3));
yRK(1) = y0;

for k = 1:length(t3) - 1
    f1=f(t3(k),yRK(k));
    f2=f(t3(k)+h/(2*beta),yRK(k))+h/(2*beta)*f(t3(k),yRK(k));
    yRK(k+1) = yRK(k) + h*((1-beta)*f1+beta*f2);
end