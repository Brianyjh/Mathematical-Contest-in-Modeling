#include <bits/stdc++.h>
using namespace std;

#define rep(i, a, n) for (int i = a; i < n; i++)
#define per(i, a, n) for (int i = n - 1; i >= a; i--)
#define fi first
#define se second
#define pb push_back

typedef pair<int, int> pii;
const int INF = 0x3f3f3f3f;

struct weather {
    int water_cost;
    int food_cost;
};
struct cost {
    int weight;
    int price;
};
weather hot = {9, 9}; 
cost waters = {3, 5}; 
cost foods = {2, 10};
int couple = 1200 / (waters.weight + foods.weight);
int water = couple , food = couple;
int st_vi = 5, vi_bl = 2, bl_ed = 3, vl_ed = 3;
int bk;
int min_water = INF, min_food = INF;

void solve1() {
    int now = 1;
    int water_need = 0;
    int food_need = 0;
    int nowpack = 50;
    int money = 10000;
    cout << now << "-" << now + st_vi - 1 << endl;
    rep (i, now, now + st_vi) { // 起点到村庄
        water_need += hot.water_cost * 2;
        food_need += hot.food_cost * 2;
        money -= hot.water_cost * 2 * waters.price;
        money -= hot.food_cost * 2 * foods.price;
        nowpack += hot.water_cost * waters.weight * 2;
        nowpack += hot.food_cost * foods.weight * 2;
        min_water = min(min_water, water - water_need); 
        min_food = min(min_food, food - food_need);
    }
    cout << water_need << ' ' << food_need << endl << " rest in bag : " << 1200 - nowpack << endl;
    now += st_vi;
    nowpack = 50;
    water += 114; food += 114;
    cout << now << "-" << now + vi_bl - 1 << endl;
    rep (i, now, now + vi_bl) { // 村庄到矿
        water_need += hot.water_cost * 2;
        food_need += hot.food_cost * 2;
        money -= hot.water_cost * 2 * waters.price;
        money -= hot.food_cost * 2 * foods.price;
        nowpack += hot.water_cost * waters.weight * 2;
        nowpack += hot.food_cost * foods.weight * 2;
        min_water = min(min_water, water - water_need); 
        min_food = min(min_food, food - food_need);
    }    
    cout << water_need << ' ' << food_need << endl << " rest in bag : " << 1200 - nowpack << endl;
    now += vi_bl;

    cout << now << "-" << "11" << endl;
    rep (i, now, 11 + 1) { // 挖矿
        water_need += hot.water_cost * 3;
        food_need += hot.food_cost * 3;
        money -= hot.water_cost * 3 * waters.price;
        money -= hot.food_cost * 3 * foods.price;
        nowpack += hot.water_cost * waters.weight * 3;
        nowpack += hot.food_cost * foods.weight * 3;
        min_water = min(min_water, water - water_need); 
        min_food = min(min_food,food - food_need);
        cout << water_need << ' ' << food_need << endl << " rest in bag : " << 1200 - nowpack << endl;
        money += 1000;

    }
    now = 12;
    cout << now << "-" << now + 3 - 1 << endl;
    rep (i, now, now + 3 + 1) { // 到终点
        water_need += hot.water_cost * 2;
        food_need += hot.food_cost * 2;
        money -= hot.water_cost * 2 * waters.price;
        money -= hot.food_cost * 2 * foods.price;
        nowpack += hot.water_cost * waters.weight * 2;
        nowpack += hot.food_cost * foods.weight * 2;
        min_water = min(min_water, water - water_need); 
        min_food = min(min_food, food - food_need);
    }
    cout << water_need << ' ' << food_need << endl << " rest in bag : " << 1200 - nowpack << endl;
    cout << "min :  " << min_water << min_food << endl;
}

int main() {
    solve1();
    cout<<"after day : "<<bk<<" water and food run out"<<endl;
}
