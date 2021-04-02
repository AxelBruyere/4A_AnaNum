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









