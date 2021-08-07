function [MinPath , MinDistance,record] = MinTsp(n,d)
    %% ������ʼ��
    T0 = 1000;   % ��ʼ�¶�
    T = T0;  % �����¶�Ϊ��ʼ�¶�
    MaxN = 1000;  % ����������

    Lk = 500;   % ÿ���¶��µĵ�������
    alpha = 0.97;   % �¶�˥��ϵ��

    %%  �������һ����ʼ��
    path0 = randperm(n);  % 1-n��������еĳ�ʼ·��
    path0(path0 == 1) = [];
    path0=[1,path0];

    %% ��ʼ�����������м���������·���;����ȡֵ
    iter_path = path0; %������ʼ�ĳ�ʼ·��
    iter_result = CalTspDistance(path0,d);   %��ʼ·����Ŀ�꺯��
    %% ģ���˻����

    record=[];
    for iter = 1 : MaxN  % ����������
        MinResult = 10000000000;
        for i = 1 : Lk  %  ÿ���¶ȵ�������
            
            result0 = CalTspDistance(path0,d); % ��ǰ·��Ŀ�꺯��
            MinResult=min(MinResult,result0);
            path1 = GetNewPath(path0);  % �����µ�·��
            result1 = CalTspDistance(path1,d); % ��·��Ŀ�꺯��
            MinResult=min(MinResult,result1);
            if ~isempty(record)
                MinResult=min(MinResult,record(length(record)));
            end
            if result1 < result0    % ��·������
                path0 = path1; % ���µ�ǰ·��Ϊ��·��
                iter_path = [iter_path; path1]; % ��¼·��
                iter_result = [iter_result; result1];  % ��¼����
            else
                p = exp(-(result1 - result0)/T); % Metropolis ׼��������
                if rand(1) < p   % �������������ʱȽ�С��������ӽ�
                    path0 = path1;  % ���µ�ǰ·��Ϊ��·��
                end
            end
        end
        record=[record,MinResult];
        T = alpha*T;   % �¶��½�       
    end



    [MinDistance, idx] = min(iter_result);  % �ҵ���С�ľ����ֵ���±�
    MinPath = iter_path(idx,:); % ���±��ҵ�����·��    
end

