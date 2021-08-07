clc;
clear;
close all;

load('data1.mat'); % 假设附件1中的数据解压缩在当前路径下。
a=A1;b=A2;
len=size(a,1);


N=10;
p=rand(1,N);
count=round(len.*p);
r = zeros(1,N);
% res = zeros(1,N);
backupa=a;
backupb=b;

%随机攻击

% for i=1:N 
%     atk = randperm(len);
%     atk = atk(1:count(i)); %确定随机攻击的点 
%     [a,b]=attack(a,b,atk);%调用函数执行攻击
%     [A,B,answer] = cal(a,b); %调用函数实现求最大连通分支
%     r(i)=answer/len;
%     res(i)=answer;
%     a=backupa;
%     b=backupb;
% end
% 
% for i=1:N
%     p(i)=i;
% end


count = sort(count,2);

for i=1:N % 换成size
    for j=1:100
        atk = randperm(len);
        atk = atk(1:count(i)) %确定随机攻击的点 
        
        [a,b]=attack(a,b,atk);%调用函数执行攻击
        [A,B,answer] = cal(a,b); %调用函数实现求最大连通分支
        r(i)= r(i)+ answer/len;
        a=backupa;
        b=backupb;
    end
    r(i)=r(i)/100;
end          

for i=1:N
    p(i)=count(i)/len;
end

figure;
hold on
plot(p,r);
title('p-r关系图');
xlabel('p');
ylabel('r');


