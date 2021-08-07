clc;
clear;
close all;

load('data1.mat'); % ���踽��1�е����ݽ�ѹ���ڵ�ǰ·���¡�
a=A1;b=A2;
len=size(a,1);


N=10;
p=rand(1,N);
count=round(len.*p);
r = zeros(1,N);
% res = zeros(1,N);
backupa=a;
backupb=b;

%�������

% for i=1:N 
%     atk = randperm(len);
%     atk = atk(1:count(i)); %ȷ����������ĵ� 
%     [a,b]=attack(a,b,atk);%���ú���ִ�й���
%     [A,B,answer] = cal(a,b); %���ú���ʵ���������ͨ��֧
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

for i=1:N % ����size
    for j=1:100
        atk = randperm(len);
        atk = atk(1:count(i)) %ȷ����������ĵ� 
        
        [a,b]=attack(a,b,atk);%���ú���ִ�й���
        [A,B,answer] = cal(a,b); %���ú���ʵ���������ͨ��֧
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
title('p-r��ϵͼ');
xlabel('p');
ylabel('r');


