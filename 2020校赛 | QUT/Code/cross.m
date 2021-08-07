function [A,B]=cross(A,sz)
    
    cnt=size(A,2);
    do=floor(cnt/2);
    fprintf('cnt : %d\n',cnt);
    fprintf('do : %d\n',do);
%     W=floor(L/de)+8;
    reca=zeros(1,sz);
    recb=zeros(1,sz);
    B = randperm(sz);
    B = B(1:cnt);
    
    for i=1:cnt
       reca(A(1,i))=1; 
    end
    for i=1:cnt
       recb(B(1,i))=1; 
    end
    for i=1:do              
       fprintf('i : %d   cnt -i +1 : %d\n',i,cnt-i+1); 
        if A(1,i) ~= B(1,cnt-i+1) && recb(A(i)) ~= 1 && reca(B,cnt-i+1) ~= 1
            [A(i),B(cnt-i+1)] = exchange(A(i),B(cnt-i+1));
        end       
    end
    
end