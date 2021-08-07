
function [cpath, k] = DealPath(path, salesman_num)
	cpath = cell(salesman_num,1);	% 元胞数组,存储每个旅行商经过城市
	index = find(path == 0);	%   找到所有隔板位置
	k=1;	
    for i = 1:salesman_num-1	
		
        if i == 1	% 如果是第1个隔板
			c = path(i:index(i)-1);	% 提取第一个旅行商经过的城市
        else
			c = path(index(i-1)+1:index(i)-1);% 提取中间的旅行商所经过的城市
        end
        
        if ~isempty(c)	% 只有c非空的话才保存
			cpath{k} = c;   %  把c保存到元胞cpath的第k个位置表示第k个旅行商的路径
			k = k+1;    %  参与工作的旅行商数目+1
        end
    end
	c = path( index(end) + 1 : end );	%   最后一个旅行商经过的城市
	if ~isempty(c)	
		cpath{k} = c;
	else 
		k = k-1;
	end
	cpath = cpath(1:k); %   只保留元胞中前k中非空的部分
end