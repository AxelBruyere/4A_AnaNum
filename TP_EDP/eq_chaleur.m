clear
close all
clc

%%Equation de la chaleur

%Espace
L=1;
h=0.05;
x=0:h:L;
n=length(x);

%Temps
tmax=0.13;
tau=0.00124;
t=0:tau:tmax;
m=length(t);

%Matrice M
r = tau/(h^2);
M = diag(r*ones(1,n-1),1) + diag((1-2*r)*ones(1,n)) + diag(r*ones(1,n-1),-1);

%Condition initiale (F⁰=G)
G = ones(n,1);
for j=1:n
    G(j) = 1-abs(2*x(j)/L-1);
    %G(j) = 1-abs(2*x(j)^2/L-1);
end
figure(1)
plot(x,G);
hold on;

%Résolution équation de la chaleur
F = G; %init
for i=1:m
    F = M * F;
    F(1) = 0;
    F(n) = 0;
    if mod(i+5,10) == 0
        plot(x,F);
    end
end




