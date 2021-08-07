clc,clear,close;
load data.mat;
M = size(vip,1);
N = size(newor,1);
viptonor=zeros(M,N);
rec  = zeros(N,4);
border = [113.124847,113.539381,23.041825,23.443089;
    

R=6370;
for i = 1:M
    for j = 1:N
        % 点 a 的经度为 u_a , 纬度 v_a
        ua = vip(i,3);     va = vip(i,2);  
        ua = deg2rad(ua); va = deg2rad(va);
        
        %点 b 的经度为 u_b , 纬度 v_b
        ub = newor(j,3);     vb = newor(j,2);  
        ub = deg2rad(ub);   vb = deg2rad(vb);
        
        % 计算城市i和j的距离
        viptonor(i,j) = R  * acos(  cos(ua - ub) * cos(va) * cos(vb) + sin(va) * sin(vb)  );
    end
end

d = zeros(N);   % 初始化两个城市的距离矩阵全为0
% 转化经纬度求距离矩阵
for a = 1 : N  
    for b = 1 : a  
        if(a == b)
            d(a,b)  =  1000000;
            continue;
        end
        
        % 点 a 的经度为 u_a , 纬度 v_a
        ua = newor(a,3);     va = newor(a,2);  
        ua = deg2rad(ua);va = deg2rad(va);
        
        %点 b 的经度为 u_b , 纬度 v_b
        ub = newor(b,3);     vb = newor(b,2);  
        ub = deg2rad(ub);   vb = deg2rad(vb);
        
        % 计算城市i和j的距离
        d(a , b) = R  * acos(  cos(ua - ub) * cos(va) * cos(vb) + sin(va) * sin(vb)  );
    end
end
d=d+d';


for i =1:N
    lon = newor(i,3);lat = newor(i,2);
   ,];
    if lon <= 114.539337 && lon >= 113.768921 && lat <= 22.865787 && lat >= 22.516363
        rec(i,1) = 70;
    else
        rec(i,1) =72;
    end
    
    now = 0;
    for j =1:N
        if i == j
            continue;
        end
        
        if d(i,j) < 0.5
            now = now +1;
        end
    end
    rec(i,3) = now;
end


for i  = 1:N
    n = 0;
    now = 0;
    for j =1:M
        if viptonor(j,i) <= 0.5
            p = p+ vip(j,6);
            now = now + 1;
        end
    end
    rec(i,2) = now; rec(i,4) = p;
end

