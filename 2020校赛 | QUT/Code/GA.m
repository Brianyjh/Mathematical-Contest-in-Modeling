clear;
clc;
%参数定义
M=20;               %种群的个数
C=2;               %迭代次数
C_old=C;
m=2;                %适应值归一化淘汰加速指数
Pc=0.8;             %交叉概率
Pmutation=0.2;      %变异概率

res=zeros(1,50);
for i=1:50
    res(i)=+inf;
end
load('data4.mat');
% load('data2.mat');
% load('data3.mat');
% load('data4.mat');
sz = size(A1,1);
backupa=A1;
backupb=A2;
min_ans =zeros(1,50);
for i=1:sz
    atk = i;
    [a,b]=attack(A1,A2,atk);%调用函数执行攻击
    [A,B,answer] = cal(a,b); %调用函数实现求最大连通分支
    res(1)=min(res(1),answer);
    A1=backupa;
    A2=backupb;
end
for cnt=2:50
    fprintf('攻击%d个点\n',cnt);
    %生成初始群体
    popm=zeros(M,cnt);
    for i=1:M 
        atk = randperm(sz);
        popm(i,:)=atk(1:cnt); 
    end
    %初始化种群及其适应函数
    fitness=zeros(M,1); %初始化所有的适应度为0
    len=zeros(M,1);
    for i=1:M
        len(i,1)=myLength(A1,A2,popm(i,:));
    end
    maxlen=max(len);
    minlen=min(len);
    fitness=len;
    rr = find(len==minlen); 
    R = popm(rr(1,1),:); 
    
    fitness = fitness/sum(fitness) 
    try_res=sum(fitness)
    distance_min=zeros(C,1);  %%各次迭代的最小的种群的距离
    %开始迭代
    for C_=1:C
        fprintf('迭代第%d次\n',C_);
        %%%%选择操作%%%%
        nn=0;
        while nn<10
            for i = 1:size(popm,1) %遍历所有种群
                len_1(i,1) = myLength(A1,A2,popm(i,:));
                jc = rand*0.2;
                for j = 1:size(popm,1)
                    if fitness(j,1) > jc
                        nn = nn+1;
                        popm_sel(nn,:) = popm(j,:);
                        break;
                    end
                end
            end
        end
        %每次选择都保存最优的种群
        popm_sel=popm_sel(1:nn,:);
        [len_m len_index]=min(len_1);
        popm_sel=[popm_sel;popm(len_index,:)];
        
        %交叉操作
        nnper = randperm(nn); 
        idx1=nnper(1);
        idx2=nnper(2);
        
        A = popm_sel(idx1,:);
        B = popm_sel(idx2,:);
        
        for i=1:nn*Pc
            [A,B]=cross(A,sz);
            popm_sel(idx1,:)=A;
            popm_sel=[popm_sel;B];
        end
        
        %变异操作
        for i=1:nn
            pick=rand; 
            while pick==0
                 pick=rand;
            end
            if pick<=Pmutation 
               popm_sel(i,:)=Mutation(popm_sel(i,:),sz);
            end
        end
        
        %求适应度函数
        NN=size(popm_sel,1); %染色体个数
        
        len=zeros(NN,1);
        for i=1:NN
            len(i,1)=myLength(A1,A2,popm_sel(i,:));
        end
        maxlen=max(len);
        minlen=min(len);
        distance_min(C_,1)=minlen;
        fitness=fit(len,m,maxlen,minlen);
        popm=[];
        popm=popm_sel;
    end
    res(cnt)=min(distance_min);
end

figure(1)
x=zeros(1,C);
for i=1:50
    x(i)=i;
end
res(cnt)=min(distance_min);
plot(x,res);
xlabel('m');
ylabel('级联失效后剩余的的最大联通集团节点个数');






