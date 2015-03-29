 function out_emd_img=embed1(img,sec_msg,bit)
%This function embeds message into cover image.....

    
[r c p]=size(img); 
len=length(sec_msg);
j1=1;
count=1;

if(length(sec_msg)<=(r*c)) 
    for i=1:r
        for j=1:c
                if(count<=len)
                    img(i,j)=bitset(img(i,j),bit,sec_msg(1,j1));
                    j1=j1+1;
                    count=count+1;
                end
        end
    end
out_emd_img=img;% define output
else
    disp('Opeartion is Invalid')
end