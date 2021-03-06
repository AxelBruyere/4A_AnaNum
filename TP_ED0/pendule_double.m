clear variables;
close all;
clc;
% parametres physiques

m1=0.7;%masse de la bille 1 (kg)
m2=0.7;%masse de la bille 2 (kg)
r1=0.035;%rayon de la bille (m)
r2=0.035;%rayon de la bille 2
gr=9.8;%acceleration de la pesanteur (m.s^-2)
l1=1;%longueur du fil 1 (m)
l2=2;%longueur du fil 2 (m)

% autres paramètres

tmin=0;     % instant initial
tmax=20;  % instant final
pas=0.0001;  % pas de calcul
fprintf('Durée de l''expérience physique : %1.2f\n',tmax-tmin);

% fonctions Y'=F(Y) avec ici Y=(theta,z) et F(Y)=(f,g)
f1=@(t,theta1,theta2,z1,z2)(z1);
f2=@(t,theta1,theta2,z1,z2)(z2);
f3=@(t,theta1,theta2,z1,z2)(-(gr*(2*m1+m2)*sin(theta1)+m2*(gr*sin(theta1-2*theta2)+2*(l2*z2^2+l1*z1^2*cos(theta1-theta2))*sin(theta1-theta2)))/(2*l1*(m1+m2*(sin(theta1-theta2))^2)));
f4=@(t,theta1,theta2,z1,z2)(sin(theta1-theta2)*((m1+m2)*(l1*z1^2+gr*cos(theta1)+l2*m2*z2^2*cos(theta1-theta2)))/(l2*(m1+m2*(sin(theta1-theta2))^2)));

% conditions initiales

theta01=2*pi/3;  % angle initial (rad)
thetap01=0;      % vitesse angulaire initiale (rad/s)
theta02=2*pi/3;  % angle initial (rad)
thetap02=0;      % vitesse angulaire initiale (rad/s)

%Calculs numériques
[theta1,theta2,z1,z2,t]=fct_RK4_4D(theta01,theta02,thetap01,thetap02,tmin,tmax,pas,f1,f2,f3,f4);

% affichage des résultats
figure(1);
xmin=-(l1+l2);xmax=(l1+l2);
ymin=-(l1+l2);ymax=(l1+l2);
tic;
v=VideoWriter('seq_video2.avi');
open(v);
drawnow;
for k=1:300:length(theta1)
x1=sin(theta1(k)) * l1;
y1= -cos(theta1(k)) * l1;
x2=x1+sin(theta2(k)) * l2;
y2=y1 -cos(theta2(k)) * l2;
plot([0,x1,x2],[0,y1,y2],'Marker','o','MarkerFacecolor','b','MarkerSize',10);
axis('equal');
axis(1.1*[xmin,xmax,ymin,ymax]);
grid 'on';
title('Double pendule par la méthode de Runge-Kutta 4');
pause(0.001)
thisframe=getframe(gcf);
writeVideo(v,thisframe);

end
close(v);
