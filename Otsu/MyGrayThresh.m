%drawing function
%input: image path, form: path='C:/sss/sss/xx.png'
%       verbose=0,show original,foreground and background
%       verbose=1,show three diagrams above plus histogram
function MyGrayThresh(path,verbose)
%read image
img=imread(path);
gray=rgb2gray(img);
%get parameters through algorithm
th=0;
freq=zeros(1,256);
[th,freq]=Otsu(gray);
%process and prepare diagrams
fore=gray;
back=gray;
[m,n]=size(gray);
for i=1:m
    for j=1:n
        if gray(i,j)>th
            fore(i,j)=0;
            back(i,j)=255;
        else
            fore(i,j)=255;
            back(i,j)=0;
        end
    end
end
%print accordingly
if verbose==0
    subplot(311);
    imshow(gray,[]);
    subplot(312);
    imshow(fore,[]);
    subplot(313);
    imshow(back,[]);
else
    subplot(411);
    imshow(gray,[]);
    subplot(412);
    imshow(fore,[]);
    subplot(413);
    imshow(back,[]);
    subplot(414);
    bar(freq);

end