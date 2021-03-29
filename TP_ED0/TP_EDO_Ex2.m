clear variables;
close all;

tmin=0;tmax=1;
f=@(t,y)(???);
yExact=@(t)(???);
    
% condition initiale
y0=-1;

%% question 1
% 1. m�thode d'Euler (h=0.1)
h=0.1;
[yEuler1,t1]=fct_Euler(y0,tmin,tmax,h,f);
eps1=abs(yEuler1-yExact(t1));   % erreur
plot(t1,eps1);

% 2. m�thode d'Euler (h=0.05)
h=0.05;
[yEuler2,t2]=fct_Euler(y0,tmin,tmax,h,f);
eps2=abs(yEuler2-yExact(t2));   % erreur

% 3. m�thode RK2 (h=0.1 et beta=1)
h=0.1;beta=1;
[yRK,t3]=fct_RK2(y0,tmin,tmax,h,beta,f);
eps3=abs(yRK-yExact(t3));       % erreur