%% ����һ��1С��
%% ����̽��
% gupiao(1)={gupiao1};
% gupiao(2)={gupiao2};
% gupiao(3)={gupiao3};
% gupiao(4)={gupiao4};
% gupiao(5)={gupiao5};
% gupiao(6)={gupiao6};
% gupiao(7)={gupiao7};
% gupiao(8)={gupiao8};
% gupiao(9)={gupiao9};
% gupiao(10)={gupiao10};
load('B_data.mat')
zeronum=zeros(10,1);

for i=1:10
    zeronum(i)=length(find(gupiao{i}==0));
    %     figure(i)
    % plot(gupiao{i}(:,1),gupiao{i}(:,6),'r-')
end


%% ̽������ gupiao{i}(:,1)��ת��Ϊ���ֵ�ʱ��
a=[];
for i=1:10
    a=[a;gupiao{i}(:,1)];
end
quan_bu_ri_qi=unique(a); % b��ʮ֧��Ʊ���ظ���ȫ��������

%% ȷ��ÿ����Ʊ��ȱʧ�����ڣ��Ӹù�Ʊ��һ��֮ǰ�����ڲ���ȱʧ�����ڣ������Ե�һ������֮ǰ�����ݽ���Ԥ��
% ����c = setdiff(A, B)
% ������A���У���B��û�е�ֵ��������������������򷵻ء��ڼ������У�c = A - B��A��BҲ�������ַ���ϸ�����顣
que_shi_ri_qi{10}=[];
for i=1:10
    temp=quan_bu_ri_qi(quan_bu_ri_qi>=gupiao{i}(1,1)); % �Ӹù�Ʊ��һ�쿪ʼ��ȫ����Ӧ���еĽ�������
    que_shi_ri_qi{i}=setdiff(temp, gupiao{i}(:,1)) ;
end
% que_shi_ri_qi ���Ǵ洢ʮ֧��Ʊȱʧ���ڵ�Ԫ������

%% ��ȱʧ�����ڲ���ԭ���Ĺ�Ʊ������
for i=1:10
    if ~isempty(que_shi_ri_qi{i})
    gupiao{i}(end+1:end+length(que_shi_ri_qi{i}),:)=[que_shi_ri_qi{i},zeros(length(que_shi_ri_qi{i}),5)];
    end
    % ������ȱʧ�����ڰ���������
    a=gupiao{i}(:,1);
    [a1,w]=sort(a,1);  %��a����õ�a1��������������Ԫ����ԭ�����е�λ��w��
    gupiao{i}(:,1)=a1;
    for j=2:6
        b=gupiao{i}(:,j);
        gupiao{i}(:,j)=b(w);      %�Եڶ����������Ӧ�ı仯
    end
end

%% ʹ���ƶ�ƽ�������в���
gupiao_2=gupiao;
for i=1:10
    for j=2:6
        for k=1:length(gupiao_2{i}(:,j))
            if gupiao_2{i}(k,j)==0
                if k<=4
                    n=k;
                else
                    n=5;
                end
                gupiao_2{i}(k,j)=predict_a_day(gupiao_2{i}(:,j),k,n);
            end
        end
    end
end
xlswrite('answer.xlsx',gupiao_2);
%save B_ques1_1.mat gupiao_2;

%load B_ques1_1.mat;



