clear variables;
close all;

% Initialisation de l'intervalle temporel (en ua)
tmin=0;tmax=2;

% parametres du modele keplerien
a=1;
T=1;
GM = 4* pi^2 *T^2 /a^3;

% conditions initiales
x0=0.5*a;
y0=0;
vx0=0;
vy0=11.5;

% second membre de l'equ. diff. (x'',y'')=(vx',vy')=(f(t,x,y),g(t,x,y))
f = @(t,x,y)(-GM * x ./ ((x.^2 + y.^2).^1.5));
g = @(t,x,y)(-GM * y ./ ((x.^2 + y.^2).^1.5));

% pas temporel
h=0.01;

switch 3  %%Choix du modele d'analyse
    case 1 % methode d'Euler
    [X,Y,t] = fct_Euler_Kepler(x0,y0,vx0,vy0,tmin,tmax,h,f,g);

    case 2 % methode RK4
    [X,Y,t] = fct_RK4_2D_Kepler(x0,y0,vx0,vy0,tmin,tmax,h,f,g);

    case 3 % methode Euler-Richardson
    [X,Y,t]= fct_Euler_Richardson(x0,y0,vx0,vy0,tmin,tmax,h,f,g,0.01);
    T_total=t(end);
end

%%Affichage des resultats
figure(1);
xmin=-3*a; xmax=a;
ymin=-1.5*a; ymax=1.5*a;
tic;
for k=1:65:length(t)
x= X * a;
y= Y * a;
plot([0,x],[0,y],'Marker','o','MarkerFacecolor','r','MarkerSize',10);
axis('equal');
axis(1.1*[xmin,xmax,ymin,ymax]);
grid 'on';
t1=title('Mouvement de la planete P(x(t),(y(t))');
xlabel('x(t)')
ylabel('y(t)')
set(t1,'interpreter','latex');
end
cputime=toc;
fprintf('Duree de la simulation numerique : %1.2f\n',cputime);