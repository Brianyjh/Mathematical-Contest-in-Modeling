clc, clear, close;
times = 10000;
sun = [3, 4];  hot =[9, 9]; storm=[10, 10] ;  % 水的基础消耗、食物的基础消耗
water = [3, 5];  food=[2, 10];     % 重量、 价格

recpick = 0;
recgo = 0;
sun_sun = 2 / 7; sun_hot = 5 / 7;
hot_sun = 5 / 11; hot_hot = 6 / 11;

if rand(1) < 0.5
    towea = 0;    
else
    towea = 1;
end

nowwea = towea;
recminwater = 0;
recminfood = 0; 

for i = 1 : times
    money = 10000;
    nowwea = towea;
    rnd = rand(1);
    towea = newdaywea(nowwea , rnd , sun_hot , hot_sun);  % 获得明天的天气
    
    stormdays = randi(4); 

    days = 14 + stormdays;
    stormday = randperm(days);
    stormday = stormday(1 : stormdays);
    stormday = sort(stormday);
    
    now = 0;
    move = 0;
    pick = 0;
    nowwater = 240; 
    nowfood = 240;
    miw = 10000;
    mif = 10000;
    
    while now < days && move < 11
        nowwea = towea; rnd = rand(1);
        towea = newdaywea(nowwea , rnd , sun_hot , hot_sun);  % 获得明天的天气
        if ~isempty(stormday) 
            if now == stormday(1)
                if move == 7 && (pick < 4)
                    nowwater = nowwater - storm(1) * 3;
                    nowfood = nowfood - storm(2) * 3;
                    pick = pick +1;
                    miw = min(miw, nowwater); mif = min(mif, nowfood);
                else 
                    nowwater = nowwater - storm(1);
                    nowfood = nowfood - storm(2);
                    miw = min(miw, nowwater); mif = min(mif, nowfood);
                end
                now = now+ 1;
                continue;
            end
        end

        if nowwea == 0 % 晴天
            if move == 7 && (pick < 4)
                nowwater = nowwater - sun(1) * 3;
                nowfood = nowfood - sun(2) * 3;
                pick = pick +1;
                miw = min(miw, nowwater); mif = min(mif, nowfood);
            elseif move == 5 
                nowwater = nowwater - sun(1) * 2;
                nowfood = nowfood - sun(2) * 2;
                miw = min(miw, nowwater); mif = min(mif, nowfood);
                nowwater = 240;  nowfood = 240;
            else 
                nowwater = nowwater - sun(1) * 2;
                nowfood = nowfood - sun(2) * 2;
                miw = min(miw, nowwater);  mif = min(mif, nowfood);
                move = move + 1;
            end
        else % 高温
            if move == 7 && (pick < 4)
                nowwater = nowwater - hot(1) * 3;
                nowfood = nowfood - hot(2) * 3;
                pick = pick + 1;
                miw = min(miw, nowwater); 
                mif = min(mif, nowfood);
            elseif move == 5 
                nowwater = nowwater - hot(1) * 2;
                nowfood = nowfood - hot(2) * 2;
                miw = min(miw, nowwater); 
                mif = min(mif, nowfood);
                nowwater = 240;  nowfood = 240;
            else 
                nowwater = nowwater - hot(1) * 2;
                nowfood = nowfood - hot(2) * 2;
                miw = min(miw, nowwater);  
                mif = min(mif, nowfood);
                move = move + 1;
            end
        end
       now = now + 1;
    end
    recminwater(i) = miw; 
    recminfood(i) = mif;
end


x = 1 : length(recminwater);
y = 1 : length(recminwater);
for i = 1 : length(x)
    y(i) = 48;
end

figure(1);
plot(x, recminwater, 'o', 'linewidth', 1.1, 'markerfacecolor', [36, 169, 255] / 255); 
hold on;
plot(x, recminfood, 'o', 'linewidth', 1.1, 'markerfacecolor', [255, 80, 10] / 255); 
hold on;
plot(x, y, 'o', 'linewidth', 1.1, 'markerfacecolor', [200, 200, 200] / 255); 
hold on;
grid on 

title('第四关策略模拟');
legend('水最少时刻', '食物最少时刻', '考虑的最坏情况剩余');
xlabel('模拟次数'); ylabel('剩余物资箱数');
axis([ 0 times 40 240]); 
set(gca, 'linewidth', 1.1, 'fontsize', 16, 'fontname', 'times')



