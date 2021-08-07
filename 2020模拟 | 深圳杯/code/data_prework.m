%% 读取数据
clc;
clear;
location =xlsread('C题附件1.xlsx');

distance = zeros(30);
n = size(location,1);
R=6370;

% 转化经纬度求距离矩阵
for a = 2:n  
    for b = 1:a  
        loca = location(a,:);   
        % 点 a 的经度为 u_a , 纬度 v_a
        ua = loca(1);     va = loca(2);  
        ua = deg2rad(ua);va = deg2rad(va);
        
        locb = location(b,:);
        %点 b 的经度为 u_b , 纬度 v_b
        ub = locb(1);     vb = locb(2);  
        ub = deg2rad(ub);   vb = deg2rad(vb);
        % 计算城市i和j的距离
        distance(a,b) = R  * acos(  cos(ua - ub) * cos(va) * cos(vb) + sin(va) * sin(vb)  );
    end
end

for i= 1:n
        distance(i,i) = 100000000;
end

% 生成距离矩阵的对称的一面
distance = distance + distance';  
distance(1,2)
save('Dis.mat','distance');