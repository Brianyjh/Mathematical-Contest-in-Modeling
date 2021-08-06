#include <bits/stdc++.h>
using namespace std;


map<pair<int, int>, bool> mp;
/*
    图中的4个特殊点分为4类
    将标号书序记在改数组中
    0:起点，1村庄，2矿山，3终点
*/
const int point[4] = {0, 1, 2, 3}; // 将图中的4个特殊点分为4类

// 4 个特殊点之间的距离矩阵
const int dist[4][4] = {
    {0, 6, 8, 3}, 
    {6, 0, 2, 3}, 
    {8, 2, 0, 5}, 
    {3, 3, 5, 0}
};

// 4 类特殊点互相到达的决策情况
const int f[4][4] = {
    {0, 1, 1, 1}, 
    {0, 0, 1, 1}, 
    {0, 1, 0, 1}, 
    {0, 0, 0, 0}
};

// 天气情况，1 晴朗， 2 高温， 3 沙暴
const int weather[30] = {
    2, 2, 1, 3, 1,
    2, 3, 1, 2, 2,
    3, 2, 1, 2, 2,
    2, 3, 3, 2, 2,
    1, 1, 2, 1, 3,
    2, 1, 1, 2, 2
};



const int weight_water = 3, weight_food = 2; // weight_water 水重量， weight_food 食物重量
const int price_water = 5, price_food = 10; // price_water 水基准价格，price_food 食物基准价格

// consumption_water 下标 1-3 指晴朗、高温、沙暴天气下水的基础消耗
const int consumption_water[4] = {0, 5, 8, 10};

// consumption_food 下标 1-3 的元素分别指晴朗、高温、沙暴天气下食物的基础消耗
const int consumption_food[4] = {0, 7, 6, 10};


const int n = 4; // 共有4个特殊点
const int weight_limit = 1200; // 背包容量
const int money = 10000; // 起始总资产
const int base = 1000; // 挖矿每日收益
const int date = 30; // 截至日期
int cost_water[32][4][4]; // 第 d 天从第 i 点走到第 j 点所消耗的水
int cost_food[32][4][4]; // 第 d 天从第 i 点走到第 j 点所消耗的食物
int days[32][4][4]; // 第d天从第i点走到第j点所需要的实际天数
int ans = 0;

// 每一天所到达的点的标记 -1 代表此时处于最短路径上的某个普通点或此时已经达到终点

// 其余的数字分别代表当天玩家位于对应的特殊点对应情况如 point 数组所示
int location[32];

// 每一天的特殊行动情况 2 代表挖矿 1 代表于矿山停止行动 0 代表在村庄购买
int action[32];

int ans_route[32]; // ans_route 与 ans_action 是最优解路径和最优解路径上的行为
int ans_action[32];

int ansg, ansh; // ansg 和 ansh 是最优解对应的初始水和食物资源量
int g, h; // 用于枚举的初始水与食物资源量


