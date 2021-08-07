function [mA,mB,res] = cal(matA,matB)
    gA=graph(matA);
    gB=graph(matB);
    len = size(matA,1); %A和B共同的点的数量
    binA = conncomp(gA);  
    binB = conncomp(gB);  
    
    
    binA=getbin(binA,len); %求出A变化后的连通分量
    binB=getbin(binB,len); %求出B变化后的连通分量
    
    
    A=matA;
    B=matB;

    for i = 1:len
        if binA(i) ~= binB(i)
            for j=1:len
                cif A(i,j) ~= B(i,j)
                    A(i,j)=0;
                    A(j,i)=0;
                    B(i,j)=0;
                    B(j,i)=0;
                end
            end
            gA=graph(A);
            gB=graph(B);
            binA = conncomp(gA);  
            binB = conncomp(gB); 
            binA=getbin(binA,len); 
            binB=getbin(binB,len); 
        end
    end
 
    ans_gA=graph(A);
    ans_gB=graph(B);
    ans_binA = conncomp(ans_gA);  
    ans_binB = conncomp(ans_gB); 
    ans_binA=getbin(ans_binA,len); 
    ans_binB=getbin(ans_binB,len); 
    
    rec=zeros(1,len);
    for i=1:len
        rec(ans_binA(i))=rec(ans_binA(i))+1;
    end
    res=-inf;
    for i=1:len
        res=max(res,rec(i));
    end
    mA=A;
    mB=B;
end

