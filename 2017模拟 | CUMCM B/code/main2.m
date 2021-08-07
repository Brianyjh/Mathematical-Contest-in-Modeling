clc,clear,close;

load data.mat;
com = 0;

tmp = sortrows(finor,5);
idx= find(tmp(:,5) ==1);

sort(idx); idx = idx(1);idx = idx-1;

tmp1 = tmp(1:idx,:);
tmp2 = tmp(idx+1:end,:);
figure(1);

plot(tmp1(:,3),tmp1(:,2),'kx','MarkerSize',7);
hold on;
plot(tmp2(:,3),tmp2(:,2),'o','MarkerSize',5,'MarkerFaceColor',[36,169,255]/255,'MarkerEdgeColor',[36,169,255]/255);
grid on ;
xlabel('经度');ylabel('纬度');
legend('未完成的任务','完成的任务');
for round  =1:1000

[vipinc,id] = sortrows(vip,5);
time = vipinc(:,5);
time = unique(time);

totvipcnt = size(vip,1);
nowor = finor; % 动态维护当前还未被选择的订单
vipmaxor  = 30; % 会员可以选取的最大订单数量
timeid  = zeros(length(time),2);
N = length(time);
R = 57; % 会员可以选择的任务距离半径
totorcnt = size(finor,1);
tmp = zeros(totorcnt,1);
nowor=[nowor,tmp];
complete = zeros(1,totorcnt); % 统计最后每个订单的完成情况
oldprice = finor(:,4);

%% 得到同一时间所有会员的起始下标和终止下标
for i=1:N
    tmpid = find(vipinc(:,5) == time(i));
    tmpid = sort(tmpid);
    timeid(i,1) = time(1);
    timeid(i,2) = tmpid(1);
    timeid(i,3) = tmpid(end);
end

%%  模拟会员选择过程

border = [113.75,114.5,22.5,22.8; % 深圳
    113.230591,113.432465, 23.063307,23.248917;    % 广州
    113.023224,113.230591,22.928042,23.054462]; % 佛山 
% 三个发达城区对任务完成与否的影响
pb = [0.7,0.8,0.9];

%% 按照时间段去依次枚举

for i =1:N   %枚举不同的时间段
    
    st = timeid(i,2); ed = timeid(i,3);  % 当前时间段在时间有序vip序列中的起始位置
    nowvip = vipinc(st:ed,:);
    nowvip = sortrows(nowvip,-6); % 按照信誉度降序排序
    nowvipcnt = size(nowvip,1); % 当前时间段的会员数量
    
%% 获得当前人选择订单成功的概率
    p0 =zeros(1 , totvipcnt);
    for u = 1 : nowvipcnt
        
       id1 = nowvip(u,1) ; 
       div = 0;
       this = nowvip(u,4);
       for k = 1 : nowvipcnt % 求出所有当前订单10km内的当前会员数量
           
           id2 = nowvip(k,1);
           if id1==id2 || u == k 
               continue;
           end
           dist  = vipd(id1,id2);
           if  dist<=5 % 两个会员之间的距离
                div = div + nowvip(k,4);
           end
       end
       
       if div == 0
           p0(id1) = 1;
       else
           div = div + this;
           p0(id1) = this / div;
       end
    end
    

