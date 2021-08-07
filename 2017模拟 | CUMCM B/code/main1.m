clc,clear,close;

load data.mat;
y= finor(:,2);x=finor(:,3);

figure(1), plot(x,y,'o','MarkerSize',6,'MarkerFaceColor',[255,255,255]/255);
title('����ǰ��ά��');xlabel('X��');ylabel('Y��');
grid on
%�����ȡ150����
% X = [randn(50,2)+ones(50,2);randn(50,2)-ones(50,2);randn(50,2)+[ones(50,1),-ones(50,1)]];
X = [x,y];
opts = statset('Display','final');
 
%����Kmeans����
%X N*P�����ݾ���
%Idx N*1������,�洢����ÿ����ľ�����
%Ctrs K*P�ľ���,�洢����K����������λ��
%SumD 1*K�ĺ�����,�洢����������е���������ĵ����֮��
%D N*K�ľ��󣬴洢����ÿ�������������ĵľ���;
 
[Idx,Ctrs,SumD,D] = kmeans(X,7,'Replicates',10,'Options',opts);
 
%��������Ϊ1�ĵ㡣X(Idx==1,1),Ϊ��һ��������ĵ�һ�����ꣻX(Idx==1,2)Ϊ�ڶ���������ĵڶ�������
figure(2);
plot(X(Idx==1,1),X(Idx==1,2),'r.','MarkerSize',14)
hold on
plot(X(Idx==2,1),X(Idx==2,2),'b.','MarkerSize',14)
hold on
plot(X(Idx==3,1),X(Idx==3,2),'g.','MarkerSize',14)
hold on
plot(X(Idx==4,1),X(Idx==4,2),'k.','MarkerSize',14)
hold on
plot(X(Idx==5,1),X(Idx==5,2),'m.','MarkerSize',14)
hold on
plot(X(Idx==6,1),X(Idx==6,2),'c.','MarkerSize',14)
hold on
plot(X(Idx==7,1),X(Idx==7,2),'y.','MarkerSize',14)
hold on

%����������ĵ�,kx��ʾ��x
plot(Ctrs(:,1),Ctrs(:,2) , 'kx' , 'MarkerSize' , 15 , 'MarkerEdgeColor' ,[180,100,100]/255,'linewidth',5); 
legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Cluster 5','Cluster 6','Cluster 7','Centroids','Location','NW')
grid on
Ctrs
SumD