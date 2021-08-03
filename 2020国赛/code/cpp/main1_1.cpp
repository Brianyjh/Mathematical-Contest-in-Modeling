#include<bits/stdc++.h>
#define rep(i, a, n) for(int i=a;i<n;i++)
#define per(i, a, n) for(int i=n-1;i>=a;i--)
#define fi first
#define se second
#define pb push_back
#define close ios::sync_with_stdio(0);cin.tie(0);cout.tie(0);
using namespace std;
typedef pair<int,int> pii;
const int N=35;
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
struct record
{
    int money;
    int water;
    int food;
    int rest;
}days[35];

weather hot = {8, 6}; // ˮ���ġ�ʳ������ 
weather storm = {10, 10};
weather sun = {5, 7}; 
cost waters = {3, 5}; // ˮ���������۸�
cost foods = {2, 10};// ʳ����������۸�
int wea[35]; // ������0���ʡ�1���¡�2�籩
int dist[N][N]; // ��¼��������֮������·������
int food_buy = 232;
int water_buy = 82;
vector <pii> edge;
int st = 1, ed = 27, bal = 12, village = 15;
int n = 27;


void get_data()// ��ȡ����
{
    ifstream fin("fi_weather.csv");
    string line;
    while (getline(fin,line))
    {                           
        int c=0;
        rep(i,0,line.size())
            if(line[i] != ',')  
                wea[++c]=line[i]-'0';
    }
    fin.close;

    ifstream in("fir_edge.csv");
    int t=0;
    while (getline(in,line))
    {       
        t++;    
        int len=line.size(); len--;
        int tmp1=0,tmp2=0;
        if(line[1] == ',') 
        {
            tmp1=line[0] - '0';
            if(len == 3) tmp2=(int)(line[2]-'0');
            else if(len == 4) tmp2=(int)(line[2]-'0')*10+(int)(line[3]-'0');
        }
        else
        {
            tmp1=(int)(line[0]-'0')*10+(int)(line[1]-'0');
            if(len == 4) tmp2=line[3]-'0';
            else if(t==106) tmp2=(int)(line[4]-'0')*10+(int)(line[5]-'0');
            else tmp2=(int)(line[3]-'0')*10+(int)(line[4]-'0');
        }
      edge.pb({tmp1,tmp2});
    }
    in.close;
}
void init()
{
    rep(i,1,n+1) rep(j,1,n+1) 
    if(i==j) 
        dist[i][j]=0;
    else 
        dist[i][j]=INF;
}

