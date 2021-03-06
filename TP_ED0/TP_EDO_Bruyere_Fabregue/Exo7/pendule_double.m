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

% autres parametres

tmin=0;     % instant initial
tmax=20;  % instant final
pas=0.00001;  % pas de calcul
seuil = 0.00002; %seuil d'erreur d'Euler-Richardson
nom_video = 'seq_video3.avi';
fprintf('Duree de l''experience physique : %1.2f\n',tmax-tmin);

% fonctions Y'=F(Y) avec ici Y=(theta,z) et F(Y)=(f,g)
f1=@(t,theta1,theta2,z1,z2)(z1);
f2=@(t,theta1,theta2,z1,z2)(z2);
f3=@(t,theta1,theta2,z1,z2)(-(gr*(2*m1+m2)*sin(theta1)+m2*(gr*sin(theta1-2*theta2)+2*(l2*z2^2+l1*z1^2*cos(theta1-theta2))*sin(theta1-theta2)))/(2*l1*(m1+m2*(sin(theta1-theta2))^2)));
f4=@(t,theta1,theta2,z1,z2)(sin(theta1-theta2)*((m1+m2)*(l1*z1^2+gr*cos(theta1)+l2*m2*z2^2*cos(theta1-theta2)))/(l2*(m1+m2*(sin(theta1-theta2))^2)));

% conditions initiales
%Pendule 1
theta01=2*pi/3;  % angle initial (rad)
thetap01=0;      % vitesse angulaire initiale (rad/s)
theta02=2*pi/3;  % angle initial (rad)
thetap02=0;      % vitesse angulaire initiale (rad/s)
%Pendule 2
theta03=2*pi/3;  % angle initial (rad)
thetap03=0;      % vitesse angulaire initiale (rad/s)
theta04=2*pi/3+0.001;  % angle initial (rad)
thetap04=0;      % vitesse angulaire initiale (rad/s)

%Calculs numeriques
switch 1 %Choix de la méthode de résolution
    %1 pour RK4, 2 pour Euler-Richardson
    case 1
        [theta1,theta2,z1,z2,t]=fct_RK4_4D2...
            (theta01,theta02,thetap01,thetap02,tmin,tmax,pas,f1,f2,f3,f4);
        [theta3,theta4,z3,z4,t]=fct_RK4_4D2...
            (theta03,theta04,thetap03,thetap04,tmin,tmax,pas,f1,f2,f3,f4);
        t_pause = 0.000001;
        strTitle='Double pendule avec la méthode de Runge-Kutta4';
    case 2
        [theta1,theta2,z1,z2,t] = fct_Euler_Richardson_double_pendule ...
            (theta01,theta02,thetap01,thetap02,tmin,tmax,pas,f3,f4,seuil);
        t_pause = 0.005;
        strTitle ='Double pendule avec la méthode d''Euler-Richardson';
end

% affichage des resultats
figure(1);
xmin=-(l1+l2);xmax=(l1+l2);
ymin=-(l1+l2);ymax=(l1+l2);
tic;
v=VideoWriter(nom_video);
open(v);
drawnow;
for k=1:6500:length(theta1)
x1=sin(theta1(k)) * l1;
y1= -cos(theta1(k)) * l1;
x2=x1+sin(theta2(k)) * l2;
y2=y1 -cos(theta2(k)) * l2;
% x3=sin(theta3(k)) * l1;
% y3= -cos(theta3(k)) * l1;
% x4=x3+sin(theta4(k)) * l2;
% y4=y3 -cos(theta4(k)) * l2;
plotx1 = [0,x1,x2];
%plotx2 = [0,x3,x4];
ploty1 = [0,y1,y2];
%ploty2 = [0,y3,y4];
figure(1)
plot(plotx1,ploty1,'Marker','o','MarkerFacecolor','b','MarkerSize',10);
axis('equal');
axis(1.1*[xmin,xmax,ymin,ymax]);
grid 'on';
t1=title(strTitle);
pause(t_pause)
thisframe=getframe(gcf);
writeVideo(v,thisframe);

end

close(v);