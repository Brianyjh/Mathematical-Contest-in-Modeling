clc;
clear;

% load('data1.mat');
% load('data2.mat');
% load('data3.mat');
load('data4.mat');
sz=size(A1,2);

d=zeros(1,sz);

for i=1:sz
    for j=1:sz
        if A1(i,j)==1
            d(i)=d(i)+1;
        end
    end
end

for i=1:sz
    for j=1:sz
        if A2(i,j)==1
            d(i)=d(i)+1;
        end
    end
end

d_=sort(d);
d_=unique(d_);
cnt=size(d_,2);
idx=zeros(1,max(d_));

for i=1:cnt
    idx(d_(i))=i;
end
time=zeros(1,cnt);

for i=1:sz
    time( idx(d(i)) ) = time(idx(d(i)))+1;
end
figure(1);
plot(d_,time);
% title('网络一 节点-度数分布图');
% title('网络二 节点-度数分布图');
% title('网络三 节点-度数分布图');
title('网络四 节点-度数分布图');
xlabel('度数');
ylabel('节点个数');