void floyd()
{
    rep(k,1,n+1)
        rep(i,1,n+1)
            rep(j,1,n+1)
                dist[i][j]=min(dist[i][j],dist[i][k]+dist[k][j]);
}
void solve()
{
    int now=1;
    int st_village = dist[st][village];
    int water_need = 0;
    int food_need = 0;
    int nowpack = 0;
    int money = 10000;

// 1. ---------------------------------------------------------------------------------------
    int k = st_village;
    int sta=now;
    while(k--) // ����㵽��ׯ������
    {
        int j = now++;
        if(wea[j] == 0)
        {
            water_need += sun.water_cost * 2;
            food_need += sun.food_cost * 2;
            money -= sun.water_cost * 2 * waters.price;
            money -= sun.food_cost * 2 * foods.price;
            nowpack += sun.water_cost * waters.weight * 2;
            nowpack += sun.food_cost * foods.weight * 2;

        }
        else if(wea[j] == 1)
        {
            water_need += hot.water_cost * 2;
            food_need += hot.food_cost * 2;
            money -= hot.water_cost * waters.price*2;
            money -= hot.food_cost * foods.price*2;
            nowpack += hot.water_cost * waters.weight*2;
            nowpack += hot.food_cost * foods.weight*2;
        }
        else
        {
            ++k;
            water_need += storm.water_cost;
            food_need += storm.food_cost;
            money -= storm.water_cost * waters.price;
            money -= storm.food_cost * foods.price;
            nowpack += storm.water_cost * waters.weight;
            nowpack += storm.food_cost * foods.weight;
        }
        days[j] = {money,water_need,food_need,1200-nowpack};
    }
    cout<<endl<<"start to vill  ";
    cout<<sta<<" - "<<now-1<<endl;
    cout<<"------------------------------------------------------------"<<endl;
    int rest_begin = 1200 - nowpack; // �ܹ��������й����ʣ������
    int vil_bal = dist[village][bal];
    nowpack = 0; // ��ǰ�����������

// 2.---------------------------------------------------------------------------------------
   
    rep(i,now,now+vil_bal) // �Ӵ�ׯ����ɽ������
    {
        int t=food_buy;
        int r=0;
        int tt=water_buy;
        int rr=0;
        cout<<wea[i]<< ' ';
        if(wea[i] == 0)
        {
            water_need += sun.water_cost*2;
            food_need += sun.food_cost*2;
            money -= sun.water_cost*2*waters.price;
            money -= sun.food_cost*2*foods.price;
            nowpack += sun.water_cost * waters.weight * 2;
            nowpack += sun.food_cost * foods.weight * 2;
            if(tt) // ��ׯ�����ˮ��ʣ����ʱ
            {   
                if(tt > sun.water_cost*2) tt -= sun.water_cost*2;
                else 
                {
                    rr = sun.water_cost*2 - tt;
                    tt = 0;
                }
            }
            else rr=sun.water_cost*2;

            if(t) // ��ׯ�����ʳ����ʣ����ʱ
            {   
                if(t > sun.food_cost*2) t -= sun.food_cost*2;
                else 
                {
                    r = sun.food_cost*2 - t;
                    t = 0;
                }
            }
            else r = sun.food_cost*2;
        }
        else if(wea[i] == 1)
        {
            water_need += hot.water_cost*2;
            food_need += hot.food_cost*2;
            money-=hot.water_cost * waters.price*2;
            money-=hot.food_cost * foods.price*2;
            nowpack+=hot.water_cost * waters.weight*2;
            nowpack+=hot.food_cost * foods.weight*2;
            if(tt) // ��ׯ�����ʳ����ʣ����ʱ
            {   
                if(tt > hot.water_cost*2) tt -= hot.water_cost*2;
                else 
                {
                    rr = hot.water_cost*2 - tt;
                    tt = 0;
                }
            }
            else rr=hot.water_cost*2;
            
            if(t) // ��ׯ�����ʳ����ʣ����ʱ
            {   
                if(t > hot.food_cost*2) t -= hot.food_cost*2;
                else 
                {
                    r = hot.food_cost*2 - t;
                    t = 0;
                }
            }
            else r = hot.food_cost*2;
        }
        water_buy=tt;
        money -= rr *waters.price;
        food_buy = t;
        money -= r*foods.price;  
        days[i]={money,water_need,food_need,1200-nowpack};
    }
    cout<<endl<<"vill to bal  ";
    cout<<now<<" - "<<now+vil_bal-1<<endl;
    cout<<"------------------------------------------------------------"<<endl;
    now += vil_bal;

// 3.---------------------------------------------------------------------------------------    
    cout<<"food by in stat rest   : "<<food_buy<<endl;
    rep(i,now,now+7)// �ڿ�ɽ���ɿ��ʱ��
    {
        int t=food_buy;
        int r=0;
        int tt=water_buy;
        int rr=0;
        if(wea[i] == 0)
        {
            water_need += sun.water_cost * 3;
            food_need += sun.food_cost * 3;
            money-=sun.water_cost * waters.price * 3;
            money-=sun.food_cost * foods.price * 3;
            nowpack+=sun.water_cost * waters.weight * 3;
            nowpack+=sun.food_cost * foods.weight * 3;
            if(tt) // ��ׯ�����ʳ����ʣ����ʱ
            {   
                if(tt > sun.water_cost*3) tt -= sun.water_cost*3;
                else 
                {
                    rr = sun.water_cost*3 - tt;
                    tt = 0;
                }
            }
            else rr=sun.water_cost*3;

            if(t) // ��ׯ�����ʳ����ʣ����ʱ
            {   
                if(t > sun.food_cost*3) t -= sun.food_cost*3;
                else 
                {
                    r = sun.food_cost*3 - t;
                    t = 0;
                }
            }
            else r=sun.food_cost*3;
        }
        else if(wea[i] == 1)
        {
            water_need += hot.water_cost * 3;
            food_need += hot.food_cost * 3;
            money-=hot.water_cost * waters.price * 3;
            money-=hot.food_cost * foods.price * 3;
            nowpack+=hot.water_cost * waters.weight * 3;
            nowpack+=hot.food_cost * foods.weight * 3;
            if(tt) // ��ׯ�����ʳ����ʣ����ʱ
            {   
                if(tt > hot.water_cost*3) tt -= hot.water_cost*3;
                else 
                {
                    rr = hot.water_cost*3 - tt;
                    tt = 0;
                }
            }
            else rr = hot.water_cost * 3;
            if(t) // ��ׯ�����ʳ����ʣ����ʱ
            {   
                if(t > hot.food_cost*3) t -= hot.food_cost*3;
                else 
                {
                    r = hot.food_cost * 3 - t;
                    t = 0;
                }
            }
            else r = hot.food_cost * 3;
        }
        else
        {
            water_need += storm.water_cost * 3;
            food_need += storm.food_cost * 3;
            money-=storm.water_cost * waters.price * 3;
            money-=storm.food_cost * foods.price * 3;
            nowpack+=storm.water_cost * waters.weight * 3;
            nowpack+=storm.food_cost * foods.weight * 3;
            if(tt) // ��ׯ�����ʳ����ʣ����ʱ
            {   
                if(tt > storm.water_cost*3) tt -= storm.water_cost*3;
                else 
                {
                    rr = storm.water_cost*3 - tt;
                    tt = 0;
                }
            }
            else rr=storm.water_cost*3;
            if(t) // ��ׯ�����ʳ����ʣ����ʱ
            {   
                if(t > storm.food_cost*3) t -= storm.food_cost*3;
                else 
                {
                    r = storm.food_cost*3 - t;
                    t = 0;
                }
            }
            else r=storm.food_cost*3;
        }
        food_buy = t;
        money -= r*foods.price;  
        water_buy=tt;
        money -= rr *waters.price;
        money+=1000;
        days[i]={money,water_need,food_need,1200-nowpack};
    }
    cout<<endl<<"get in bal  ";
    cout<<now<<" - "<<now+7-1<<endl;
    now += 7;
    cout<<"------------------------------------------------------------"<<endl;
    int bal_vi=dist[bal][village];
// 4.---------------------------------------------------------------------------------------    

    k = bal_vi;
    sta=now;
    while(k--)  // ���ش�ׯ����
    {
        int t=food_buy;
        int r=0;
        int tt=water_buy;
        int rr=0;
        int j = now++;
        cout<<wea[j]<<' ';
        if(wea[j] == 0)
        {
            water_need += sun.water_cost * 2;
            food_need += sun.food_cost * 2;
            money -= sun.water_cost * 2 * waters.price;
            money -= sun.food_cost * 2 * foods.price;
            nowpack += sun.water_cost * waters.weight * 2;
            nowpack += sun.food_cost * foods.weight * 2;
            if(tt) // ��ׯ�����ʳ����ʣ����ʱ
            {   
                if(tt > sun.water_cost*2) tt -= sun.water_cost*2;
                else 
                {
                    rr = sun.water_cost*2 - tt;
                    tt = 0;
                }
            }
            else rr=sun.water_cost*2;

            if(t) // ��ׯ�����ʳ����ʣ����ʱ
            {   
                if(t > sun.food_cost * 2) t -= sun.food_cost * 2;
                else 
                {
                    r = sun.food_cost * 2 - t;
                    t = 0;
                }
            }
            else r = sun.food_cost * 2;
        }
        else if(wea[j] == 1)
        {
            water_need += hot.water_cost * 2;
            food_need += hot.food_cost * 2;
            money -= hot.water_cost * waters.price*2;
            money -= hot.food_cost * foods.price*2;
            nowpack += hot.water_cost * waters.weight*2;
            nowpack += hot.food_cost * foods.weight*2;
            if(tt) // ��ׯ�����ʳ����ʣ����ʱ
            {   
                if(tt > hot.water_cost*2) tt -= hot.water_cost*2;
                else 
                {
                    rr = hot.water_cost*2 - tt;
                    tt = 0;
                }
            }
            else rr=hot.water_cost*2;
            if(t) // ��ׯ�����ʳ����ʣ����ʱ
            {   
                if(t > hot.food_cost*2) t -= hot.food_cost*2;
                else 
                {
                    r = hot.food_cost*2 - t;
                    t = 0;
                }
            }
            else r=hot.food_cost*2;
        }
        else
        {
            ++k;
            water_need += storm.water_cost;
            food_need += storm.food_cost;
            money -= storm.water_cost * waters.price;
            money -= storm.food_cost * foods.price;
            nowpack += storm.water_cost * waters.weight;
            nowpack += storm.food_cost * foods.weight;
            if(tt) // ��ׯ�����ʳ����ʣ����ʱ
            {   
                if(tt > storm.water_cost) tt -= storm.water_cost;
                else 
                {
                    rr = storm.water_cost - tt;
                    tt = 0;
                }
            }
            else rr=storm.water_cost;
            if(t) // ��ׯ�����ʳ����ʣ����ʱ
            {   
                if(t > storm.food_cost) t -= storm.food_cost;
                else 
                {
                    r = storm.food_cost - t;
                    t = 0;
                }
            }
            else r=storm.food_cost;
        }
        food_buy = t;
        money -= r*foods.price;  
        water_buy=tt;
        money -= rr *waters.price;
        days[j]={money,water_need,food_need,1200-nowpack};
    }
    cout<<endl<<"to vill feedback  ";
    cout<<sta<<" - "<<now-1<<endl;
    cout<<"------------------------------------------------------------"<<endl;
// 5.---------------------------------------------------------------------------------------    
    nowpack=0;
    rep(i,now,now+bal_vi) // ���ؿ�ɽ
    {
        int t=food_buy;
        int r=0;
        int tt=water_buy;
        int rr=0;

        cout<<wea[i]<<' ';
        if(wea[i] == 0)
        {
            water_need += sun.water_cost*2;
            food_need += sun.food_cost*2;
            money-=sun.water_cost*2*waters.price;
            money-=sun.food_cost*2*foods.price;
            nowpack+=sun.water_cost * waters.weight * 2;
            nowpack+=sun.food_cost * foods.weight * 2;
            if(tt) // ��ׯ�����ʳ����ʣ����ʱ
            {   
                if(tt > sun.water_cost*2) tt -= sun.water_cost*2;
                else 
                {
                    rr = sun.water_cost*2 - tt;
                    tt = 0;
                }
            }
            else rr=sun.water_cost*2;

            if(t) // ��ׯ�����ʳ����ʣ����ʱ
            {   
                if(t > sun.food_cost*2) t -= sun.food_cost*2;
                else 
                {
                    r = sun.food_cost*2 - t;
                    t = 0;
                }
            }
            else r=sun.food_cost*2;
        }
        else if(wea[i] == 1)
        {
            water_need += hot.water_cost*2;
            food_need += hot.food_cost*2;
            money-=hot.water_cost * waters.price*2;
            money-=hot.food_cost * foods.price*2;
            nowpack+=hot.water_cost * waters.weight*2;
            nowpack+=hot.food_cost * foods.weight*2;
            if(tt) // ��ׯ�����ʳ����ʣ����ʱ
            {   
                if(tt > hot.water_cost*2) tt -= hot.water_cost*2;
                else 
                {
                    rr = hot.water_cost*2 - tt;
                    tt = 0;
                }
            }
            else rr=hot.water_cost*2;
            if(t) // ��ׯ�����ʳ����ʣ����ʱ
            {   
                if(t > hot.food_cost*2) t -= hot.food_cost*2;
                else 
                {
                    r = hot.food_cost*2 - t;
                    t = 0;
                }
            }
            else r=hot.food_cost*2;
        }
        food_buy = t;
        money -= r*foods.price;  
        water_buy=tt;
        money -= rr *waters.price;
        days[i]={money,water_need,food_need,1200-nowpack};
    }
    cout<<endl<<"back to bal  ";
    cout<<now<<" - "<<now+bal_vi-1<<endl;
    cout<<"------------------------------------------------------------"<<endl;
    now+=bal_vi;
// 6.---------------------------------------------------------------------------------------
    rep(i,now,now+3)// �ڿ�ɽ���ɿ��ʱ��
    {
        cout<<wea[i] <<' ';
        if(wea[i] == 0)
        {
            water_need += sun.water_cost*3;
            food_need += sun.food_cost*3;
            money-=sun.water_cost * waters.price * 3*2;
            money-=sun.food_cost * foods.price * 3*2;
            nowpack+=sun.water_cost * waters.weight * 3;
            nowpack+=sun.food_cost * foods.weight * 3;
        }
        else if(wea[i] == 1)
        {
            water_need += hot.water_cost*3;
            food_need += hot.food_cost*3;
            money-=hot.water_cost * waters.price*3*2;
            money-=hot.food_cost * foods.price*3*2;
            nowpack+=hot.water_cost * waters.weight*3;
            nowpack+=hot.food_cost * foods.weight*3;
        }
        else
        {
            water_need += storm.water_cost*3;
            food_need += storm.food_cost*3;
            money-=storm.water_cost * waters.price*3*2;
            money-=storm.food_cost * foods.price*3*2;
            nowpack+=storm.water_cost * waters.weight*3;
            nowpack+=storm.food_cost * foods.weight*3;
        } 
        days[i]={money,water_need,food_need,1200-nowpack};
        money+=1000;
    }
    cout<<endl<<"work in bal  ";
    cout<<now<<" - "<<now+3-1<<endl;
    cout<<"------------------------------------------------------------"<<endl;
    now += 3;

// 7.---------------------------------------------------------------------------------------    
    int vi_ed =  dist[village][ed];
    rep(i,now,now+bal_vi) // ȥ��ׯ����
    {
        if(wea[i] == 0)
        {
            water_need += sun.water_cost*2;
            food_need += sun.food_cost*2;
            money -= sun.water_cost*2*waters.price*2;
            money -= sun.food_cost*2*foods.price*2;
            nowpack += sun.water_cost * waters.weight * 2;
            nowpack += sun.food_cost * foods.weight * 2;
        }
        else if(wea[i] == 1)
        {
            water_need += hot.water_cost*2;
            food_need += hot.food_cost*2;
            money -= hot.water_cost * waters.price*2*2;
            money -= hot.food_cost * foods.price*2*2;
            nowpack += hot.water_cost * waters.weight*2;
            nowpack += hot.food_cost * foods.weight*2;
        }
        else
        {
            water_need += storm.water_cost;
            food_need += storm.food_cost;
            money -= storm.water_cost * waters.price*2;
            money -= storm.food_cost * foods.price*2;
            nowpack+=storm.water_cost * waters.weight;
            nowpack+=storm.food_cost * foods.weight;
        }
        days[i]={money,water_need,food_need,1200-nowpack};
    }

    nowpack=0;
    cout<<endl<<"to vill  ";
    cout<<now<<" - "<<now+bal_vi-1<<endl;
    now += bal_vi;
    cout<<"------------------------------------------------------------"<<endl;

// 8.---------------------------------------------------------------------------------------    
    rep(i,now,now+vi_ed) // �ִ��յ�
    {
        if(wea[i] == 0)
        {
            water_need += sun.water_cost*2;
            food_need += sun.food_cost*2;
            money-=sun.water_cost*waters.price*2*2;
            money-=sun.food_cost*foods.price*2*2;
            nowpack+=sun.water_cost * waters.weight * 2;
            nowpack+=sun.food_cost * foods.weight * 2;
        }
        else if(wea[i] == 1)
        {
            water_need += hot.water_cost*2;
            food_need += hot.food_cost*2;
            money-=hot.water_cost * waters.price * 2 * 2;
            money-=hot.food_cost * foods.price * 2 * 2;
            nowpack+=hot.water_cost * waters.weight * 2;
            nowpack+=hot.food_cost * foods.weight * 2;
        }
        else
        {
            water_need += storm.water_cost;
            food_need += storm.food_cost;
            money -= storm.water_cost * waters.price*2;
            money -= storm.food_cost * foods.price*2;
            nowpack += storm.water_cost * waters.weight;
            nowpack += storm.food_cost * foods.weight;
        }
        days[i]={money,water_need,food_need,1200-nowpack};
    }
    cout<<endl<<"back  ";
    cout<<now<<" - "<<now+vi_ed-1<<endl;
    cout<<"------------------------------------------------------------"<<endl;
}
// ����·��   cd  /Users/zzz123/Desktop/2020����/����/cpp
// ./a.out
int main()
{
    close
    init();
    get_data();
    edge[edge.size() - 1].se ++; 
    rep(i, 0, edge.size())
    {
        int x = edge[i].fi, y = edge[i].se;
        dist[x][y] = dist[y][x] = 1;
    }
    floyd();
    solve();
    rep(i, 1, 30 + 1) 
        cout<<"days\t"<<i<<":\t"<<days[i].money<<"\t"<<days[i].water<<"\t"<<days[i].food<<"\t"<<days[i].rest<<endl;
}
