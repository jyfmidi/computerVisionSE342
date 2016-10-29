f=rgb2gray(imread('filters.png'));
threshold=5;
MyFilter(f,threshold,0);
figure;
MyFilter(f,threshold,1);
figure;
MyFilter(f,threshold,2);
