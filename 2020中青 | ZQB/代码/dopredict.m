function do=dopredict(order,index,n,m)
order=order(1:index-1);% 参考的数据order
L=length(order);
A=floor(L/m);
B=mod(L,m);
y=[];
for i=1:A
    y=[y;order(B+m*i)];
end

L1=length(y);
n=floor(A/2); %让n动态变化

for i=1:L1-n+1
    get1(i)=sum(y(i:i+n-1))/n;
end
L2=length(get1);
for i=1:L2-n+1
    get2(i)=sum(get1(i:i+n-1))/n;
end
ans1=2*get1(end)-get2(end);
ans2=2*(get1(end)-get2(end))/(n-1);

do=ans1+ans2;

end
