%±äÒìº¯Êý Mutation.m
 
function a=Mutation(A,sz)
    
    record = zeros(1,sz);
    for i=1:size(A,2)
        record(A(i))=1;
    end
    
    idx=0;
    
    replace=randperm(sz);
    x = randperm(size(A,2));
    
    idx=x(1);

    for i = 1 : sz 
        if record(replace(i)) ~= 1
            A(idx)=replace(i);
            break;
        end
    end
    a=A;
end