function [sec_msg,rec_img]=extract(in_img,bit,len)
%This function extract message from stego image.....

        
[r c p]=size(in_img);
f=[];
count=1;
    for i=1:r
        for j=1:c
                if (count<=len)
                    temp(i,j)=bitget(in_img(i,j),bit);
                    f=[f,temp(i,j)];
                    count=count+1;
                end
        end
    end
               

sec_msg=f;
rec_img=in_img;