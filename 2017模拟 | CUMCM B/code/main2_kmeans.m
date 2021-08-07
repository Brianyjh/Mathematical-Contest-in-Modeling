clc,clear,close;
load data.mat;

clc,clear,close;

load data.mat;
id= find(finor(:,5) ==0);
id = id'
uncom = finor(id(:),:);
y= uncom(:,2);x=uncom(:,3);

subplot(1,2,1), plot(x,y,'o','MarkerSize',6,'MarkerFaceColor',[255,255,255]/255),grid on;
title('����ǰ��ά��');xlabel('����');ylabel('ά��');

%�����ȡ150����
X = [x,y];
opts = statset('Display','final');
 
%����Kmeans����
%X N*P�����ݾ���
%Idx N*1������,�洢����ÿ����ľ�����
%Ctrs K*P�ľ���,�洢����K����������λ��
%SumD 1*K�ĺ�����,�洢����������е���������ĵ����֮��
%D N*K�ľ��󣬴洢����ÿ�������������ĵľ���;
 
[Idx,Ctrs,SumD,D] = kmeans(X,3,'Replicates',10,'Options',opts);
 
%��������Ϊ1�ĵ㡣X(Idx==1,1),Ϊ��һ��������ĵ�һ�����ꣻX(Idx==1,2)Ϊ�ڶ���������ĵڶ�������
subplot(1,2,2)

plot(X(Idx==1,1),X(Idx==1,2),'r.','MarkerSize',14)
hold on
plot(X(Idx==2,1),X(Idx==2,2),'b.','MarkerSize',14)
hold on
plot(X(Idx==3,1),X(Idx==3,2),'g.','MarkerSize',14)
hold on
plot(X(Idx==4,1),X(Idx==4,2),'m.','MarkerSize',14)
hold on
%����������ĵ�,kx��ʾ��x
plot(Ctrs(:,1),Ctrs(:,2) , 'kx' , 'MarkerSize' , 15 , 'MarkerEdgeColor' ,'k','linewidth',14); 
grid on;
title('�������ͼ')
xlabel('����');ylabel('γ��');
legend('���� 1','���� 2','���� 3','����','Location','NW')
 
Ctrs
SumD