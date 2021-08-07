clc,close,clear;

load data.mat;
center = [83,68.5;
    379,67;
    608,66;
    772,66.5];
n = size(finor,1);
m = size(finor,2);

new = zeros(n,m);

new(:,1:3) = finor(:,1:3);
alpha = 0.0294; belta = 0.058; theta = 0.8053;
for i =1:n
    id = new(i,1);
    
    dis = [d(id , center(1,1)) ,1,center(1,2); % 分别存储，距离、城市号、中心点
        d(id,center(2)) ,2,center(2,2);
        d(id,center(3)) ,3,center(3,2);
        d(id,center(4)),4,center(4,2)];
    dd = sort(dis,1);belong = dd(1,2);tbelong = dd(2,2); mi=dd(1,1);tmi =dd(2,1); % 按照距离排序，获取距离最近的城市编号以及距离
    if mi <= 4
        new(i,4) = center(belong,2);
        continue;
    end
    
    if mi > 24
        new(i,4) = 75;
        continue;
    end
    if mi<16 && (ceil(mi/4) == ceil(tmi/4))
        price = max(center(belong,2),center(tbelong,2));
        price = price  + 2*ceil(mi/4);
        if price >85
            price = 85;
        end
        if price < 65
            price = 65;
        end
        new(i,4) = price;
        continue;
    end
    if mi > 4 && mi<=24
        price = floor(mi) + center(belong,2);
        if price > 85 
            price = 85;
        end
        if price < 65 
            price  =65;
        end
        new(i,4) = price;
    end
    price = new(i,4);
    price = price - alpha* ornearor(id) - belta * ornearvip(id) + theta * Li(id);      
    if price > 85 
            price = 85;
    end
    if price < 65 
        price  =65;
    end
    new(i,4) = price;
end

save('newpri.mat','new');
