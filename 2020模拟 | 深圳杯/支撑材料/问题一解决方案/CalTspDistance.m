function  result =  CalTspDistance(path,d)
    n = length(path);
    result = 0; % ��ʼ����·���ߵľ���Ϊ0
    for i = 1:n-1  
        result = d(path(i),path(i+1)) + result;  % �ۼ�·����
    end   
    result = d(path(1),path(n)) + result;  % ���Ϸ������ľ���
end