function [sec_key]=secret_key_generation_txt(len,key)

if(key==1)
 
        d=[];
        for i=1:len/2
            s=[ones(1,1),zeros(1,1)];
            d=[d s];
        end
            sec_key=d;
else
     d=[];
        for i=1:len/2
            s=[ones(1,1),zeros(1,1)];
            d=[d s];
        end
            sec_key=d;
end
 
     

end

    