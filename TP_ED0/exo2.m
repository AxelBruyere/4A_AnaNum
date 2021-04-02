clear variables;
close all;
clc;

tmin=0;tmax=1;
f=@(t,y)(-(4*t.^3+5) * y + t.^3 .* exp(-5*t));
yExact=@(t)(0.25 * (exp(t.^4) + 3).*exp(-t .* (t.^3 + 5)));
    
% condition initiale
y0=1;

%% question 1
% 1. méthode d'Euler (h=0.1)
h=0.1;
[yEuler1,t1]=fct_Euler(y0,tmin,tmax,h,f);
eps1=abs(yEuler1-yExact(t1));   % erreur

% 2. méthode d'Euler (h=0.05)
h=0.05;
[yEuler2,t2]=fct_Euler(y0,tmin,tmax,h,f);
eps2=abs(yEuler2-yExact(t2));   % erreur

% 3. méthode RK2 (h=0.1 et beta=1)
h=0.05;beta=1;
[yRK,t3]=fct_RK2(y0,tmin,tmax,h,beta,f);
eps3=abs(yRK-yExact(t3));       % erreur


figure(1)
subplot 211
hold on
plot(tmin:h:tmax,yExact(tmin:h:tmax))
plot(t1,yEuler1)
plot(t2,yEuler2)
plot(t3,yRK)
xlabel('Temps t')
ylabel('Y(t)')
title('Solutions exacte et approchées')
lg1 = legend('Solution analytique','Solution par Euler avec h = 0.1', 'Solution par Euler avec h= 0.05','Solution par Runge-Kutta avec h = 0.05 et beta = 1')

subplot 212
hold on
plot(t1,eps1);
plot(t2,eps2);
plot(t3,eps3);
title('Erreur')
lg = legend('Euler (h = 0.1)','Euler (h = 0.05)','Runge-Kutta 2 (h = 0.05, beta = 1)')

