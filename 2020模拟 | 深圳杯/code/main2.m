
clc;clear;
%% 读取数据
load('Data.mat');
Path = MinPath;Path=[Path,1];d=distance;
de = xlsread('C题附件2.xlsx');
de (:,1)=[];    % 剔除数据中心 
de (:,1)=[]; 

%% 参数设定
MaxN = 100 ; % 充电车循环行走的次数
lv = 174; %充电的速率
mv = 40; %充电车移动的速度

ba = zeros(1,30);
n = length(Path); 
ne = zeros(1,n-1); %  每个结点当前电量
me = zeros(1,n-1); % 储存每个节点最小电量
me = 1./me; % 初始化最小值
lmin = zeros(1,MaxN); % 每一圈中电量损失最大值
nltime = zeros(1,30); % 存储每个节点充电的最大时间
%%  充电车移动求解最大电量消耗值
for iter = 1:MaxN
    tatime = 0; % 记录当前环行总时间
    for i = 2 : n % 访问所有节点
        % 此节点消耗时间加上移动至当前节点花费的时间
        tstime = d( Path(i-1) , Path(i) ) / mv;   
        tatime = tatime + tstime; 
        if i ~= n  
             % 减去访问此节点前消耗的总时间
            ne( Path(i) ) = ne( Path(i) ) - tatime * de( Path(i) );
            me( Path(i) ) = min( me( Path(i) ) ,  ne( Path(i) ) ); %更新最小值
            lmin(iter) = min( lmin(iter) , me( Path(i) ) ); % 更新当前遍历中的最小值
            ltime = ( abs( ne( Path( i ) ) )) / lv;     % 当前点充电的时间
            nltime(i) = max(ltime,nltime(i));
            tstime = tstime + ltime;     % 本次的时间加上充电的时间
            tatime = tatime + ltime;  % 总时间加上本次充电的时间
            ne( Path(i) ) = 0;      % 完成充电,电量损失为0
        end
        
        
        for j = 2 : i-1 %之前的所有节点减去当前点花费的时间
            ne( Path(j) ) = ne( Path(j) ) - tstime * de( Path(j) );
        end
        
%% 当前节点前减去这个节点充电时间和抵达路径时间和
        for j = 2 : i-1 
            me( Path(j) ) = min( me ( Path(j) ) , ne ( Path(j) ) );
            lmin(iter) = min( lmin(iter) , me(Path(j)) ); %更新最小值
        end
        
    end
end
%%  最小值数据化可视化

x= 1:1:MaxN;
lmin=lmin.*(-1);
me = me .* (-1)
plot(x,lmin,'linewidth',1.3,'color',[36,169,255]/255);
title('移动圈数-最大电量消耗图');
legend('随时电量最值变化曲线');
axis([0 105 2 18]);
xlabel('充电车移动圈数');ylabel('损失的电量最大值');
grid on 

%% 求电池电量
% 每个的电量不能低于20%
maxltime = max(nltime);
lose=max(lmin)
ba=lose/0.8
