%input: 2-dimension image matrix
%       img and se need to be transfered into 2-d grayscale images
%       opr=0,dilation
%       opr=otherwise,erosion
%       
function MyMorphology(img,se,opr)
%read image
se=uint8(se);
[im_height,im_width]=size(img);
[se_height,se_width]=size(se);
%center point
halfheight=floor(se_height/2);
halfwidth=floor(se_width/2);
%deal with situation when se on the edges
[edge_align]=floor((size(se)+1)/2);
%show original
subplot(211);
imshow(img,[]);
title('Original image');
    %dilation subfunction
    function dila=myDilation(img,se)
        aligned_img=padarray(img,edge_align,0,'both');
        aligned_img=uint8(aligned_img);
        result=zeros(im_height,im_width);
        %move view matrix accordingly with center point
        for cr=edge_align(1)+1:edge_align(1)+im_height
            for cc=edge_align(2)+1:edge_align(2)+im_width
                sei_begin=cr-edge_align(1);
                sei_end=cr+halfheight-1;
                sej_begin=cc-edge_align(2);
                sej_end=cc+halfwidth-1;
                %get the maximum number of the view matrix
                result(cr-edge_align(1),cc-edge_align(2))=max(max(se+aligned_img(sei_begin:sei_end,sej_begin:sej_end)));
            end
        end
        dila=result;
    end
    %erosion subfunction
    function eros=myErosion(img,se)
        aligned_img=padarray(img,edge_align,0,'both');
        aligned_img=uint8(aligned_img);
        result=zeros(im_height,im_width);
        for cr=edge_align(1)+1:edge_align(1)+im_height
            for cc=edge_align(2)+1:edge_align(2)+im_width
                sei_begin=cr-edge_align(1);
                sei_end=cr+halfheight-1;
                sej_begin=cc-edge_align(2);
                sej_end=cc+halfwidth-1;
                result(cr-edge_align(1),cc-edge_align(2))=min(min(aligned_img(sei_begin:sei_end,sej_begin:sej_end)-se));
            end
        end
        eros=result;
    end
%print accordingly
if opr==0
    dil=myDilation(img,se);
    subplot(212);
    imshow(dil,[]);
    title('Dilated image');
else
    ero=myErosion(img,se);
    subplot(212);
    imshow(ero,[]);
    title('Eroded image');
end
end