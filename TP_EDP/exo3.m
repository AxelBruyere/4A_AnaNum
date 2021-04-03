<<<<<<< HEAD
clc;clear variables;close all;

%Récupération de l'image et de ses dimensions
choix = 1;
switch choix
    case 1
       image = make_your_image();
       
    case 2
        image = imread('Lena.jpg');
        image = double(image(:,:,1));
end 
[n,p] = size(image);

%Bruitage de l'image
noise = 7 * randn(n,p);
u0 = image + noise;

tmax = 2; %"Temps" maximum
tau = 0.2; %Pas de discrétisation
t = 0:tau:tmax; %Vecteur de temps

%Discrétisation
nablaS = @(u,i,j) u(i+1,j)-u(i,j);
nablaN = @(u,i,j) u(i-1,j)-u(i,j);
nablaE = @(u,i,j) u(i,j+1)-u(i,j);
nablaW = @(u,i,j) u(i,j-1)-u(i,j);

%Définition des coeffs de diffusion

alpha = 5;
D_gauss = @(u) exp(-u.^2/(2*alpha^2));
D_lorentz = @(u) 1/(1+(u.^2/alpha^2));




u = u0;
u_gauss = u0;
u_lorentz = u0;
for m = 1:tmax/tau
    for i = 2:1:n-1
        for j = 2:1:p-1
    %Equation de la chaleur
    u(i,j) = u(i,j) + tau * (nablaS(u,i,j) + nablaN(u,i,j) + nablaE(u,i,j) + nablaW(u,i,j));
    %Diffusion gaussienne
    u_gauss(i,j) = u_gauss(i,j) + tau * (D_gauss(abs(nablaS(u,i,j)))*nablaS(u,i,j) + D_gauss(abs(nablaN(u,i,j))) * nablaN(u,i,j) + D_gauss(abs(nablaE(u,i,j))) * nablaE(u,i,j) + D_gauss(abs(nablaW(u,i,j))) * nablaW(u,i,j));
    %Diffusion lorentzienne
    u_lorentz(i,j) = u_lorentz(i,j) + tau * (D_lorentz(abs(nablaS(u,i,j)))*nablaS(u,i,j) + D_lorentz(abs(nablaN(u,i,j)))*nablaN(u,i,j) + D_lorentz(abs(nablaE(u,i,j)))*nablaE(u,i,j) + D_lorentz(abs(nablaW(u,i,j)))*nablaW(u,i,j));
        end
    end
end


%Partie affichage
figure(1)
subplot 231
imshow(image,[],'DisplayRange',[min(u0(:)),max(u0(:))])
title('Image d''origine')
subplot 232
imshow(u0,[],'DisplayRange',[min(u0(:)),max(u0(:))])
title('Image bruitée')
subplot 233
imshow(u,[],'DisplayRange',[min(u0(:)),max(u0(:))])
title('Image débruitée avec la méthode de l''équation de la chaleur')
subplot 234
imshow(u_gauss,[],'DisplayRange',[min(u_gauss(:)),max(u_gauss(:))])
title('Image débruitée par le modèle de Perona-Malik, diffusion gaussienne')
subplot 236
imshow(u_lorentz,[],'DisplayRange',[min(u_lorentz(:)),max(u_lorentz(:))])
title('Image débruitée par le modèle de Perona-Malik, diffusion lorentzienne')







=======
%%Exercice 3
clear; close ; clc

image = 1;
switch image
    case 1
        I = make_your_image();
    case 2
        I = imread('Lena.jpg');
        I = double(I(:,:,1));
end

[n,p] = size(I);
noise = 7*randn(n,p);
u0 = I + noise;
Ic = u0;
Ipm = u0;

tmax = 2;  %Temps maximum (~ecart-type max du filtre gaussien)
tau = 0.2;
m_max = floor(tmax/tau);
alpha = 5;

switch 2
    case 1
        D = @(x) exp(-x^2/(2*alpha^2));
    case 2
        D = @(x) 1/(1+(x^2/alpha^2));
end

for m=1:m_max
for i=2:n-1
    for j=2:p-1
        %%Modele eq_chaleur
        nabla_S = Ic(i+1,j)-Ic(i,j);
        nabla_N = Ic(i-1,j)-Ic(i,j);
        nabla_E = Ic(i,j+1)-Ic(i,j);
        nabla_W = Ic(i,j-1)-Ic(i,j);
        Ic(i,j) = Ic(i,j) + tau*(nabla_S + nabla_N + nabla_E + nabla_W);
        %%Modele Perona-Malik 
        nS = Ipm(i+1,j) - Ipm(i,j);
        nN = Ipm(i-1,j) - Ipm(i,j);
        nE = Ipm(i,j+1) - Ipm(i,j);
        nW = Ipm(i,j-1) - Ipm(i,j);
        Ipm(i,j) = Ipm(i,j) + tau*(D(abs(nS))*nS + D(abs(nN))*nN + D(abs(nE))*nE + D(abs(nW))*nW);
    end
end
end

%%Afichage
figure(1)
subplot(221)
imshow(I,'DisplayRange',[min(I(:)),max(I(:))]);
title('Image origine');
subplot(222)
imshow(u0,'DisplayRange',[min(u0(:)),max(u0(:))]);
title('Image bruitee');
subplot(223)
imshow(Ic,'DisplayRange',[min(Ic(:)),max(Ic(:))]);
title('Image chaleur');
subplot(224)
imshow(Ipm,'DisplayRange',[min(Ipm(:)),max(Ipm(:))]);
title('Image Perona-Malik');
>>>>>>> 2c4df9a9980452bbc169c067d8d1237debb901ec


