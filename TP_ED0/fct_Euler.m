function [yEuler1,t1]=fct_Euler(y0,tmin,tmax,h,f)

t1 = tmin:h:tmax;
yEuler1 = zeros(1,length(t1));
yEuler1(1) = y0;

for k = 1:length(t1)-1
    yEuler1(k+1) = yEuler1(k) + h*f(t1(k),yEuler1(k));
end

