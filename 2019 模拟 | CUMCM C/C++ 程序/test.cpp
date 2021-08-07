#include<bits/stdc++.h>
using namespace std;
#define rep(i,a,n) for(int i=a;i<n;i++)
#define per(i,a,n) for(int i=n-1;i>=a;i--)
#define fi first
#define se second 
#define ll long long
#define pb push_back
#define db double 
#define close ios::sync_with_stdio(0);cin.tie(0);cout.tie(0);
#define eps 999

typedef pair<int,int>pii;
typedef vector<int> vi;


const ll mod=1e9+7;
// const db len=60; //
const db car_len=2.4;
// const int tot_car=180;
const db inf=1e10;
const db v=1.5;

db MAX_COL; // 一行并行车道所能容纳的最大出租车数
int client; // 一班客机下来的总乘客数

struct record{
    int col,set1,set2;
    db val;
}ans[100000][100000][100000];

// int car_number1 = tot_car; // 单侧进入可以容纳的汽车数量
// int car_number2 = tot_car; // 双侧进入可以容纳的汽车数量
int nowclient=client;
db tot_time;
record min_time={inf,inf,inf,inf};

int client_cost()// 得到顾客来到车前上车花费的时间
{
    srand(time(0));
    int x =rand();
    x%=10;
    if(x>=0 && x<=8) return 5;
    else return 10;
}

void init()
{
    rep(i,2,MAX_COL+1)
    {
        ans[i].val=1e10;
    }
}
void two_in()
{
    init();

    MAX_COL = 10; // 一行并行车道所能容纳的最大出租车数
    client = 80; // 一班客机下来的总乘客数
    rep(MAX_COL,10,1000)
    {
        rep(client,100,100000)
        {    
            tot_time=0;
            db max_distance=-1e9;
            db move_time;

            rep(col,2,MAX_COL+1) // 枚举出租车的列数
            {   
                move_time=(4.7*col+(col-1)*2);
                move_time/=v;
                rep(set,1,col) // 枚举所有上车点
                {
                    rep(set2,1,col)
                    {
                        if(set == set2) continue;

                        nowclient=client;
                        record res;
                        // cout<<nowclient<<endl;
                        db time_cost=0;
                        int round=1;
                        while(1){
                            db time_to_out_of_que_one=1;
                            db time_to_out_of_que_two=1;
                            
                            db max_time=-1e9;
                            
                            rep(c,1,col+1) // 当前所有列的出租车
                            {   
                                int s;
                                if(c <col/2) s=min(set,set2);
                                else s=max(set,set2);

                                rep(f,0,2) // 位于上下哪一层
                                {   
                                    db this_time=0;
                                   
                                    if(c == s) //即上车点在当前这一列的相邻右侧
                                    {
                                        this_time += 3.35; //水平方向距离 

                                        if(f==0) this_time += 0.65*3+1.7;
                                        else this_time+=0.65;
                                        max_distance=max(max_distance,this_time);
                                        --nowclient;
                                        this_time/=v;
                                        
                                    }
                                    else if(c < s) //这一列在上车点的左侧
                                    {
                                        this_time += fabs(c-s)*6.7+3.35;//水平方向距离 

                                        if(f==0) this_time += 0.65*3+1.7;
                                        else this_time+=0.65; 
                                        max_distance=max(max_distance,this_time);
                                        --nowclient;
                                        this_time /= v;
                                    } 
                                    else //在右侧
                                    {   
                                        if(c - s == 1)
                                        {
                                            this_time += 3.35; //水平方向距离 

                                            if(f==0) this_time += 0.65*3+1.7;//竖直方向距离
                                            else this_time+=0.65;
                                            max_distance=max(max_distance,this_time);
                                            --nowclient;
                                            this_time /= v;
                                        }
                                        else
                                        {
                                            this_time += (fabs(c-s)-1)*6.7+3.35; //水平
                                            if(f==0) this_time += 0.65*3+1.7;
                                            else this_time += 0.65;
                                            max_distance=max(max_distance,this_time);
                                            --nowclient;
                                            this_time /= v;
                                        }
                                    }
                                    if(s==min(set,set2)) 
                                    {
                                        this_time += time_to_out_of_que_one;
                                        time_to_out_of_que_one++;
                                    }
                                    else
                                    { 
                                        this_time += time_to_out_of_que_two;
                                        time_to_out_of_que_two++;
                                    }
                                    this_time += (db)client_cost(); // 加上乘客上车可能消耗的时间
                                    if(round != 1) this_time += move_time;
                                    // cout<<nowclient<<endl;
                                    if(this_time > max_time)
                                    {
                                        max_time=this_time;
                                    }
                                    if(nowclient==0) break;
                                }
                                if(nowclient==0) break;
                            }
                            time_cost+=max_time;
                            if(nowclient==0) break;
                            round++;
                        }
                        if(time_cost < ans[col].val)
                        {
                            ans[MAX_COL][client][col]={col,set,set2,time_cost};
                        }
                        if(time_cost < min_time.val)
                            min_time={col,set,set2,time_cost};


                        
                    }
                }
            }
            // cout<<"最大距离为： "<<max_distance<<endl;
            // rep(i,2,MAX_COL+1) 
            // cout<<i<<"列"<<ans[i].val<<endl;
            // cout<<"最少是 ： "<<min_time.col<<"列，"<<"上车点是 ："<<min_time.set1<<" and "<<min_time.set2<<"  花费时间是： "<<min_time.val<<endl;
        }
    }
}   

void output()
{

}
int main(){
    close
    two_in();
    output();
}