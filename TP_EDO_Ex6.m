clear variables;
close all;

tmin=0;
tmax=0.5;

% paramètres du modèle képlerien
a=1;
T=1;
GM = 4* pi^2 *T^2 /a^3;


% conditions initiales
x0=0.5*a;
y0=0;
vx0=0;
vy0=11.5;

% second membre de l'équ. diff. (x'',y'')=(vx',vy')=(f(t,x,y),g(t,x,y))
f = @(t,x,y)(-GM * x ./ ((x.^2 + y.^2).^1.5));
g = @(t,x,y)(-GM * y ./ ((x.^2 + y.^2).^1.5));

% pas temporel
h=0.01;

% 1. méthode d'Euler
[xEuler,yEuler,t]=fct_Euler_Kepler(x0,y0,vx0,vy0,tmin,tmax,h,f,g);

% 2. méthode RK2



% trajectoires proies-prédateurs
% 1. méthode de d'Euler
%quiver(xEuler,yEuler,f(t,xEuler,yEuler),g(t,xEuler,yEuler));

% affichage des résultats
figure(1);
xmin=-a;xmax=a;
ymin=-a;ymax=a;
tic;
for k=1:65:length(t)
% régler le pas de sorte à obtenir un mouvement réaliste
% espace réel
%subplot(131);
x= xEuler * a;
y= yEuler * a;
plot([0,x],[0,y],'Marker','o','MarkerFacecolor','r','MarkerSize',10);
axis('equal');
axis(1.1*[xmin,xmax,ymin,ymax]);
grid 'on';
t1=title('titre');
set(t1,'interpreter','latex');
end
cputime=toc;
fprintf('Durée de la simulation numérique : %1.2f\n',cputime);