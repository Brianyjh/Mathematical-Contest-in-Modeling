clc;clear;
load('FourPath.mat');
load('Data.mat');d=distance;
de = xlsread('C�⸽��2.xlsx');
de (:,1)=[];    % �޳���������
de (:,1)=[]; 
%% �����趨
MaxN = 100 ; % ��糵ѭ�����ߵĴ���
lv = 174; %��������
mv = 40; %��糵�ƶ����ٶ�
n=31;
ne = zeros(1,n-1); %  ÿ����㵱ǰ�ĵ���
mine = zeros(1,n-1); % ����ÿ���ڵ����С����
mine = 1./mine; % ��ʼ����Сֵ
lmin = zeros(1,MaxN); % �洢ÿ��
nltime = zeros(1,30); % �洢ÿ���ڵ�������ʱ��
%%  ��糵�ƶ��������������ֵ
for iter = 1:MaxN
    tatime = 0; % ��¼��ǰ���������ĵ���ʱ��
%% ��һ�� ��糵����ʻ·��
    for i = 2 : length(Path1) % �������нڵ�
        tstime = d( Path1(i-1) , Path1(i) ) / mv;  % �ƶ�����ǰ�㻨�ѵ�ʱ��   
        tatime = tatime + tstime; % �ۼ���ʱ��
        if i ~= n  
            ne( Path1(i) ) = ne( Path1(i) ) - tatime * de( Path1(i) ); % ��ȥ���ʴ˽ڵ�ǰ���ĵ���ʱ��
            mine( Path1(i) ) = min( mine( Path1(i) ) ,  ne( Path1(i) ) ); %������Сֵ
            lmin(iter) = min( lmin(iter) , mine( Path1(i) ) ); % ���µ�ǰ�����е���Сֵ
            ltime = ( abs( ne( Path1( i ) ) )) / lv;     % ��ǰ�����ʱ��
            nltime(i) = max(ltime,nltime(i));
            tstime = tstime + ltime;     % ���ε�ʱ����ϳ���ʱ��
            tatime = tatime + ltime;  % ��ʱ����ϱ��γ���ʱ��
            ne( Path1(i) ) = 0;      % ��ɳ���ǰ�ڵ��޵�����ʧ
        end
        for j = 2 : i-1 %֮ǰ�����нڵ��ȥ��ǰ�㻨�ѵ�ʱ��
            ne( Path1(j) ) = ne( Path1(j) ) - tstime * de( Path1(j) );
        end
        for j = 2 : i-1 %������Сֵ
            mine( Path1(j) ) = min( mine ( Path1(j) ) , ne ( Path1(j) ) );
            lmin(iter) = min( lmin(iter) , mine(Path1(j)) ); %���µ�ǰȦ������Сֵ
        end
    end
%% �ڶ��� ��糵����ʻ·��
    tatime = 0; % ��¼��ǰ���������ĵ���ʱ��
    for i = 2 : length(Path2) % �������нڵ�
        tstime = d( Path2(i-1) , Path2(i) ) / mv;  % ����һ�����ƶ�����ǰ�㻨�ѵ�ʱ��
        tatime = tatime + tstime; % �ۼ���ʱ��
        if i ~= n  
            ne( Path2(i) ) = ne( Path2(i) ) - tatime * de( Path2(i) ); % ��ȥ���ʴ˽ڵ�ǰ���ĵ���ʱ��
            mine( Path2(i) ) = min( mine( Path2(i) ) ,  ne( Path2(i) ) ); %������Сֵ
            lmin(iter) = min( lmin(iter) , mine( Path2(i) ) ); % ���µ�ǰ�����е���Сֵ
            ltime = ( abs( ne( Path2( i ) ) )) / lv;     % ��ǰ�����ʱ��
            nltime(i) = max(ltime,nltime(i));
            tstime = tstime + ltime;     % ���ε�ʱ����ϳ���ʱ��
            tatime = tatime + ltime;  % ��ʱ����ϱ��γ���ʱ��
            ne( Path2(i) ) = 0;      % ��ɳ���ǰ�ڵ��޵�����ʧ
        end
        for j = 2 : i-1 %֮ǰ�����нڵ��ȥ��ǰ�㻨�ѵ�ʱ��
            ne( Path2(j) ) = ne( Path2(j) ) - tstime * de( Path2(j) );
        end
        for j = 2 : i-1 %������Сֵ
            mine( Path2(j) ) = min( mine ( Path2(j) ) , ne ( Path2(j) ) );
            lmin(iter) = min( lmin(iter) , mine(Path2(j)) ); %���µ�ǰȦ������Сֵ
        end
    end
