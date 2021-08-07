function [matA,matB] = attack(mata,matb,atk)
    atk_len=size(atk,2);
    mat_len=size(mata,1);
    for i=1:atk_len
        for j=1:mat_len
            mata(atk(i),j)=0;
            mata(j,atk(i))=0;
            matb(atk(i),j)=0;
            matb(j,atk(i))=0;
        end
    end
    matA = mata;
    matB = matb;
end

