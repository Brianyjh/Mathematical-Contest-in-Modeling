function  result =  CalTspDistance(path,d)
    n = length(path);
    result = 0; % 初始化该路径走的距离为0
    for i = 1:n-1  
        result = d(path(i),path(i+1)) + result;  % 累计路径和
    end   
    result = d(path(1),path(n)) + result;  % 加上返回起点的距离
end