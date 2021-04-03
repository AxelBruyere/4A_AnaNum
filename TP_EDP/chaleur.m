clc;
clear variables;
close all;


%%% Init variables
%Espace
L = 1;
h = 0.05;
x = 0:h:L;
n = length(x);
%Temps
tmax = 0.13; 
tau = 0.00124;
t = 0:tau:tmax;
m = length(t);
%%%


%Matrice M
r = tau/(h*h);
M = spdiags([r*ones(n,1) ones(n,1)-2*r*ones(n,1) r*ones(n,1)],-1:1,n,n);


%Matrice F0
F = 1 - abs(2*x -1)'; %%F(x,0)


plot(x,F)

count = 0;
for i = t
   F = M*F;
   F(1) = 0;
   F(length(F)) = 0;
   count = count + 1;
   if (mod(count,10)==0)
       hold on 
       plot(x,F);
   end
   
end

title('Solution de l''équation de la chaleur')
xlabel('x')
ylabel('Température')

