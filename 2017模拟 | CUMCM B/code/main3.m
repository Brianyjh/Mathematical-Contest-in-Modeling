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
N = length(time); % ��ͬʱ��ε�����

border = [113.759033,114.444305,22.502661,22.758453; % ����
    113.023224,113.230591,22.928042,23.054462; % ����
    113.230591,113.432465,23.063307,23.248917]; % ��ɽ 
% ������������������������Ӱ��
pb = [0.7,0.8,0.9];

vipmaxor = 30;
maxorder = 0;
maxfun = 0;

com = 0;
for times = 1:100 % ö�ٲ�ͬ�ľ������
        st = zeros(n,1);
        order  = [0,0,0,0,0];  % γ�ȡ����ȡ��۸����� 
        
%% �Զ������վ�����о���

        for i = 1 : n
            if st(i) == 1
                continue;
            end
            
            price = finor(i,4);
            lon = finor(i,3); lat = finor(i,2);
            id = i;
            cnt = 1;
            for j =1 : n
                if cnt > 5  % ����������������
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
        % �õ���ǰ���������Ķ���
        order(1,:) = [];
        totcnt = size(order,1);
        tmp = zeros(totcnt,1);
        order=  [order,tmp,tmp];
        complete = zeros(1,totcnt); % ͳ�����ÿ��������������
       for i  = 1:totcnt
           order(i,7) = i;
       end
       len = size(order,1);
%% ��ͼ���ӻ�

%% �õ�ͬһʱ�����л�Ա����ʼ�±����ֹ�±�
        
        for i = 1 : N
            tmpid = find(vipinc(:,5) == time(i));
            tmpid = sort(tmpid);
            timeid(i , 1) = time(1);
            timeid(i , 2) = tmpid(1);
            timeid(i , 3) = tmpid(end);
        end
        
        
%% ��⵱ǰ�ľ��ඩ�����
        
        for i =1:N   %ö�ٲ�ͬ��ʱ���

            st = timeid(i,2); ed = timeid(i,3);  % ��ǰʱ�����ʱ������vip�����е���ʼλ��
            nowvip = vipinc(st:ed,:);
            nowvip = sortrows(nowvip,-6); % ���������Ƚ�������
            nowvipcnt = size(nowvip,1); % ��ǰʱ��εĻ�Ա����
%% ��õ�ǰ��ѡ�񶩵��ɹ��ĸ���
        p0 =zeros(1 , totvipcnt);
        for u = 1 : nowvipcnt

           id1 = nowvip(u,1) ; 
           div = 0;
           this = nowvip(u,4);
           for k = 1 : nowvipcnt % ������е�ǰ����10km�ڵĵ�ǰ��Ա����

               id2 = nowvip(k,1);
               if id1==id2 || u == k 
                   continue;
               end
               dist  = vipd(id1,id2);
               if  dist<=3 % ������Ա֮��ľ���
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
    
        %% ��ǰʱ��εĻ�Ա
            for j = 1 : nowvipcnt     % ����ö�ٵ�ǰʱ��ε����л�Ա
                vipid = nowvip(j,1); % ��ǰ��Ա��
                thisviporid = 0;         % ��ʼ����ǰ��Ա�Ķ�������
                nowvipor = [0,0,0,0,0,0,0]; % ԭid�����ȡ�γ�ȡ��ܼ۸��������Ƿ�ѡ��id

                % ���ɵ�ǰ��ѡ��Ķ���
                viporcnt = 0;
                for s = 1 : totcnt
                    if order(s , 6) == 1 % ��ǰ����������Ѿ�����ѡ��
                        continue;
                    end

                   D =  viptoor(vipid , order(s , 1)); % ��ǰ�Ļ�Ա����ǰ���۵�ľ���

                   if D <= 30 
                        id = order(s,7); % ��ǰ��Ϊһ��Ĵ�����
                        thisviporid = [thisviporid , id];
                   end
                end
                
                thisviporid(1) = [];        % ȥ����ǰ��Ա����ͷ��
                if isempty(thisviporid)  % ��ǰ��Ա��Χ�޿ɽӶ�����ֱ��������ǰ��Ա
                    continue;
                end
                
                thisvipor = [0,0,0,0,0,0,0]; % ԭid�����ȡ�γ�ȡ��ܼ۸��������Ƿ�ѡ��id
                len = length(thisviporid); 

                for s = 1:len
                    id = thisviporid(s);
                    thisvipor = [thisvipor; order(id , :)];
                end
                
                thisvipor(1,:) = [];
                
                 for s = 1:len % ��ǰ��Ա����������ռ۸񡢾����������
                    id = thisvipor(s,1);
                    D = viptoor(vipid,id);
                    D = 210 - D;
                    thisvipor(s,8) = thisvipor(s , 4) * 10000 + D;    
                end

                thisvipor = sortrows(thisvipor , -8); % �������Ȱ��ռ۸���ΰ��վ����������
                thisvipor(:,8) = [];
                view = 0;

                last = vipinc(j,4);
                last = min(vipmaxor , last); % ��ǰ���ܹ������ĵ���
                
                leng = size(thisvipor,1);
                
                for q = 1:leng  % �������ж����жϾ���
                    id = thisvipor(q,7);
                    if order(id,6) == 1  % ��ǰ�Ķ����Ѿ�����ѡ���
                        continue;
                    end

            %  ����������ǰ���ĸ���
                    p1 = p0(vipid);% �������������ĸ���
                    t1 = rand(1);

            % ��ǰ�����ܹ�������������ɵĸ��������
                    if(t1 <= p1)  % ��ǰ��������ǰ��Ա���߸���
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

%% ������ǰ��ѡ������ж���������ÿ����������ɸ���
                for k = 1:noworcnt  
                    % ���ݼ۸����һ������
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
                    if nowprice <= 70   % ���ݼ۸�����һ����ɸ���
                        p21= 0.7;
                    elseif nowprice >70 && nowprice <=75
                        p21 = 0.8;
                    elseif nowprice >75 && nowprice <=80
                        p21= 0.9;
                    else
                        p21= 0.98;
                    end
                    orid = nowvipor(k,1);
                    % ���ݾ������һ������
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
                    t2=rand(1); % ��ǰ������ɵĸ���
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







