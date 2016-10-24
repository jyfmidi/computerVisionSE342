img=imread('lena-binary.bmp');
%se=imread('se_circle.bmp');
%se=rgb2gray(se);
se=[0 0 0;0 0 0;0 0 0];
se=uint8(se);
MyMorphology(img,se,0);
figure;
MyMorphology(img,se,1);