%% 当前时间段的所有会员取得订单
    for j = 1 : nowvipcnt % 依次枚举当前时间段的所有会员
        
        vipid = nowvip(j,1); % 当前会员号
        
        thisviporid = 0; % 初始化当前会员的订单容器
        nowvipor = [0,0,0,0,0,0,0];
        
        % 生成当前人选择的订单
        for s = 1 : totorcnt
            if nowor(s , 6) == 1
                continue;
            end
            
           D =  viptoor(vipid , nowor(s , 1));
           
           if D <= 30 % average
                id = nowor(s,1);
                thisviporid = [thisviporid , id];
           end
           
        end

        thisviporid(1) = [];    % 去除当前会员容器头部
        if isempty(thisviporid) % 当前会员周围无可接订单，直接跳过当前会员
            continue;
        end
        thisvipor = [0,0,0,0,0,0];
        len = length(thisviporid); % 
        
        for s = 1:len
            id = thisviporid(s);
            thisvipor = [thisvipor; nowor(id , :)];
        end
        thisvipor(1,:) = [];
        
        for s = 1:len
            id = thisvipor(s,1);
            D = viptoor(vipinc(j,1),id);
            D = 210 - D;
            thisvipor(s,7) = thisvipor(s , 4) * 1000 + D;    
        end
        
        thisvipor = sortrows(thisvipor , -7); % 订单首先按照价格其次按照距离进行排序
        view = 0;
        
        last = vipinc(j,4);
        last = min(vipmaxor , last); % 当前人能够抢到的单数
        
%% 贪心首先选择价格高的和距离近的遍历进行选择  
        leng = size(thisvipor,1);
            for q = 1:leng  % 遍历所有订单判断距离
                id = thisvipor(q,1);
                if nowor(id,6) == 1  % 当前的订单已经被人选择过
                    continue;
                end
                
%% 计算抢到当前单的概率
                p1 = p0(vipid);% 计算抢到订单的概率
                t1 = rand(1);

%% 当前订单能够抢到，计算完成的概率做标记

                if(t1 <= p1)  % 当前订单被当前会员抢走更新
                    nowor(id,6) =1;
                    last = last - 1;
                    nowvipor = [nowvipor;thisvipor(q , :)];
                    if last <=0
                        break;
                    end
                end
            end
            
            nowvipor(1,:) = [];
            noworcnt = size(nowvipor,1);

%% 遍历当前人选择的所有订单，计算每个订单的完成概率

            for k = 1:noworcnt  
                % 根据价格计算一个概率
                orid = nowvipor(k,1);
                x = nowvipor(k,3); y =nowvipor(k,2);
                p23=1;
                for r = 1:3
                    if x >= border(r,1) && x<= border(r,2)
                        if y >=border(r,3) && y<=border(r,4)
                            p23 = pb(r);
                        end
                    end
                end
                nowprice = oldprice(orid);
                if nowprice <= 70   % 根据价格生成一个完成概率
                    p21= 0.7;
                elseif nowprice >70 && nowprice <=75
                    p21 = 0.8;
                elseif nowprice >75 && nowprice <=80
                    p21= 0.9;
                else
                    p21= 0.98;
                end
                
                % 根据距离计算一个概率
                dis  = viptoor(vipid,orid);
                if dis >=25 && dis<30
                    p22 = 0.9;
                elseif dis >=20 && dis<25
                    p22 = 0.92;
                elseif dis >=15 && dis<20
                    p22 = 0.94;
                elseif dis >=10 && dis<=15
                    p22 = 0.96;
                else
                    p22 = 0.98;
                end
                
                p2= p21*p22*p23;
                t2=rand(1); % 当前任务完成的概率
                
                if(t2 <= p2)
                    complete(orid) = 1;
                else 
                    complete(orid) = 0;
                end                
            end
    end
end
ans = sum(complete)
tmp = finor;
tmp(:,5) = complete;
tmp = sortrows(tmp,5);
idx= find(tmp(:,5) ==1);

sort(idx); idx = idx(1);idx = idx-1;

tmp1 = tmp(1:idx,:);
tmp2 = tmp(idx+1:end,:);
figure(2);

plot(tmp1(:,3),tmp1(:,2),'kx','MarkerSize',7);
hold on;
plot(tmp2(:,3),tmp2(:,2),'o','MarkerSize',5,'MarkerFaceColor',[36,169,255]/255,'MarkerEdgeColor',[36,169,255]/255);
grid on ;
xlabel('经度');ylabel('纬度');
legend('未完成的任务','完成的任务');
end

com = com / 1000
rate = com / 835






