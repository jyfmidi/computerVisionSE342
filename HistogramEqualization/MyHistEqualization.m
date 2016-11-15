function MyHistEqualization(img)
%get original histogram data
oriHist=imhist(img,256);
total=sum(oriHist);
sumHist=zeros(256,1);
alignedHist=zeros(256,1);

%the following process is try to get cumsum histogram
sumHist(1)=oriHist(1)/total;
for i=2:256
    sumHist(i)=sumHist(i-1)+oriHist(i)/total;
end
%transfer to integers
for i=1:256
    alignedHist(i)=ceil(256*sumHist(i));
end

[im_height,im_width]=size(img);
result=zeros(im_height,im_width);
for i=1:im_height
    for j=1:im_width
        %deal with invalid position
        if img(i,j)==0
            img(i,j)=1;
        end
        %map result with aligned histogram
        result(i,j)=uint8(alignedHist(img(i,j)));
    end
end
subplot(211);
imshow(img);
title('Original image');
subplot(212);
imshow(mat2gray(result));
title('Equalized image');

    
