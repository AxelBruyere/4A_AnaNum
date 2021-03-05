% Exercice 1 - TP2
clc;
clear variables;
close all;

% fonction f définie par y'=f(t,y)
f=@(t,y)(2*t*y+3*t-1)/(1+t.^2);

% initialisation
tmin=0;
tmax=2;
h=0.01;               % pas de calcul
t=tmin:h:tmax;
y=zeros(4,length(t));   % 4 lignes : l ligne par méthode
y(:,1)= 1;
beta=0.5;               % paramètre de la méthode de Runge-Kutta d’ordre 2

for k=1:length(t)-1
    % Euler explicite
    y(1,k+1)= y(1,k) + h*f(t,y(1,k));
    
    % Euler implicite
    y(2,k+1) = ((1+(t+h).^2) * y(2,k) + h * (3*(t+h)-1))/(1+(t+h).^2-2*h*(t+h));
    
    % Runge-Kutta d'ordre 2 (3 lignes de code)
    f1=f(t,y(3,k));
    f2=f(t+h/(2*beta),y(3,k))+h/(2*beta)*f(t,y(3,k));
    y(3,k+1) = y(3,k) + h*((1-beta)*f1+beta*f2);
    
    % Runge-Kutta d'ordre 4 (5 lignes de code)
    k1 = f(t,y(4,k));
    k2 = f(t+h/2,y(4,k)+h/2*k1);
    k3 = f(t+h/2,y(4,k)+h/2*k2);
    k4 = f(t + h,y(4,k)+h*k3);
    y(4,k+1) = y(4,k) + h/6 * (k1 + 2*k2 + 2*k3 + k4);

end

% affichage
figure(1);
hold on;
plot(t,y(1,:),'c');
plot(t,y(2,:),'m');
plot(t,y(3,:),'r');
plot(t,y(4,:),'b');
lg=legend('Euler explicite','Euler implicite','RK2','RK4');

