function [MinPath , MinDistance,record] = MinTsp(n,d)
    %% 参数初始化
    T0 = 1000;   % 初始温度
    T = T0;  % 迭代温度为初始温度
    MaxN = 1000;  % 最大迭代次数

    Lk = 500;   % 每个温度下的迭代次数
    alpha = 0.97;   % 温度衰减系数

    %%  随机生成一个初始解
    path0 = randperm(n);  % 1-n的随机序列的初始路径
    path0(path0 == 1) = [];
    path0=[1,path0];

    %% 初始化用来保存中间结果的行走路径和距离的取值
    iter_path = path0; %迭代开始的初始路径
    iter_result = CalTspDistance(path0,d);   %初始路径的目标函数
    %% 模拟退火过程

    record=[];
    for iter = 1 : MaxN  % 最大迭代次数
        MinResult = 10000000000;
        for i = 1 : Lk  %  每个温度迭代次数
            
            result0 = CalTspDistance(path0,d); % 当前路径目标函数
            MinResult=min(MinResult,result0);
            path1 = GetNewPath(path0);  % 生成新的路径
            result1 = CalTspDistance(path1,d); % 新路径目标函数
            MinResult=min(MinResult,result1);
            if ~isempty(record)
                MinResult=min(MinResult,record(length(record)));
            end
            if result1 < result0    % 新路径更优
                path0 = path1; % 更新当前路径为新路径
                iter_path = [iter_path; path1]; % 记录路径
                iter_result = [iter_result; result1];  % 记录距离
            else
                p = exp(-(result1 - result0)/T); % Metropolis 准则计算概率
                if rand(1) < p   % 随机数和这个概率比较小于则接受劣解
                    path0 = path1;  % 更新当前路径为新路径
                end
            end
        end
        record=[record,MinResult];
        T = alpha*T;   % 温度下降       
    end



    [MinDistance, idx] = min(iter_result);  % 找到最小的距离的值及下标
    MinPath = iter_path(idx,:); % 据下标找到最优路径    
end

