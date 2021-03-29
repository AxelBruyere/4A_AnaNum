clear; close; clc;
%%Exercice 4

% espace
Lx=15; hx=0.1; x=0:hx:Lx; nx=length(x);
Ly=15; hy=0.1; y=0:hy:Ly; ny=length(y);
% temps
T=2; tau=0.002; t=0:tau:T; m=length(t);
% celerité de l'onde
c=7;
% coefficients rx et ry
rx = (c*tau/hx)^2;
ry = (c*tau/hy)^2;
% conditions CFL (non explicitement utilisées, juste pour vérification)
CFL_x = hx/(c*tau);
CFL_y = hy/(c*tau);
% indices correspondant à la position de la source
i_s=floor(nx/3);
j_s=floor(ny/2);
% fréquence de la source
nu=8;
% condition initiale (le milieu est au repos à l'instant initial)
f=zeros(nx,ny,m);

% présence ou pas d'une fente
slit=1;
% 0 -> pas de fente, 1 -> 1 ouverture, 2 -> 2 ouvertures
% indices correspondant à l’épaisseur de la fente
i_slit = [100,101];
% indices correspondant à la longueur de la fente
switch slit
case 1 % l ouverture
    j_slit = [73,74,75,76,77,78];
case 2 % 2 ouvertures
    j_slit = [30,31,32,33,34,35,100,101,102,103,104,105];
end

%Boucle itérative
for k=2:m-1
for i=2:nx-1
for j=2:ny-1
    f(i,j,k+1) = 2*f(i,j,k) - f(i,j,k-1) + ...
        rx * (f(i+1,j,k)-2*f(i,j,k)+f(i-1,j,k)) + ...
        ry * (f(i,j+1,k)-2*f(i,j,k)+f(i,j-1,k)) ;
    if ismember(j,j_slit) && ismember(i,i_slit)
        f(i,j,k+1) = 0;
    end
    if i==i_s && j==j_s
       f(i,j,k+1) = f(i,j,k+1) + tau^2 * sin(2*pi*nu*k*tau);    
    end
end
end
end


figure(1);
f=f/max(max(max(f)));
[X,Y]=meshgrid(y,x);
for k=1:m-1
surf(X,Y,f(:,:,k));
xlabel('$y$','interpreter','latex');
ylabel('$x$','interpreter','latex');
zlb=zlabel('$f(x,y,t)$','interpreter','latex');zlb.Rotation=0;
view(-30,50);
caxis([-1,1]); % échelle des couleurs
zlim([-1,1]);
pause(0.001);
end



