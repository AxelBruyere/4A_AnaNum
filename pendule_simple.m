clear variables;
close all;
clc;
% paramètres physiques

m=0.7;                %masse de la bille (kg)
r=0.035;              %rayon de la bille (m)
eta=0.000018;         %coeff. de viscosite de l'air à 20°C (kg.m^-1.s^-1)
gamma=1000 * 6*pi*r*eta/m;   %frottements (s^-1)
gr=9.8;               %accéleration de la pesanteur (m.s^-2)
l=2;                  %longueur du fil (m)
omega=sqrt(gr/l);     %fréquence propre (rad.s^-1)
T0=2*pi/omega;        %(pseudo-)période du pendule (s)

% autres paramètres

tmin=0;     % instant initial
tmax=4*T0;  % instant final
pas=0.001;  % pas de calcul
fprintf('Durée de l''expérience physique : %1.2f\n',tmax-tmin);


% fonctions Y'=F(Y) avec ici Y=(theta,z) et F(Y)=(f,g)
f=@(t,theta,z)(z);
g=@(t,theta,z)(-gamma * z - omega.*omega * sin(theta));

% conditions initiales

theta0=2*pi/3;  % angle initial (rad)
thetap0=0;      % vitesse angulaire initiale (rad/s)

% choix de la méthode
method=1;
    % 1 : Euler
    % 2 : Runge-Kutta ordre 2
    % 3 : Runge-Kutta ordre 4

% calculs numériques
switch method
case 1
[theta,z,t]=fct_Euler_2D(theta0,thetap0,tmin,tmax,pas,f,g);
strTitle='Euler';
case 2
beta=1;
[theta,z,t]=fct_RK2(theta0,thetap0,tmin,tmax,pas,beta,f,g);
strTitle='Runge-Kutta ordre 2';
case 3
[theta,z,t]=fct_RK4_2D(theta0,thetap0,tmin,tmax,pas,f,g);
strTitle='Runge-Kutta ordre 4';
end
% énergies du pendule
Ec = 0.5 * m * l * l * z .* z;       % énergie cinétique
Ep = m * gr * l * (1 - cos(theta));   % énergie potentielle
E = Ec + Ep;                         % énergie totale



% affichage des résultats
figure(1);
xmin=-l;xmax=l;
ymin=-l;ymax=l;
tic;
for k=1:65:length(theta)
% régler le pas de sorte à obtenir un mouvement réaliste
% espace réel
subplot(131);
x=sin(theta(k)) * l;
y=- cos(theta(k)) * l;
plot([0,x],[0,y],'Marker','o','MarkerFacecolor','r','MarkerSize',10);
axis('equal');
axis(1.1*[xmin,xmax,ymin,ymax]);
grid 'on';
t1=title(strTitle);
set(t1,'interpreter','latex');








% espace des phases
subplot(132);hold on;
t3=title('Espace des phases');
set(t3,'interpreter','latex');
h=plot(theta(k),z(k),'ok');
set(h,'MarkerSize',2);
axis(1.1*[min(theta),max(theta),min(z),max(z)]);
grid on;
% énergies
subplot(133);hold on;
t2=title('Energies');
set(t2,'interpreter','latex');
h=plot(t(k),Ec(k),'ob',t(k),Ep(k),'om',t(k),E(k),'or');
set(h,'MarkerSize',2);
axis(1.1*[tmin,tmax,min(Ec),max(Ec)]);
pause(0.0001);
end
cputime=toc;
fprintf('Durée de la simulation numérique : %1.2f\n',cputime);
% labels des axes de la figure du portrait de phase
subplot(132);
l1=xlabel('$\theta(t)$','interpreter','latex');
set(l1,'FontSize',14);
l2=ylabel('$\theta''(t)$','interpreter','latex');
set(l2,'FontSize',14);
% légende de la figure des énergies
subplot(133);
g1=legend('Energie cinetique','Energie potentielle','Energie totale');
legend('boxoff');
set(g1,'interpreter','latex');
xlabel('temps','interpreter','latex');