clc;clear;
load('FourPath.mat');
load('Data.mat');d=distance;
de = xlsread('C题附件2.xlsx');
de (:,1)=[];    % 剔除掉出发点
de (:,1)=[]; 
%% 参数设定
MaxN = 100 ; % 充电车循环行走的次数
lv = 174; %充电的速率
mv = 40; %充电车移动的速度
n=31;
ne = zeros(1,n-1); %  每个结点当前的电量
mine = zeros(1,n-1); % 储存每个节点的最小电量
mine = 1./mine; % 初始化最小值
lmin = zeros(1,MaxN); % 存储每个
nltime = zeros(1,30); % 存储每个节点充电的最大时间
%%  充电车移动求解最大电量消耗值
for iter = 1:MaxN
    tatime = 0; % 记录当前环行走消耗的总时间
%% 第一个 充电车的行驶路径
    for i = 2 : length(Path1) % 访问所有节点
        tstime = d( Path1(i-1) , Path1(i) ) / mv;  % 移动到当前点花费的时间   
        tatime = tatime + tstime; % 累计总时间
        if i ~= n  
            ne( Path1(i) ) = ne( Path1(i) ) - tatime * de( Path1(i) ); % 减去访问此节点前消耗的总时间
            mine( Path1(i) ) = min( mine( Path1(i) ) ,  ne( Path1(i) ) ); %更新最小值
            lmin(iter) = min( lmin(iter) , mine( Path1(i) ) ); % 更新当前遍历中的最小值
            ltime = ( abs( ne( Path1( i ) ) )) / lv;     % 当前点充电的时间
            nltime(i) = max(ltime,nltime(i));
            tstime = tstime + ltime;     % 本次的时间加上充电的时间
            tatime = tatime + ltime;  % 总时间加上本次充电的时间
            ne( Path1(i) ) = 0;      % 完成充电后当前节点无电量损失
        end
        for j = 2 : i-1 %之前的所有节点减去当前点花费的时间
            ne( Path1(j) ) = ne( Path1(j) ) - tstime * de( Path1(j) );
        end
        for j = 2 : i-1 %更新最小值
            mine( Path1(j) ) = min( mine ( Path1(j) ) , ne ( Path1(j) ) );
            lmin(iter) = min( lmin(iter) , mine(Path1(j)) ); %更新当前圈数的最小值
        end
    end
%% 第二个 充电车的行驶路径
    tatime = 0; % 记录当前环行走消耗的总时间
    for i = 2 : length(Path2) % 访问所有节点
        tstime = d( Path2(i-1) , Path2(i) ) / mv;  % 从上一个点移动到当前点花费的时间
        tatime = tatime + tstime; % 累计总时间
        if i ~= n  
            ne( Path2(i) ) = ne( Path2(i) ) - tatime * de( Path2(i) ); % 减去访问此节点前消耗的总时间
            mine( Path2(i) ) = min( mine( Path2(i) ) ,  ne( Path2(i) ) ); %更新最小值
            lmin(iter) = min( lmin(iter) , mine( Path2(i) ) ); % 更新当前遍历中的最小值
            ltime = ( abs( ne( Path2( i ) ) )) / lv;     % 当前点充电的时间
            nltime(i) = max(ltime,nltime(i));
            tstime = tstime + ltime;     % 本次的时间加上充电的时间
            tatime = tatime + ltime;  % 总时间加上本次充电的时间
            ne( Path2(i) ) = 0;      % 完成充电后当前节点无电量损失
        end
        for j = 2 : i-1 %之前的所有节点减去当前点花费的时间
            ne( Path2(j) ) = ne( Path2(j) ) - tstime * de( Path2(j) );
        end
        for j = 2 : i-1 %更新最小值
            mine( Path2(j) ) = min( mine ( Path2(j) ) , ne ( Path2(j) ) );
            lmin(iter) = min( lmin(iter) , mine(Path2(j)) ); %更新当前圈数的最小值
        end
    end
%% 第三个 充电车的行驶路径
    tatime = 0; % 记录当前环行走消耗的总时间
    for i = 2 : length(Path3) % 访问所有节点
        tstime = d( Path3(i-1) , Path3(i) ) / mv;  % 从上一个点移动到当前点花费的时间
        tatime = tatime + tstime; % 累计总时间
        if i ~= n  
            ne( Path3(i) ) = ne( Path3(i) ) - tatime * de( Path3(i) ); % 减去访问此节点前消耗的总时间
            mine( Path3(i) ) = min( mine( Path3(i) ) ,  ne( Path3(i) ) ); %更新最小值
            lmin(iter) = min( lmin(iter) , mine( Path3(i) ) ); % 更新当前遍历中的最小值
            ltime = ( abs( ne( Path3( i ) ) )) / lv;     % 当前点充电的时间
            nltime(i) = max(ltime,nltime(i));
            tstime = tstime + ltime;     % 本次的时间加上充电的时间
            tatime = tatime + ltime;  % 总时间加上本次充电的时间
            ne( Path3(i) ) = 0;      % 完成充电后当前节点无电量损失
        end
        for j = 2 : i-1 %之前的所有节点减去当前点花费的时间
            ne( Path3(j) ) = ne( Path3(j) ) - tstime * de( Path3(j) );
        end
        for j = 2 : i-1 %更新最小值
            mine( Path3(j) ) = min( mine ( Path3(j) ) , ne ( Path3(j) ) );
            lmin(iter) = min( lmin(iter) , mine(Path3(j)) ); %更新当前圈数的最小值
        end
    end
%% 第四个 充电车的行驶路径
        
    tatime = 0; % 记录当前环行走消耗的总时间
    for i = 2 : length(Path4) % 访问所有节点
        tstime = d( Path4(i-1) , Path4(i) ) / mv;  % 从最优路径的上一个点移动到当前点花费的时间
        tatime = tatime + tstime; % 累计总时间
        if i ~= n  
            ne( Path4(i) ) = ne( Path4(i) ) - tatime * de( Path4(i) ); % 减去访问此节点前消耗的总时间
            mine( Path4(i) ) = min( mine( Path4(i) ) ,  ne( Path4(i) ) ); %更新最小值
            lmin(iter) = min( lmin(iter) , mine( Path4(i) ) ); % 更新当前遍历中的最小值
            ltime = ( abs( ne( Path4( i ) ) )) / lv;     % 当前点充电的时间
            nltime(i) = max(ltime,nltime(i));
            tstime = tstime + ltime;     % 本次的时间加上充电的时间
            tatime = tatime + ltime;  % 总时间加上本次充电的时间
            ne( Path4(i) ) = 0;      % 完成充电
        end
        for j = 2 : i-1 %之前的所有节点减去当前点花费的时间
            ne( Path4(j) ) = ne( Path4(j) ) - tstime * de( Path4(j) );
        end
        for j = 2 : i-1 %更新最小值
            mine( Path4(j) ) = min( mine ( Path4(j) ) , ne ( Path4(j) ) );
            lmin(iter) = min( lmin(iter) , mine(Path4(j)) ); %更新当前圈数的最小值
        end
    end
end
%%  最小值数据化可视化
figure
x = 1:1:MaxN;
lmin = lmin.*(-1)
plot(x,lmin,'linewidth',1.3,'color',[36,169,255]/255);
title('移动圈数-最大电量消耗图');
legend('损失电量的最大值');
axis([0 110 1 2.5]);
xlabel('充电车移动圈数');ylabel('损失的电量最大值');
grid on 
%% 求电池电量
% 每个的电量不能低于 20%
Maxltime = max(nltime)
Lose = max(lmin)
Battery = Lose / 0.8

