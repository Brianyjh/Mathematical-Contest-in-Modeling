clc;
clear;
load('data1.mat');
% load('data2.mat');
% load('data3.mat');
% load('data4.mat');
a=A1;b=A2;
len=size(A1,1);
d=0;
for i=1:len
    for j=1:len
        if i~=j && a(i,j)
            d=d+1;
        end
    end
end

for i=1:len
    for j=1:len
        if i~=j && b(i,j)
            d=d+1;
        end
    end
end
d
len=len*2
d=d/len

