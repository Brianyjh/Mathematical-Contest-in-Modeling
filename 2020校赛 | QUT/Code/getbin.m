function [result] = getbin(bin,size)
    record = 1./zeros(1,size); %初始化为无穷大
    cnt=-inf;
    
    for i=1:size
        cnt=max(cnt,bin(i));
    end
    
    
    for i=1:size
        record(bin(i))=i;
    end
    
    for i=1:size
        record(bin(i))= max(record(bin(i)),i);
    end
    res=zeros(1,size);
    for i=1:size
        res(i) = record(bin(i));
    end
    result=res;
end

    