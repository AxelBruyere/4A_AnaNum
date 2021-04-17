function [theta1,theta2,z1,z2,t] = fct_Euler_Richardson_double_pendule(x0,y0,u0,v0,tmin,tmax,pas,f,g,seuil)

%%Initialisation
t = tmin;
Y = [x0;y0;u0;v0];

%%Fonction f(y)=[x',y',x'',y'']
fY = @(Yi) [Yi(3);Yi(4);f(1,Yi(1),Yi(2),Yi(3),Yi(4));g(1,Yi(1),Yi(2),Yi(3),Yi(4))];

%%Debut boucle
i=1;
while t(i)<tmax     %Arret quand duree max atteinte
    K = fY(Y(:,i));     %Calcul de K
    Kp = fY(Y(:,i)+0.5*pas*K);   %Calcul de K'
    erreur = norm(K-Kp)*pas/2;
    alpha = erreur/seuil;
    
    if alpha>1  %on reitere les calculs precedents avec
        pas = 0.9*pas/sqrt(alpha); %la nouvelle valeur de h
    else
        Y = [Y, Y(:,i)+pas*Kp];
        pas = 0.9*pas/sqrt(alpha);
        t = [t, t(i)+pas];
        i=i+1;
    end
end
theta1 = Y(1,:);
theta2 = Y(2,:);
z1 = Y(3,:);
z2 = Y(4,:);
