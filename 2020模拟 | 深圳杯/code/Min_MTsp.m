function [MinPath,MinMaxD,record] = Min_MTsp(city_num , salesman_num , d)
%% 参数初始化
    T0 = 1000;   % 初始温度
    T = T0;  % 迭代温度为初始温度
    MaxN = 1000;  % 最大迭代次数
    Lk = 500;   % 每个温度下的迭代次数
    alpha = 0.97;   % 温度衰减系数
%% 生成初始解的代码

path0 = randperm(city_num); % 1~n的随机序列的初始路径
for i = 1:salesman_num-1	%path0 中随机插入3个0
	len = length(path0);	%计算此时pat0的长度(因为在不断插入0,所以长度会不断增加)
	ind = randi(len);	%生产个1en之间的随机数,ind表示要插入1的位置
	path0 = [ path0(1:ind),0,path0(ind+1:end)]; %插入0
end

%% 初始化用来保存中间结果的行走路径和距离的取值
iter_path = path0; %初始为迭代开始的初始路径
[path0_ , CarNum_ ] = DealPath(path0,salesman_num); %处理插入后的数据
[iter_result,~] = CalMTspDistance(path0_ , CarNum_ , d); % 计算当前路径的距离
%% 模拟退火过程
    
    record = [];
    for iter = 1 : MaxN  % 最大迭代次数
        MinResult = 10000000000;
        for i = 1 : Lk  %  每个温度迭代次数
            %处理插入后的数据
            [path0_ , CarNum_ ] = DealPath(path0,salesman_num); 
            if CarNum_< 4
                result0=100000000;
            else
                 % 计算当前路径的距离
                [result0 , ~] = CalMTspDistance(path0_ , CarNum_ , d); 
            end
            MinResult = min(MinResult,result0);
            
            path1 = GetNewPath(path0);  % 生成新的路径
            [path1_,CarNum_] = DealPath(path1,salesman_num); 
            if CarNum_< 4 % 设置惩罚
                result1=100000000;
            else
                [result1 , ~] = CalMTspDistance(path1_,CarNum_,d); 
            end
            MinResult = min(MinResult,result1);
            
            if ~isempty(record)
                MinResult = min ( MinResult , record( length(record) ) );
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
        
        record = [record,MinResult];
        T = alpha*T;   % 温度下降       
    end
    [MinMaxD, idx] = min(iter_result);  % 找到最小距离的值及其下标
    MinPath = iter_path(idx,:); % 据下标找到最优路径    
end

