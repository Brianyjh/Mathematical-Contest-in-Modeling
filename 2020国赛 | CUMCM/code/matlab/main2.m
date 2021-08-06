clc, clear, close;
times = 100000;
sun = [3, 4];  hot = [9, 9];    % 水的基础消耗、食物的基础消耗
water = [3, 5];  food= [2, 10];  % 重量、价格
pstay = 0.1;
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

%% 去采矿 

for i = 1 : times
    move = 0;
    tmp = rand(1);  
    pickday = getpickdays(tmp); % 获得根据均匀分布得到的采矿时间
    money = 10000;
    ans = -1;
    nowpack = 0;
    now = 1;
    
    while now < 11
        nowwea = towea;
        rnd = rand(1);
        towea = newdaywea(nowwea, rnd, sun_hot, hot_sun);  % 获得明天的天气
        
        if move == 5 % 移动至终点 
            ans = money;
            break;
        end
        
        while move == 3 && pickday ~= 0 % 到达矿并完成采矿的过程
            pickday = pickday -1;
            
            if nowwea == 0 
                money = money - sun(1) * water(2) * 3 - sun(2) * food(2) * 3; 
                nowpack  = nowpack + sun(1) * water(1) * 3 + sun(2) * food(1) * 3; 
            else 
                money = money - hot(1) * water(2) * 3 - hot(2) * food(2) * 3; 
                nowpack  = nowpack + hot(1) * water(1) * 3 + hot(2) * food(1) * 3; 
            end
            
            money = money + 200; 
            now = now + 1; 
        end    
        
        if money == 0 || nowpack > 1200
            ans = -1;
            break;
        end
        
        move = move + 1; 
        
        if nowwea == 0 
            money = money - sun(1) * water(2) * 2 - sun(2) * food(2) * 2;
            nowpack  = nowpack + sun(1) * water(1) * 2 + sun(2) * food(1) * 2;
        else 
            money = money - hot(1) * water(2) * 2 - hot(2) * food(2) * 2;
            nowpack  = nowpack + hot(1) * water(1) * 2 + hot(2) * food(1) * 2;
        end
        
        now = now + 1;    
        if nowpack > 1200 
            ans = -1;
            break;
        end
    end
    
    recpick(i) = ans;
end

% recpick(1)=[];      
%% 直接走到终点
    
for i = 1 : times
    move = 0;
    money = 10000;
    ans = -1;
    nowpack = 0;
    now = 1;
    
    while now < 11
        nowwea = towea;
        rnd = rand(1);
        towea = newdaywea(nowwea, rnd, sun_hot, hot_sun);  % 获得明天的天气
        
        if move == 3 % 移动至终点
            ans = money;
            break;
        end
        
        if money == 0 || nowpack > 1200
            ans = -1;
            break;
        end
        
        move = move + 1;
        if nowwea == 0 
            money = money - sun(1) * water(2) * 2 - sun(2) * food(2) * 2;
            nowpack  = nowpack + sun(1) * water(1) * 2 + sun(2) * food(1) * 2;
        else 
            money = money - hot(1) * water(2) * 2 - hot(2) * food(2) * 2;
            nowpack  = nowpack + hot(1) * water(1) * 2 + hot(2) * food(1) * 2;
        end
        now = now + 1;    
         if nowpack > 1200
             ans = -1;
             break;
         end
    end
    recgo(i) = ans;
end
% recgo(1) = [];

x = 1 : times;

figure(1);

plot(x, recpick, 'o', 'linewidth', 1.1, 'markersize', 4, 'markerfacecolor', [36, 169, 255] / 255); 
hold on;
plot(x, recgo, 'o', 'linewidth', 1.1, 'markersize', 4, 'markerfacecolor', [255, 80, 10] / 255); 
hold on;
grid on 

title('模拟');
legend('采矿', '直接至终点');
xlabel('模拟次数'); ylabel('剩余的金钱');
axis([ 0 times 7500 10000]); 
set(gca, 'linewidth', 1.1, 'fontsize', 16, 'fontname', 'times')



