clear
close all
clc

%%Equation d'onde

%Espace
L=5;
h=0.02;
x=0:h:L;
n=length(x);

%Temps
tmax=10;
tau=0.005;
t=0:tau:tmax;
m=length(t);

%Constante c
c = 1;

%Matrice M
r = (c*tau/h)^2;
M = diag(r*ones(1,n-1),1) + diag(2*(1-r)*ones(1,n)) + diag(r*ones(1,n-1),-1);

%Condition initiale 
G = ones(n,1);
for j=1:n
    G(j) = 1/sqrt(2*pi) * exp(-5*(x(j)-L/2)^2);
end
K= zeros(n,1);

% figure(1)
% hold on;
% plot(x,G);
% plot(x,K);

%Prop. de l'onde
F1 = G;
F2 = G + tau*K;

%Résolution équation d'onde
figure(2)

F = G; %init
for i=1:m
    F = M * F2 - F1;
    F(1) = 0;
    F(n) = 0;
    plot(x,F);
    pause(0.001);
    F1 = F2;
    F2 = F;
end

%%Paquet d'ondes
% g(x,t) = sin(2*pi*nu1*t)* sin(2*pi*nu2*t) * porte()
% avec nu1>>nu2 et porte centrée en L/2 de largeur |x1-x2|