// 天数，地方类型，
void dfs(int day, int now, int nm, int c, int x, int y, int type) {
    action[day] = type;
    location[day] = now;

    if (point[now] == 3) { // 到达终点
        if (ans <= c + x * price_water + y * price_food) { // 当前答案优于最优解更新答案
            ansg = g;
            ansh = h;
            ans = c + x * price_water + y * price_food;
            for (int i = 0; i <= date; i++)
                ans_route[i] = location[i];
            for (int i = 0; i <= date; i++)
                ans_action[i] = action[i];
        }
        action[day] = -1; // 当前点标记为终点
        location[day] = -1;
        return;
    }

    if (day >= date) { // 超过日期限制
        action[day] = -1;
        location[day] = -1;
        return;
    }

    if (point[now] == 1) // 当前点是村庄
        nm = weight_limit - weight_water * x - weight_food * y; // 能够进行购买的容量

    for (int i = 0; i < n; i++) { // 枚举 4 类特殊点
        if (f[point[now]][point[i]]) { // 当前点能够到达的点

            // 移动的花费
            int tx = cost_water[day][now][i]; 
            int ty = cost_food[day][now][i];

            int umoney = c; // 当前资金数量
            int ux, uy;
            int uweight = nm; 

            if (x >= tx) ux = x - tx; // 多余的水量
            else { // 买水
                ux = 0; // 直接在上个村庄
                umoney -= 2 * (tx - x) * price_water;
                uweight -= (tx - x) * weight_water;
            }

            if (y >= ty) uy = y - ty;
            else { // 买食物
                uy = 0; 
                umoney -= 2 * (ty - y) * price_food;
                uweight -= (ty - y) * weight_food;
            }

            if (umoney < 0 || uweight < 0) continue; // 不能到达

            dfs(day + days[day][now][i], i, uweight, umoney, ux, uy, 0);
        }
    }

    if (point[now] == 2) { // 当前在矿山

        // 在矿山停留不挖矿
        int attday = day;
        int tx = consumption_water[weather[attday]];
        int ty = consumption_food[weather[attday]];

        attday++; 
        if (x >= tx) {
            x -= tx;
            tx = 0;
        } else {
            tx -= x;
            x = 0;
        }

        if (y >= ty) {
            y -= ty;
            ty = 0;
        } else {
            ty -= y;
            y = 0;
        }

        nm -= tx * weight_water + ty * weight_food; // 减去补充花费的金钱
        c -= 2 * tx * price_water + 2 * ty * price_food; // 减去补充的重量

        if (nm >= 0 && c >= 0) // 容量和金钱没有超过限制
            dfs(attday, now, nm, c, x, y, 1);


        // 在矿山挖矿
        attday = day;
        tx = consumption_water[weather[attday]] * 2;
        ty = consumption_food[weather[attday]] * 2;
        attday++;
        if (x >= tx) {
            x -= tx;
            tx = 0;
        } else {
            tx -= x;
            x = 0;
        }
        if (y >= ty) {
            y -= ty;
            ty = 0;
        } else {
            ty -= y;
            y = 0;
        }

        nm -= tx * weight_water + ty * weight_food;
        c -= 2 * tx * price_water + 2 * ty * price_food;
        c += base;
        if (nm >= 0 && c >= 0) 
            dfs(attday, now, nm, c, x, y, 2);
    }

    location[day] = -1;
    action[day] = -1;
}



int main() {
    for (int d = 0; d <= date; d ++) {
        location[d] = -1; 
        action[d] = -1;
    }

    // 初始化情况下移动的消耗
    for (int d = 0; d < date; d++) 
        for (int i = 0; i < n; i ++)
            for (int j = 0; j < n; j++)
                if (f[point[i]][point[j]]) {
                    int now = 0, count = 0, water_cost = 0, food_cost = 0;

                    while (count < dist[i][j]) { // 距离未达到时候
                        if (weather[now + d] != 3) { // 沙暴之外的天气
                            count ++; // 移动
                            water_cost += 2 * consumption_water[weather[now + d]]; 
                            food_cost += 2 * consumption_food[weather[now + d]];
                        } else { // 沙暴天气原地等待
                            water_cost += consumption_water[weather[now + d]];
                            food_cost += consumption_food[weather[now + d]];
                        }

                        now ++; 
                        if(now + d >= date) break; 
                    }

                    if(count < dist[i][j]) { // 不能到达的情况
                        water_cost = food_cost = 20000;
                        now = 30;
                    }

                    cost_water[d][i][j] = water_cost;
                    cost_food[d][i][j] = food_cost;
                    days[d][i][j] = now; // 移动需要的天数
                }


   for (int i = 0; i <= weight_limit; i++) { // 枚举初始点的所有水/食物的购买比例
        g = i / weight_water; 
        h = (weight_limit - i) / weight_food; 

        if (!mp[make_pair(g, h)]) 
            dfs(0, 0, 0, money - g * price_water - h * price_food, g, h, -1);
        mp[make_pair(g, h)] = 1;
   } 

   cout << "days\t" << "location\t" << "action\t" << endl;
   for (int i = 0; i <= date; i++)
        cout << i << "\t" << ans_route[i] << "\t" <<ans_action[i] << endl;

    cout << endl;
    
    cout << "mincost\t" << "waterinit\t" << "foodinit\t" <<endl;
    cout << ans << "\t" << ansg << "\t" << ansh << "\t" << endl;
} 


