#include<bits/stdc++.h>
#define rep(i,a,n) for(int i=a;i<n;i++)
#define per(i,a,n) for(int i=n-1;i>=a;i--)
#define fi first
#define se second
#define pb push_back
#define close ios::sync_with_stdio(0);cin.tie(0);cout.tie(0);
using namespace std;
typedef pair<int,int> pii;
const int INF=0x3f3f3f3f;

struct weather
{
    int water_cost;
    int food_cost;
};
struct cost
{
    int weight;
    int price;
};
weather hot ={9,9}; 
weather sun={3,4};
weather storm = {10,10};
cost waters={3,5}; 
cost foods = {2,10};
int wea[11]={0,0,1,0,0,0,0,1,1,1,1}; // ÌìÆø
int st_vi = 5,vi_bl=2,bl_ed =3,vl_ed=3;
int bk;
int min_water = INF,min_food =INF;
int nowpack = 0;
int money =10000;
int water_need = 0;
int food_need = 0;

int solve1()
{
    pii ans = {-1e5,0};
    int now= 1;
    rep(i,1,now+3)
    {
        if(wea[i] == 0)
        {
            water_need += sun.water_cost * 2;
            food_need += sun.food_cost * 2;
            money -= sun.water_cost * 2 * waters.price;
            money -= sun.food_cost * 2 * foods.price;
            nowpack += sun.water_cost * waters.weight * 2;
            nowpack += sun.food_cost * foods.weight * 2;

        }
        else
        {
            water_need += hot.water_cost * 2;
            food_need += hot.food_cost * 2;
            money -= hot.water_cost * waters.price*2;
            money -= hot.food_cost * foods.price*2;
            nowpack += hot.water_cost * waters.weight*2;
            nowpack += hot.food_cost * foods.weight*2;
        }
    }
    now+=3;
    rep(p,1,5+1)
    {
        rep(i,now,now+p)
        {
            if(wea[i] == 0)
            {
                water_need += sun.water_cost * 2;
                food_need += sun.food_cost * 2;
                money -= sun.water_cost * 2 * waters.price;
                money -= sun.food_cost * 2 * foods.price;
                nowpack += sun.water_cost * waters.weight * 2;
                nowpack += sun.food_cost * foods.weight * 2;

            }
            else
            {
                water_need += hot.water_cost * 2;
                food_need += hot.food_cost * 2;
                money -= hot.water_cost * waters.price*2;
                money -= hot.food_cost * foods.price*2;
                nowpack += hot.water_cost * waters.weight*2;
                nowpack += hot.food_cost * foods.weight*2;
            }
            money += 200;
        }
        now += p;
        rep(i,now,now+2)
        {
            if(wea[i] == 0)
            {
                water_need += sun.water_cost * 2;
                food_need += sun.food_cost * 2;
                money -= sun.water_cost * 2 * waters.price;
                money -= sun.food_cost * 2 * foods.price;
                nowpack += sun.water_cost * waters.weight * 2;
                nowpack += sun.food_cost * foods.weight * 2;

            }
            else
            {
                water_need += hot.water_cost * 2;
                food_need += hot.food_cost * 2;
                money -= hot.water_cost * waters.price*2;
                money -= hot.food_cost * foods.price*2;
                nowpack += hot.water_cost * waters.weight*2;
                nowpack += hot.food_cost * foods.weight*2;
            }
        }

        if(money > ans.fi) ans={money,p};
    }

    cout<<ans.fi<<" "<<ans.se<<endl;
    return ans.fi;
}
int solve2()
{
    int now=1;
    rep(i,1,5)
    {
        if(i==2)
        {
            water_need += hot.water_cost ;
            food_need += hot.food_cost;
            money -= hot.water_cost * waters.price;
            money -= hot.food_cost * foods.price;
            nowpack += hot.water_cost * waters.weight;
            nowpack += hot.food_cost * foods.weight;
        }
        else{
            water_need += sun.water_cost * 2;
            food_need += sun.food_cost * 2;
            money -= sun.water_cost * 2 * waters.price;
            money -= sun.food_cost * 2 * foods.price;
            nowpack += sun.water_cost * waters.weight * 2;
            nowpack += sun.food_cost * foods.weight * 2;
        }
    }

}
int main()
{
    close
    cout<<solve1()+solve2()<<endl;
    
}
