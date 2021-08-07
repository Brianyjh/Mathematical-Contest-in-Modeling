clc;
clear;
close all;
load('data1.mat'); % 假设附件1中的数据解压缩在当前路径下。
a=A1;b=A2;
len=size(a,1);

R=1000;
N=50;
backupa=a;
backupb=b;
min_gmax=zeros(1,N);
for i=1:N
    min_gmax(i)=+inf;
end

d=zeros(1,len);


for i=1:len
    for j=1:len
        if i~=j && (a(i,j) || b(i,j))
            d(i)=d(i)+1;
        end
    end
end
[d,idx]=sort(d,'descend');
l=N*3;
idx_=idx(1:N*4);
          
for m=1:N % 换成size
    fprintf('攻击%d个点\n',m);
    for j=1:R % 生成R次具体攻击的节点min_gmax
        fprintf('攻击%d个点,第%d次迭代\n',m,j);
        vector = randperm(l);
        A = zeros(size(idx_,2));
        for i=1:l
            A(i)=idx_(vector(i));
        end
        atk = A(1:m); %确定随机攻击的点 
        [a,b]=attack(a,b,atk);%调用函数执行攻击
        [A,B,answer] = cal(a,b); %调用函数实现求最大连通分支
        if min_gmax(m)>answer
            min_gmax(m) = answer;
        end
        min_gmax(m)=min(min_gmax);
        a = backupa;
        b = backupb;
    end
end   

m=zeros(1,50);
for i=1:50
    m(i)=i;
end
figure(1);
plot(m,min_gmax);
xlabel('m');
ylabel('级联失效后剩余的的最大联通集团节点个数');















