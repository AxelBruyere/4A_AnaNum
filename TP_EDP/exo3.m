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


