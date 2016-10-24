%main algorithm
%input: image scale
%output: the optimal threshold and the histogram
function [thre,freq]=Otsu(img)
L=256;
%count the pixils lie in every step of the gray scale 
counts=imhist(img,L);
%cumsum of the counts
w=cumsum(counts);
%histogram
ut=counts.*(1:L)';
u=cumsum(ut);
freq=ut;

maxV=0;
level=0;

for t=1:L
    u0=u(t,1)/w(t,1);
    u1=(u(L,1)-u(t,1))/(w(L,1)-w(t,1));
    w0=w(t,1);
    w1=w(L,1)-w0;
    %main Otsu formula 
    g=w0.*w1.*(u1-u0).^2;
    %collect the largest point, value and location
    if(g>maxV)
        maxV=g;
        level=t;
    end
end
thre=level;


