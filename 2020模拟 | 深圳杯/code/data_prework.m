%% ��ȡ����
clc;
clear;
location =xlsread('C�⸽��1.xlsx');

distance = zeros(30);
n = size(location,1);
R=6370;

% ת����γ����������
for a = 2:n  
    for b = 1:a  
        loca = location(a,:);   
        % �� a �ľ���Ϊ u_a , γ�� v_a
        ua = loca(1);     va = loca(2);  
        ua = deg2rad(ua);va = deg2rad(va);
        
        locb = location(b,:);
        %�� b �ľ���Ϊ u_b , γ�� v_b
        ub = locb(1);     vb = locb(2);  
        ub = deg2rad(ub);   vb = deg2rad(vb);
        % �������i��j�ľ���
        distance(a,b) = R  * acos(  cos(ua - ub) * cos(va) * cos(vb) + sin(va) * sin(vb)  );
    end
end

for i= 1:n
        distance(i,i) = 100000000;
end

% ���ɾ������ĶԳƵ�һ��
distance = distance + distance';  
distance(1,2)
save('Dis.mat','distance');