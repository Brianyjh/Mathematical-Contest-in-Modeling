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
xlabel('����');ylabel('γ��');
legend('δ��ɵ�����','��ɵ�����');
for round  =1:1000

[vipinc,id] = sortrows(vip,5);
time = vipinc(:,5);
time = unique(time);

totvipcnt = size(vip,1);
nowor = finor; % ��̬ά����ǰ��δ��ѡ��Ķ���
vipmaxor  = 30; % ��Ա����ѡȡ����󶩵�����
timeid  = zeros(length(time),2);
N = length(time);
R = 57; % ��Ա����ѡ����������뾶
totorcnt = size(finor,1);
tmp = zeros(totorcnt,1);
nowor=[nowor,tmp];
complete = zeros(1,totorcnt); % ͳ�����ÿ��������������
oldprice = finor(:,4);

%% �õ�ͬһʱ�����л�Ա����ʼ�±����ֹ�±�
for i=1:N
    tmpid = find(vipinc(:,5) == time(i));
    tmpid = sort(tmpid);
    timeid(i,1) = time(1);
    timeid(i,2) = tmpid(1);
    timeid(i,3) = tmpid(end);
end

%%  ģ���Աѡ�����

border = [113.75,114.5,22.5,22.8; % ����
    113.230591,113.432465, 23.063307,23.248917;    % ����
    113.023224,113.230591,22.928042,23.054462]; % ��ɽ 
% ������������������������Ӱ��
pb = [0.7,0.8,0.9];

%% ����ʱ���ȥ����ö��

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
           if  dist<=5 % ������Ա֮��ľ���
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
    

%% ��ǰʱ��ε����л�Աȡ�ö���
    for j = 1 : nowvipcnt % ����ö�ٵ�ǰʱ��ε����л�Ա
        
        vipid = nowvip(j,1); % ��ǰ��Ա��
        
        thisviporid = 0; % ��ʼ����ǰ��Ա�Ķ�������
        nowvipor = [0,0,0,0,0,0,0];
        
        % ���ɵ�ǰ��ѡ��Ķ���
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

        thisviporid(1) = [];    % ȥ����ǰ��Ա����ͷ��
        if isempty(thisviporid) % ��ǰ��Ա��Χ�޿ɽӶ�����ֱ��������ǰ��Ա
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
        
        thisvipor = sortrows(thisvipor , -7); % �������Ȱ��ռ۸���ΰ��վ����������
        view = 0;
        
        last = vipinc(j,4);
        last = min(vipmaxor , last); % ��ǰ���ܹ������ĵ���
        
%% ̰������ѡ��۸�ߵĺ;�����ı�������ѡ��  
        leng = size(thisvipor,1);
            for q = 1:leng  % �������ж����жϾ���
                id = thisvipor(q,1);
                if nowor(id,6) == 1  % ��ǰ�Ķ����Ѿ�����ѡ���
                    continue;
                end
                
%% ����������ǰ���ĸ���
                p1 = p0(vipid);% �������������ĸ���
                t1 = rand(1);

%% ��ǰ�����ܹ�������������ɵĸ��������

                if(t1 <= p1)  % ��ǰ��������ǰ��Ա���߸���
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

%% ������ǰ��ѡ������ж���������ÿ����������ɸ���

            for k = 1:noworcnt  
                % ���ݼ۸����һ������
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
                if nowprice <= 70   % ���ݼ۸�����һ����ɸ���
                    p21= 0.7;
                elseif nowprice >70 && nowprice <=75
                    p21 = 0.8;
                elseif nowprice >75 && nowprice <=80
                    p21= 0.9;
                else
                    p21= 0.98;
                end
                
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
xlabel('����');ylabel('γ��');
legend('δ��ɵ�����','��ɵ�����');
end

com = com / 1000
rate = com / 835






