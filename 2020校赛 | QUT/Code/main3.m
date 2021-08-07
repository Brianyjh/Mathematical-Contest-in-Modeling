clc;
clear;
close all;
load('data1.mat'); % ���踽��1�е����ݽ�ѹ���ڵ�ǰ·���¡�
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
          
for m=1:N % ����size
    fprintf('����%d����\n',m);
    for j=1:R % ����R�ξ��幥���Ľڵ�min_gmax
        fprintf('����%d����,��%d�ε���\n',m,j);
        vector = randperm(l);
        A = zeros(size(idx_,2));
        for i=1:l
            A(i)=idx_(vector(i));
        end
        atk = A(1:m); %ȷ����������ĵ� 
        [a,b]=attack(a,b,atk);%���ú���ִ�й���
        [A,B,answer] = cal(a,b); %���ú���ʵ���������ͨ��֧
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
ylabel('����ʧЧ��ʣ��ĵ������ͨ���Žڵ����');















