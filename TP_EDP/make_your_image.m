function I=make_your_image()
n=100;
w1=floor(n/3);
w2=floor(n/2);
bw=floor(n/50);
vp=255;
imagemat=vp*ones(n,n);
imagemat(:,w2-bw:w2+bw)=0;
imagemat(w1-bw:w1+bw,:)=0;
imagemat(2*w1-bw:2*w1+bw,:)=0;
<<<<<<< HEAD
I=double(imagemat);
end
=======
I=double(imagemat);
>>>>>>> 2c4df9a9980452bbc169c067d8d1237debb901ec
