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

// const db len=60; //
const db car_len = 2.4;
// const int tot_car=180;
const int MAX_COL = 100; // 一行并行车道所能容纳的最大出租车数
const int client = 80 ; // 一班客机下来的总乘客数
const db inf = 1e10;
const db v = 1.5;
const db car_v=20;
const int MaxCol = 200;
const int MaxClient = 1000;

struct record{
    int col,set;
    db val;
}ans[1000];

struct record_{
    int col;
    db val;
}ans_[1050];

// int car_number1 = tot_car; // 单侧进入可以容纳的汽车数量
// int car_number2 = tot_car; // 双侧进入可以容纳的汽车数量

int nowclient=client;
db tot_time;
record min_time={1,1,inf};
int cost_of_queue[10000];


int client_cost()// 得到顾客来到车前上车花费的时间
{
    srand(time(0));
    int x =rand();
    x%=10;
    if(x>=0 && x<=8) return 30;
    else return 45;
}

void get_cost_of_queue()
{
    rep(i,1,1000)
    {
        cost_of_queue[i]=cost_of_queue[i-1]+i*30;
    }
}
void init()
{
    rep(k,1,1010)
    {
        ans[k].val=1e10;
    }
}

int cal_cost_of_col(int col) // 表示列数对于汽车进入上车点车道的影响大小
{
    if(col >= 1 && col <= 3) return 20 * col;
    else if(col >=4 &&  col <= 10) return 30*col;
    else return 50*col;
}
void one_car()
{
    db move_time; //汽车移动花费的时间

    init(); // 初始化每一列汽车移动花费的时间

    tot_time=0; 
    db max_distance =- 1e9;

    rep(col,2,MAX_COL+1) // 枚举 选取的出租车排列的列数
    {   
        
        move_time = (4.7*col+(col-1)*2) / car_v; // 新的一批出租车移动花费的时间
        rep(set,1,col) // 枚举所有上车点
        {
            nowclient = client; // 重新将乘客数赋值
            record res;    //
            
            db time_cost = 0; //记录本次花费的时间 

            int round = 1; // 记录当前是第几批次的出租车
            while(1){
                db time_to_out_of_que = 30; // 乘客出队的时间
                db max_time =- 1e9;  // 初始化本批出租车上车的最大时间
                
                rep(c,1,col+1)  // 枚举当前所有列的出租车
                {   
                    rep(f,0,2)  // 位于上下哪一层
                    {   
                        db this_time = 0;
                        if(c == set) // 即上车点在当前这一列的相邻右侧
                        {
                            this_time += 3.25; // 水平方向距离 

                            if(f == 0) this_time += 0.65*3+1.7; // 竖直方向距离
                            else this_time += 0.65;

                            // max_distance = max(max_distance,this_time);
                            --nowclient; // 乘客数量相应减少
                            this_time /= v;
                        } 
                        else if(c < set) // 这一列在上车点的左侧
                        {
                            this_time += (db)fabs(c-set)*6.5+3.25;// 水平方向距离 

                            if(f == 0) this_time += 0.65*3+1.7;
                            else this_time += 0.65; 
                            // max_distance = max(max_distance,this_time);
                            --nowclient; // 乘客数量相应减少
                            this_time /= v; 
                        } 
                        else //在右侧
                        {   
                            if(c - set == 1)
                            {
                                this_time += 3.25; // 水平方向距离 

                                if(f == 0) this_time += 0.65 * 3 + 1.7;// 竖直方向距离
                                else this_time += 0.65;
                                // max_distance = max(max_distance,this_time);
                                --nowclient; // 乘客数量相应减少
                                this_time /= v;
                            }
                            else
                            {
                                this_time += (fabs(c-set)-1)*6.5+3.25; //水平

                                if(f==0) this_time += 0.65*3+1.7;// 竖直方向距离
                                else this_time += 0.65;

                                // max_distance=max(max_distance,this_time);
                                --nowclient; // 乘客数量相应减少
                                this_time /= v;
                            }
                        }

                        this_time += time_to_out_of_que;
                        this_time += (db)client_cost(); // 加上乘客上车可能消耗的时间
                        if(round != 1) this_time += move_time;
                        this_time += cal_cost_of_col(col);
                        max_time=max(this_time,max_time);
                        time_to_out_of_que+=30;
                        if(nowclient==0) break;
                    }
                    if(nowclient==0) break;
                }
                time_cost+=max_time;
                if(nowclient==0) break;
                // round++;
            }
            if(time_cost < ans[col].val)
            {
                ans[col]={col,set,time_cost};
            }
            if(time_cost < min_time.val)
                min_time={col,set,time_cost};
        }
    }

    rep(i,2,MAX_COL+1) 
        cout<<i<<"列"<<"上车点为： "<<ans[i].set<<"花费的时间为： "<<ans[i].val<<endl;

    cout<<"最少是 ： "<<min_time.col<<"列，"<<"上车点是 ："<<min_time.set<<"花费时间是： "<<min_time.val<<endl;
}

void full()
{
    db move_time=0;
    db distance=11;
    
    tot_time=0;
    db max_distance= -1e9;

    int N=(int)MAX_COL;
    int q[N];

    rep(col,2,MAX_COL+1)   
    {
        memset(q,0,sizeof q); // 所有队伍无人
        
        db tot_time=0;

        tot_time += cal_cost_of_col(col);//列数花费的时间

        // cout<<"tot_time    :  "<<tot_time<<endl;

        db move_time = client/(col*2) + (client%(col*2)?1:0);//汽车移动花费的时间
        move_time/=car_v;

        // cout<<"move_time   :    "<<move_time<<endl;
        tot_time+=move_time;

        // cout<<"1 . tot_time    :  "<<tot_time<<endl;

        db max_time_into_car=-inf;


        
        int queue_length=client/(col-1);
        int last=client%(col-1);
        rep(i,1,col)
        {
            if(last) q[i]+=1,last--;
            q[i]+=queue_length; // 求得每个队列的队长
        }


        rep(i,1,col)
        {
            db tmp=0;
            rep(j,1,q[i]+1)
            {
                tmp+=client_cost();  //最大队列中乘客花费时间的
            }
            max_time_into_car=max(max_time_into_car,tmp);
        }


        tot_time+=max_time_into_car;

        // cout<<"2. tot_time    :  "<<tot_time<<endl;


        rep(i,1,col+1)
        {
             db t=0;
             t+=q[i]/2 * distance + q[i]%2*1.65;
             t/=v;
             tot_time+=t; // 上车行走距离花费的时间
             
        }

        // cout<<"3. tot_time    :  "<<tot_time<<endl;

        int max_waittime_in_queue=-inf;

        rep(i,1,col)
        {
            max_waittime_in_queue=max(max_waittime_in_queue,cost_of_queue[q[i]]);
        }
        tot_time+=max_waittime_in_queue;

        // cout<<"4. tot_time    :  "<<tot_time<<endl;

        ans_[col].val=tot_time;
        ans_[col].col=col;
    }

    db min_col;
    db min_time=inf;

    
    rep(i,2,MAX_COL+1)
    {
        if(ans_[i].val < min_time)
        {   
            min_time=ans_[i].val;
            min_col=ans_[i].col;
        }
    }

    cout<<"花费的时间为："<<endl;
    rep(i,2,MAX_COL+1)
    {
        cout<<ans_[i].val<<endl;
    }


    cout<<"最小值时间花费为 ： "<<min_time<<"  最小花费设置的列数为 ： "<<min_col<<endl;

}

int main(){
    close
    // one_car();

    full();
}