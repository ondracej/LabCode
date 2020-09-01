b=zeros(1,10);
a={1,2,3,4,'a',6,7,8,9,10};
for k=1:10
    try
    b(k)=sin(a{k});    
        
    catch
        b(k)=10;
        continue;
    end
end
b