
clc,clear,close;
% 数组中存在非数值数据如字符串时候用元胞数组读取
[~,~,finor] = xlsread('已结束项目任务数据.xlsx'); 
[~,~,vip] = xlsread('会员信息数据.xlsx'); 
[~,~,newor] = xlsread('新项目任务数据.xlsx'); 


%% 处理已经完成任务单数据

finor(1,:) = [];
N = size(finor,1);
% 处理元胞数组中的字符串

for i =1:N
    string = char(finor(i,1));  % 当前元胞单元格的字符串
    string(1) = [];
    finor(i,1) = {str2double(string)}; % 将任务号码转化为数字形式
end
finor = cell2mat(finor);
% 经纬度异常值处理 
for i = 1:N
    if finor(i,2) >= 90 && (finor(i,3) <=90 && finor(i,3) >=0)
        fprintf('已完成订单第 %d 条数据出现异常值\n',i);
        tmp = finor(i,2);
        finor(i,2) =finor(i,3);
        finor(i,2) = tmp;
    elseif finor(i,2) >180 || finor(i,3) > 180
        fprintf('已完成订单 %d 条数据出现异常值\n',i);
        finor(i,:)=[];
    end
end
%% 处理会员信息数据

vip(1 , :) = [];
N = size(vip,1);
for i =1:N
    string = char(vip(i,1));  % 当前元胞单元格的字符串
    string(1) = []; 
    vip(i,1) = {str2double(string)}; % 将任务号码转化为数字形式
    
    tmp = char(vip(i,2));
    index = find(tmp == ' ');
    string1 = tmp(1:index-1);
    string2 = tmp(index+1:end); 
    vip(i,2) = { str2double(string1)};
    vip(i,6) = { str2double(string2)};   
end
vip = cell2mat(vip);
tmp1= vip(:,1);tmp2=vip(:,2);tmp3=vip(:,6);
vip(:,1)=[];vip(:,1)=[];vip(:,4)=[];
vip = [tmp1,tmp2,tmp3,vip];

% 经纬度异常值处理 
for i = 1:N
    if vip(i,2) >= 90 && (vip(i,3) <=90 && vip(i,3) >=0)
        fprintf('会员第 %d 条数据出现异常值\n',i);
        tmp = vip(i,2);
        vip(i,2) =vip(i,3);
        vip(i,2) = tmp;
    elseif vip(i,2) >180 || vip(i,3) > 180
        fprintf('会员第 %d 条数据出现异常值\n',i);
        vip(i,:)=[];
    end
end
%%  处理新项目任务数据

newor(1,:) = [];
N = size(newor,1);
% 处理元胞数组中的字符串

for i =1:N
    string = char(newor(i,1));  % 当前元胞单元格的字符串
    string(1) = [];
    newor(i,1) = {str2double(string)}; % 将任务号码转化为数字形式
end
newor = cell2mat(newor);
% 经纬度异常值处理 
for i = 1:N
    if newor(i,2) >= 90 && (newor(i,3) <=90 && newor(i,4) >=0)
        fprintf('新订单第 %d 条数据出现异常值\n',i);
        tmp = newor(i,2);
        newor(i,2) =newor(i,3);
        newor(i,2) = tmp;
    elseif newor(i,2) >180 || newor(i,3) > 180
        fprintf('新订单第 %d 条数据出现异常值\n',i);
        newor(i,:)=[];
    end
end
N = size(finor,1);
M = size(vip,1);

viptoor=zeros(M,N);
R=6370;
for i = 1:M
    for j=1:N
        % 点 a 的经度为 u_a , 纬度 v_a
        ua = vip(i,3);     va = vip(i,2);  
        ua = deg2rad(ua);va = deg2rad(va);
        
        %点 b 的经度为 u_b , 纬度 v_b
        ub = finor(j,3);     vb = finor(j,2);  
        ub = deg2rad(ub);   vb = deg2rad(vb);
        
        % 计算城市i和j的距离
        viptoor(i,j) = R  * acos(  cos(ua - ub) * cos(va) * cos(vb) + sin(va) * sin(vb)  );
    end
end

vipd = zeros(M,M);
% 转化经纬度求距离矩阵
for a = 1 : M  
    for b = 1 : a  
        if(a == b)
            vipd(a,b)  =  1000000;
            continue;
        end
        % 点 a 的经度为 u_a , 纬度 v_a
        ua = vip(a,3);     va = vip(a,2);  
        ua = deg2rad(ua);va = deg2rad(va);
        %点 b 的经度为 u_b , 纬度 v_b
        ub = vip(b,3);     vb = vip(b,2);  
        ub = deg2rad(ub);   vb = deg2rad(vb);
        % 计算城市i和j的距离
        vipd(a , b) = R  * acos(  cos(ua - ub) * cos(va) * cos(vb) + sin(va) * sin(vb)  );
    end
end
vipd = vipd + vipd';

N = size(finor,1);
d = zeros(N);   % 初始化两个城市的距离矩阵全为0
% 转化经纬度求距离矩阵
for a = 1 : N  
    for b = 1 : a  
        if(a == b)
            d(a,b)  =  1000000;
            continue;
        end
        
        % 点 a 的经度为 u_a , 纬度 v_a
        ua = finor(a,3);     va = finor(a,2);  
        ua = deg2rad(ua);va = deg2rad(va);
        
        %点 b 的经度为 u_b , 纬度 v_b
        ub = finor(b,3);     vb = finor(b,2);  
        ub = deg2rad(ub);   vb = deg2rad(vb);
        
        % 计算城市i和j的距离
        d(a , b) = R  * acos(  cos(ua - ub) * cos(va) * cos(vb) + sin(va) * sin(vb)  );
    end
end

d=d+d';
M = size(vip,1);
ornearvip=zeros(1,N);
ornearor = zeros(1,N);
for i =1:N
    for j=1:N
        if i==j
            continue;
        end
        if d(i,j) <= 10
            ornearor(i)=ornearor(i)+1;
        end
    end
end
for i =1:N
    for j =1:M
        if viptoor(j,i) < 10
            ornearvip(i) = ornearvip(i)+1;
        end
    end
end

Li = min(viptoor);
save('data.mat','finor','vip','newor','viptoor','vipd','d','ornearvip','ornearor','Li');


