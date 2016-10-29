function MyFilter(img,thre,type)
    function res=myMeanFilter(aliged_img,align)
        result=aligned_img;
        %for every view block, set the mean number as its value
        for cr=align+1:im_height+align
            for cc=align+1:im_width+align
                viewi_begin=cr-align;
                viewi_end=cr+align;
                viewj_begin=cc-align;
                viewj_end=cc+align;
                temp=aligned_img(viewi_begin:viewi_end,viewj_begin:viewj_end);
                result(cr,cc)=mean(mean(temp));
            end
        end
        %cut the margin
        res=result(align+1:align+im_height,align+1:align+im_width);
    end
    function res=myGaussFilter(aligned_img,align)
        %input align size and sigma, return a Gauss matrix
        function h=gaussMatrix(align,sigma)
        [x,y]=meshgrid(-align:align,-align:align);
        arg=-(x.*x+y.*y)/(2*sigma*sigma);
        h=exp(arg);
        h(h<eps*max(h(:)))=0;
        sumh=sum(h(:));
        if sumh~=0
            h=h/sumh;
        end
        end
        g=gaussMatrix(align,1);
        result=aligned_img;
        for cr=align+1:im_height+align
            for cc=align+1:im_width+align
                viewi_begin=cr-align;
                viewi_end=cr+align;
                viewj_begin=cc-align;
                viewj_end=cc+align;
                temp=single(aligned_img(viewi_begin:viewi_end,viewj_begin:viewj_end));
                %multiply with Gauss weight matrix
                result(cr,cc)=sum(sum(g.*temp));
            end
        end
        %cut the margin
        res=result(align+1:align+im_height,align+1:align+im_width);
    end
    function res=myMedianFilter(aligned_img,align)
        result=aligned_img;
        for cr=align+1:im_height+align
            for cc=align+1:im_width+align
                viewi_begin=cr-align;
                viewi_end=cr+align;
                viewj_begin=cc-align;
                viewj_end=cc+align;
                temp=aligned_img(viewi_begin:viewi_end,viewj_begin:viewj_end);
                %get the median of the matrix
                result(cr,cc)=median(median(temp));
            end
        end
        %cut the margin
        res=result(align+1:align+im_height,align+1:align+im_width);
    end

subplot(211);
imshow(img,[]);
title('Original image');
[im_height,im_width]=size(img);
%get the align size of the image
align=(thre-1)/2;
%extent the image according to align
aligned_img=padarray(img,[align align],'replicate','both');

if type==0
    res=myMeanFilter(aligned_img,align);
    subplot(212);
    imshow(res,[]);
    title('Mean filter');
elseif type==1
    res=myGaussFilter(aligned_img,align);
    subplot(212);
    imshow(res,[]);
    title('Gauss filter');
elseif type==2
    res=myMedianFilter(aligned_img,align);
    subplot(212);
    imshow(res,[]);
    title('Median filter');
end
end