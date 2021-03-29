function [X_er,Y_er,t] = fct_Euler_Richardson(x0,y0,vx0,vy0,tmin,tmax,h,f,g,seuil)

%%Initialisation
t = tmin;
Y = [x0;y0;vx0;vy0];

%%Fonction f(y)=[x',y',x'',y'']
fY = @(Yi) [Yi(3);Yi(4);f(1,Yi(1),Yi(2));g(1,Yi(1),Yi(2))];

%%Debut boucle
i=1;
while t(i)<tmax     %Arret quand duree max atteinte
    K = fY(Y(:,i));     %Calcul de K
    Kp = fY(Y(:,i)+0.5*h*K);   %Calcul de K'
    erreur = norm(K-Kp)*h/2;
    alpha = erreur/seuil;
    
    if alpha>1  %on reitere les calculs precedents avec
        h = 0.9*h/sqrt(alpha); %la nouvelle valeur de h
    else
        Y = [Y, Y(:,i)+h*Kp];
        h = 0.9*h/sqrt(alpha);
        t = [t, t(i)+h];
        i=i+1;
    end
end
X_er = Y(1,:);
Y_er = Y(2,:);
