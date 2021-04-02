clc;
clear variables;
close all;


%%% Init variables
%Espace
L = 5;
h = 0.02;
x = 0:h:L;
n = length(x);
%Temps
tmax = 10; 
tau = 0.005;
t = 0:tau:tmax;
m = length(t);

c = 1;
%%%

%Matrice M
r = (c*tau/h)^2;
M = spdiags([r*ones(n,1) 2 * (ones(n,1)-r*ones(n,1)) r*ones(n,1)],-1:1,n,n);


K = zeros(n,1);

mu = L/2;
sigma = 0.5;
F1 = (exp(-0.5*((x-mu)/sigma).^ 2)/(sigma*sqrt(2*pi)))';
F2 = F1 + tau * K;
for i = 2:m
    %Résolution
    F_int = F2;
    F2 = M * F2 - F1;
    F1 = F_int;
    %Cond init
    F2(1) = 0;
    F2(length(F2)) = 0;
    
    plot(x,F2)
    axis([0 L,-0.8,0.8])
    pause(0.001)
end





