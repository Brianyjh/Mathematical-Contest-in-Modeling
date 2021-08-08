%% 问题一第1小问
%% 数据探索
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


%% 探索日期 gupiao{i}(:,1)是转换为数字的时间
a=[];
for i=1:10
    a=[a;gupiao{i}(:,1)];
end
quan_bu_ri_qi=unique(a); % b是十支股票不重复的全部的日期

%% 确定每个股票的缺失的日期，从该股票第一天之前的日期不算缺失的日期，即不对第一个日期之前的数据进行预测
% 讲解c = setdiff(A, B)
% 返回在A中有，而B中没有的值，结果向量将以升序排序返回。在集合论中，c = A - B。A和B也可以是字符串细胞数组。
que_shi_ri_qi{10}=[];
for i=1:10
    temp=quan_bu_ri_qi(quan_bu_ri_qi>=gupiao{i}(1,1)); % 从该股票第一天开始的全部的应该有的交易日期
    que_shi_ri_qi{i}=setdiff(temp, gupiao{i}(:,1)) ;
end
% que_shi_ri_qi 就是存储十支股票缺失日期的元胞数组

%% 将缺失的日期插入原来的股票数据中
for i=1:10
    if ~isempty(que_shi_ri_qi{i})
    gupiao{i}(end+1:end+length(que_shi_ri_qi{i}),:)=[que_shi_ri_qi{i},zeros(length(que_shi_ri_qi{i}),5)];
    end
    % 将插入缺失的日期按升序排列
    a=gupiao{i}(:,1);
    [a1,w]=sort(a,1);  %将a升序得到a1，并返回排序后的元素在原数组中的位置w；
    gupiao{i}(:,1)=a1;
    for j=2:6
        b=gupiao{i}(:,j);
        gupiao{i}(:,j)=b(w);      %对第二数组进行相应的变化
    end
end

%% 使用移动平均法进行补齐
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



