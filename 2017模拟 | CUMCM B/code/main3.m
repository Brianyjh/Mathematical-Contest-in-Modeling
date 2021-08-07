clc,clear,close;
load data.mat;
load newpri.mat;

n = size(finor,1);
st = zeros(1,n);
finor = new;
result = zeros(140,6);
[vipinc,id] = sortrows(vip,5);
time = vipinc(:,5);
time = unique(time);
totvipcnt = size(vip,1);
timeid  = zeros(length(time),2);
N = length(time); % 不同时间段的数量

border = [113.759033,114.444305,22.502661,22.758453; % 深圳
    113.023224,113.230591,22.928042,23.054462; % 广州
    113.230591,113.432465,23.063307,23.248917]; % 佛山 
% 三个发达城区对任务完成与否的影响
pb = [0.7,0.8,0.9];

vipmaxor = 30;
maxorder = 0;
maxfun = 0;

com = 0;
for times = 1:100 % 枚举不同的聚类情况
        st = zeros(n,1);
        order  = [0,0,0,0,0];  % 纬度、经度、价格、数量 
        
%% 对订单按照距离进行聚类

        for i = 1 : n
            if st(i) == 1
                continue;
            end
            
            price = finor(i,4);
            lon = finor(i,3); lat = finor(i,2);
            id = i;
            cnt = 1;
            for j =1 : n
                if cnt > 5  % 订单聚类数量超过
                    break;
                end
                if i == j
                    continue;
                end
                if st(j) == 1
                    continue;
                end
                
                if d(i,j) <=  4
                    cnt = cnt +1;
                    price = price + finor(j,4);
                    st(i) = 1; st(j) = 1;
                end
            end
            tmp = [id,lon,lat,price,cnt];
            order = [order;tmp];
        end
        % 得到当前聚类完成你的订单
        order(1,:) = [];
        totcnt = size(order,1);
        tmp = zeros(totcnt,1);
        order=  [order,tmp,tmp];
        complete = zeros(1,totcnt); % 统计最后每个订单的完成情况
       for i  = 1:totcnt
           order(i,7) = i;
       end
       len = size(order,1);
%% 画图可视化

%% 得到同一时间所有会员的起始下标和终止下标
        
        for i = 1 : N
            tmpid = find(vipinc(:,5) == time(i));
            tmpid = sort(tmpid);
            timeid(i , 1) = time(1);
            timeid(i , 2) = tmpid(1);
            timeid(i , 3) = tmpid(end);
        end
        
        
%% 求解当前的聚类订单结果
        
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
               if  dist<=3 % 两个会员之间的距离
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
    
        %% 当前时间段的会员
            for j = 1 : nowvipcnt     % 依次枚举当前时间段的所有会员
                vipid = nowvip(j,1); % 当前会员号
                thisviporid = 0;         % 初始化当前会员的订单容器
                nowvipor = [0,0,0,0,0,0,0]; % 原id、经度、纬度、总价格、数量、是否选择、id

                % 生成当前人选择的订单
                viporcnt = 0;
                for s = 1 : totcnt
                    if order(s , 6) == 1 % 当前聚类的任务已经被人选择
                        continue;
                    end

                   D =  viptoor(vipid , order(s , 1)); % 当前的会员到当前缩聚点的距离

                   if D <= 30 
                        id = order(s,7); % 当前聚为一类的代表编号
                        thisviporid = [thisviporid , id];
                   end
                end
                
                thisviporid(1) = [];        % 去除当前会员容器头部
                if isempty(thisviporid)  % 当前会员周围无可接订单，直接跳过当前会员
                    continue;
                end
                
                thisvipor = [0,0,0,0,0,0,0]; % 原id、经度、纬度、总价格、数量、是否选择、id
                len = length(thisviporid); 

                for s = 1:len
                    id = thisviporid(s);
                    thisvipor = [thisvipor; order(id , :)];
                end
                
                thisvipor(1,:) = [];
                
                 for s = 1:len % 当前会员订单处理后按照价格、距离进行排序
                    id = thisvipor(s,1);
                    D = viptoor(vipid,id);
                    D = 210 - D;
                    thisvipor(s,8) = thisvipor(s , 4) * 10000 + D;    
                end

                thisvipor = sortrows(thisvipor , -8); % 订单首先按照价格其次按照距离进行排序
                thisvipor(:,8) = [];
                view = 0;

                last = vipinc(j,4);
                last = min(vipmaxor , last); % 当前人能够抢到的单数
                
                leng = size(thisvipor,1);
                
                for q = 1:leng  % 遍历所有订单判断距离
                    id = thisvipor(q,7);
                    if order(id,6) == 1  % 当前的订单已经被人选择过
                        continue;
                    end

            %  计算抢到当前单的概率
                    p1 = p0(vipid);% 计算抢到订单的概率
                    t1 = rand(1);

            % 当前订单能够抢到，计算完成的概率做标记
                    if(t1 <= p1)  % 当前订单被当前会员抢走更新
                        order(id,6) =1;
                        if last < order(id,5)
                            continue;
                        end
                        last = last - order(id,5);
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
                    orid = nowvipor(k,7);
                    thiscnt = nowvipor(k,5);
                    x = nowvipor(k,2); y =nowvipor(k,3);
                    p23=1;
                    for r = 1:3
                        if x >= border(r,1) && x<= border(r,2)
                            if y >=border(r,3) && y<=border(r,4)
                                p23 = pb(r);
                            end
                        end
                    end
                    nowprice = order(orid,4);
                    if i <=11 && i>=1
                        nowprice = nowprice * 1.1;
                    elseif i == 31
                        nowprice = nowprice * 0.95;
                    end
                    if thiscnt >1 && thiscnt <= 6
                        nowprice = nowprice * (1-0.1*(thiscnt-1));
                    end
                    nowprice = nowprice / thiscnt;
                    if nowprice >85
                        nowprice = 85;
                    elseif nowprice <65
                        nowprice = 65;
                    end
                    if nowprice <= 70   % 根据价格生成一个完成概率
                        p21= 0.7;
                    elseif nowprice >70 && nowprice <=75
                        p21 = 0.8;
                    elseif nowprice >75 && nowprice <=80
                        p21= 0.9;
                    else
                        p21= 0.98;
                    end
                    orid = nowvipor(k,1);
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
                    orid = nowvipor(k,7);
                    if(t2 <= p2)
                        complete(orid) = 1;
                    else 
                        complete(orid) = 0;
                    end                
                end
            end
        end
        
        for i = 1:totcnt
            if complete(i) == 1
                com = com + order(i,5);
            end
        end
end

       figure(1);
       plot(finor(:,3),finor(:,2),'o','markersize',8,'markerfacecolor',[36,169,255]/255);
       hold on ;
       plot(order(:,2),order(:,3),'o','markersize',10,'markerfacecolor','r');
       hold on;
com = com / 100 







