
%% ��ȡ����
clc;
clear;
location =xlsread('C�⸽��1.xlsx');
load ('Dis.mat');
n=size(distance,1);
%%  ��һ����� ����TSP ·��
[MinPath,MinDistance,record] = MinTsp(n,distance);
location(2,2) = location(2,2)-0.0012;
save ('Data','distance','location','MinPath');
disp('��ѵķ����ǣ�'); disp(MinPath);
disp('��ʱ����ֵ�ǣ�'); disp(MinDistance);
% �����·������������һ��Ԫ�أ�����һ����(�γɱջ�)
MinPath = [MinPath,1];   
n = n+1;  % ���еĸ�����һ
figure(1);

for a = 1:n-1 
    b = a+1;
    loc_a = location(MinPath(a),:);   u_a = loc_a(1);     v_a = loc_a(2); 
    loc_b = location(MinPath(b),:);   u_b = loc_b(1);     v_b = loc_b(2); 
    grid on
    % ȡ����ͼ������ʾ
    plot([u_a,u_b],[v_a,v_b],'-','linewidth',1.1,'color','k','HandleVisibility','off')    
    hold on
end

for i=1:n-1
    text(location(i,1)+0.0005,location(i,2)+0.0005,num2str(i));
    hold on
end
hold on


plot(location(1,1),location(1,2),'o','MarkerSize',15,'MarkerFaceColor','r');hold on;
tmp=location(1,:);
location(1,:)=[];
plot(location(:,1),location(:,2),'o','MarkerSize',12,'MarkerFaceColor',[36,169,255]/255);
grid on
location=[tmp;location];
xlabel('����');ylabel('γ��');
legend('DC��������','S������');

figure(2);
grid on
hold on
x=1:1:length(record);
plot(x,record,'linewidth',1.3);
title('ģ���˻��������');
legend('����ֵ��������');
xlabel('��������');ylabel('����ֵ');
% axis([0 1000 300 1150]);
hold on











