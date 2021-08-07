function [cost, every_cost] = CalMTspDistance(cpath, k, d)
	every_cost = zeros(k,1);	%初始化每个旅行商的路程长度全为0
    
    for i = 1:k	%对每个旅行商开始循环
		path_i = cpath{i};	%第i个旅行商所经过的路线
		n = length(path_i); %第i个旅行商经过的城市的数量
        if n>=26 % 惩罚因子
            every_cost(i) = every_cost(i) + 100000;
        elseif n==1 && path_i(1) == 0
            every_cost(i) = every_cost(i) + 100000;
        elseif n==0
            every_cost(i) = every_cost(i) + 100000;
        end
        for j = 1:n
            if j == 1% d中的第一个位置表示起始的城市
				every_cost(i) = every_cost(i) + d(1,path_i(j) + 1); 
            else
				every_cost(i) = every_cost(i) + d( path_i (j-1) + 1,path_i(j)+1);
            end 
        end
        % 加上从最后一个城市返回到起始城市的路程
		every_cost(i) = every_cost(i) + d(path_i(end)+1,1); 
    end
      cost = sum(every_cost);
end		
