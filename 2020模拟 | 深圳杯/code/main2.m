
clc;clear;
%% ��ȡ����
load('Data.mat');
Path = MinPath;Path=[Path,1];d=distance;
de = xlsread('C�⸽��2.xlsx');
de (:,1)=[];    % �޳��������� 
de (:,1)=[]; 

%% �����趨
MaxN = 100 ; % ��糵ѭ�����ߵĴ���
lv = 174; %��������
mv = 40; %��糵�ƶ����ٶ�

ba = zeros(1,30);
n = length(Path); 
ne = zeros(1,n-1); %  ÿ����㵱ǰ����
me = zeros(1,n-1); % ����ÿ���ڵ���С����
me = 1./me; % ��ʼ����Сֵ
lmin = zeros(1,MaxN); % ÿһȦ�е�����ʧ���ֵ
nltime = zeros(1,30); % �洢ÿ���ڵ�������ʱ��
%%  ��糵�ƶ��������������ֵ
for iter = 1:MaxN
    tatime = 0; % ��¼��ǰ������ʱ��
    for i = 2 : n % �������нڵ�
        % �˽ڵ�����ʱ������ƶ�����ǰ�ڵ㻨�ѵ�ʱ��
        tstime = d( Path(i-1) , Path(i) ) / mv;   
        tatime = tatime + tstime; 
        if i ~= n  
             % ��ȥ���ʴ˽ڵ�ǰ���ĵ���ʱ��
            ne( Path(i) ) = ne( Path(i) ) - tatime * de( Path(i) );
            me( Path(i) ) = min( me( Path(i) ) ,  ne( Path(i) ) ); %������Сֵ
            lmin(iter) = min( lmin(iter) , me( Path(i) ) ); % ���µ�ǰ�����е���Сֵ
            ltime = ( abs( ne( Path( i ) ) )) / lv;     % ��ǰ�����ʱ��
            nltime(i) = max(ltime,nltime(i));
            tstime = tstime + ltime;     % ���ε�ʱ����ϳ���ʱ��
            tatime = tatime + ltime;  % ��ʱ����ϱ��γ���ʱ��
            ne( Path(i) ) = 0;      % ��ɳ��,������ʧΪ0
        end
        
        
        for j = 2 : i-1 %֮ǰ�����нڵ��ȥ��ǰ�㻨�ѵ�ʱ��
            ne( Path(j) ) = ne( Path(j) ) - tstime * de( Path(j) );
        end
        
%% ��ǰ�ڵ�ǰ��ȥ����ڵ���ʱ��͵ִ�·��ʱ���
        for j = 2 : i-1 
            me( Path(j) ) = min( me ( Path(j) ) , ne ( Path(j) ) );
            lmin(iter) = min( lmin(iter) , me(Path(j)) ); %������Сֵ
        end
        
    end
end
%%  ��Сֵ���ݻ����ӻ�

x= 1:1:MaxN;
lmin=lmin.*(-1);
me = me .* (-1)
plot(x,lmin,'linewidth',1.3,'color',[36,169,255]/255);
title('�ƶ�Ȧ��-����������ͼ');
legend('��ʱ������ֵ�仯����');
axis([0 105 2 18]);
xlabel('��糵�ƶ�Ȧ��');ylabel('��ʧ�ĵ������ֵ');
grid on 

%% ���ص���
% ÿ���ĵ������ܵ���20%
maxltime = max(nltime);
lose=max(lmin)
ba=lose/0.8