%% ������ ��糵����ʻ·��
    tatime = 0; % ��¼��ǰ���������ĵ���ʱ��
    for i = 2 : length(Path3) % �������нڵ�
        tstime = d( Path3(i-1) , Path3(i) ) / mv;  % ����һ�����ƶ�����ǰ�㻨�ѵ�ʱ��
        tatime = tatime + tstime; % �ۼ���ʱ��
        if i ~= n  
            ne( Path3(i) ) = ne( Path3(i) ) - tatime * de( Path3(i) ); % ��ȥ���ʴ˽ڵ�ǰ���ĵ���ʱ��
            mine( Path3(i) ) = min( mine( Path3(i) ) ,  ne( Path3(i) ) ); %������Сֵ
            lmin(iter) = min( lmin(iter) , mine( Path3(i) ) ); % ���µ�ǰ�����е���Сֵ
            ltime = ( abs( ne( Path3( i ) ) )) / lv;     % ��ǰ�����ʱ��
            nltime(i) = max(ltime,nltime(i));
            tstime = tstime + ltime;     % ���ε�ʱ����ϳ���ʱ��
            tatime = tatime + ltime;  % ��ʱ����ϱ��γ���ʱ��
            ne( Path3(i) ) = 0;      % ��ɳ���ǰ�ڵ��޵�����ʧ
        end
        for j = 2 : i-1 %֮ǰ�����нڵ��ȥ��ǰ�㻨�ѵ�ʱ��
            ne( Path3(j) ) = ne( Path3(j) ) - tstime * de( Path3(j) );
        end
        for j = 2 : i-1 %������Сֵ
            mine( Path3(j) ) = min( mine ( Path3(j) ) , ne ( Path3(j) ) );
            lmin(iter) = min( lmin(iter) , mine(Path3(j)) ); %���µ�ǰȦ������Сֵ
        end
    end
%% ���ĸ� ��糵����ʻ·��
        
    tatime = 0; % ��¼��ǰ���������ĵ���ʱ��
    for i = 2 : length(Path4) % �������нڵ�
        tstime = d( Path4(i-1) , Path4(i) ) / mv;  % ������·������һ�����ƶ�����ǰ�㻨�ѵ�ʱ��
        tatime = tatime + tstime; % �ۼ���ʱ��
        if i ~= n  
            ne( Path4(i) ) = ne( Path4(i) ) - tatime * de( Path4(i) ); % ��ȥ���ʴ˽ڵ�ǰ���ĵ���ʱ��
            mine( Path4(i) ) = min( mine( Path4(i) ) ,  ne( Path4(i) ) ); %������Сֵ
            lmin(iter) = min( lmin(iter) , mine( Path4(i) ) ); % ���µ�ǰ�����е���Сֵ
            ltime = ( abs( ne( Path4( i ) ) )) / lv;     % ��ǰ�����ʱ��
            nltime(i) = max(ltime,nltime(i));
            tstime = tstime + ltime;     % ���ε�ʱ����ϳ���ʱ��
            tatime = tatime + ltime;  % ��ʱ����ϱ��γ���ʱ��
            ne( Path4(i) ) = 0;      % ��ɳ��
        end
        for j = 2 : i-1 %֮ǰ�����нڵ��ȥ��ǰ�㻨�ѵ�ʱ��
            ne( Path4(j) ) = ne( Path4(j) ) - tstime * de( Path4(j) );
        end
        for j = 2 : i-1 %������Сֵ
            mine( Path4(j) ) = min( mine ( Path4(j) ) , ne ( Path4(j) ) );
            lmin(iter) = min( lmin(iter) , mine(Path4(j)) ); %���µ�ǰȦ������Сֵ
        end
    end
end
%%  ��Сֵ���ݻ����ӻ�
figure
x = 1:1:MaxN;
lmin = lmin.*(-1)
plot(x,lmin,'linewidth',1.3,'color',[36,169,255]/255);
title('�ƶ�Ȧ��-����������ͼ');
legend('��ʧ���������ֵ');
axis([0 110 1 2.5]);
xlabel('��糵�ƶ�Ȧ��');ylabel('��ʧ�ĵ������ֵ');
grid on 
%% ���ص���
% ÿ���ĵ������ܵ��� 20%
Maxltime = max(nltime)
Lose = max(lmin)
Battery = Lose / 0.8

