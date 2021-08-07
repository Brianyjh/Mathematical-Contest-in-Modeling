
%% 读取数据
clc;
clear;
location =xlsread('C题附件1.xlsx');
load ('Dis.mat');
n=size(distance,1);
%%  第一问求解 最优TSP 路径
[MinPath,MinDistance,record] = MinTsp(n,distance);
location(2,2) = location(2,2)-0.0012;
save ('Data','distance','location','MinPath');
disp('最佳的方案是：'); disp(MinPath);
disp('此时最优值是：'); disp(MinDistance);
% 在最短路径的最后面加上一个元素，即第一个点(形成闭环)
MinPath = [MinPath,1];   
n = n+1;  % 城市的个数加一
figure(1);

for a = 1:n-1 
    b = a+1;
    loc_a = location(MinPath(a),:);   u_a = loc_a(1);     v_a = loc_a(2); 
    loc_b = location(MinPath(b),:);   u_b = loc_b(1);     v_b = loc_b(2); 
    grid on
    % 取消在图例中显示
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
xlabel('经度');ylabel('纬度');
legend('DC数据中心','S传感器');

figure(2);
grid on
hold on
x=1:1:length(record);
plot(x,record,'linewidth',1.3);
title('模拟退火过程曲线');
legend('最优值迭代曲线');
xlabel('迭代次数');ylabel('最优值');
% axis([0 1000 300 1150]);
hold on











