clc;clear variables;close all;

% espace
Lx=15;hx=0.1;x=0:hx:Lx;nx=length(x);
Ly=15;hy=0.1;y=0:hy:Ly;ny=length(y);
% temps
T=2;tau=0.002;t=0:tau:T;m=length(t);
% celerité de l'onde
c=7;
% coefficients rx et ry
rx=(c*tau/hx)^2;
ry=(c*tau/hy)^2;
% conditions CFL (non explicitement utilisées, juste pour vérification)
CFL_x=hx/(c*tau);
CFL_y=hy/(c*tau);
% indices correspondant à la position de la source
i_s=floor(nx/3);
j_s=floor(ny/2);
% fréquence de la source
nu=8;
% condition initiale (le milieu est au repos à l'instant initial)
f=zeros(nx,ny,m);

% % présence ou pas d'une fente
% slit=2;
% % 0 -> pas de fente, 1 -> 1 ouverture,2 -> 2 ouvertures
% % indices correspondant à l’épaisseur de la fente
% %%%%%%%%%%%j_slit=[-3*lx/4,3*Lx/4,Lx/2];
% % indices correspondant à la longueur de la fente
% switch slit
% case 1 % l ouverture
% 
% case 2 % 2 ouvertures
% j_slit=[30:1:36,100:1:106];
% end

for k = 2:m-1
    for i = 2:nx-1
        for j = 2:ny-1
            f(i,j,k+1)=2*f(i,j,k)-f(i,j,k-1)+rx*(f(i+1,j,k)-2*f(i,j,k)+f(i-1,j,k))+ry*(f(i,j+1,k)-2*f(i,j,k)+f(i,j-1,k));
            
            if(i==i_s&&j==j_s)
                f(i,j,k+1)=2*f(i,j,k)-f(i,j,k-1)+rx*(f(i+1,j,k)-2*f(i,j,k)+f(i-1,j,k))+ry*(f(i,j+1,k)-2*f(i,j,k)+f(i,j-1,k))+(tau^2)*sin(2*pi*nu*k*tau);
            end
            
%             if ismember(j,j_slit) && i == 1
%                 f(i_slit,j_slit,k)=0;
%             end
        end
    end
    

clear; close; clc;
%%Exercice 4

% espace
Lx=15; hx=0.1; x=0:hx:Lx; nx=length(x);
Ly=15; hy=0.1; y=0:hy:Ly; ny=length(y);
% temps
T=2; tau=0.002; t=0:tau:T; m=length(t);
% celerite de l'onde
c=7;
% coefficients rx et ry
rx = (c*tau/hx)^2;
ry = (c*tau/hy)^2;
% conditions CFL (non explicitement utilises, juste pour verification)
CFL_x = hx/(c*tau);
CFL_y = hy/(c*tau);
% indices correspondant a la position de la source
i_s=floor(nx/3);
j_s=floor(ny/2);
% frequence de la source
nu=8;
% condition initiale (le milieu est au repos a l'instant initial)
f=zeros(nx,ny,m);

% presence ou pas d'une fente
slit=2;
% 0 -> pas de fente, 1 -> 1 ouverture, 2 -> 2 ouvertures
% indices correspondant a l'epaisseur de la fente
i_slit = [100,101];
% indices correspondant a la longueur de la fente
switch slit
case 1 % l ouverture
    j_slit = [73,74,75,76,77,78];
case 2 % 2 ouvertures
    j_slit = [48,49,50,51,52,53,100,101,102,103,104,105];
end

%Boucle iterative
for k=2:m-1
for i=2:nx-1
for j=2:ny-1
    f(i,j,k+1) = 2*f(i,j,k) - f(i,j,k-1) + ...
        rx * (f(i+1,j,k)-2*f(i,j,k)+f(i-1,j,k)) + ...
        ry * (f(i,j+1,k)-2*f(i,j,k)+f(i,j-1,k)) ;    
end
end
    f(i_s,j_s,k+1) = f(i_s,j_s,k+1) + tau^2 * sin(2*pi*nu*k*tau);
    f(i_slit,setdiff(1:end,j_slit),k+1) = 0;

end


figure(1);
f=f/max(max(max(f)));
[X,Y]=meshgrid(y,x);

v=VideoWriter('seq_video.avi');
open(v);
drawnow;


for k=1:8:m-1
surf(X,Y,f(:,:,k));
xlabel('$y$','interpreter','latex');
ylabel('$x$','interpreter','latex');
zlb=zlabel('$f(x,y,t)$','interpreter','latex');zlb.Rotation=0;
view(-30,50);
caxis([-1,1]); % échelle des couleurs
zlim([-1,1]);
pause(0.001);
thisframe=getframe(gcf);
writeVideo(v,thisframe);
caxis([-1,1]); % Echelle des couleurs
zlim([-1,1]);
pause(0.001);
end



close(v);


end