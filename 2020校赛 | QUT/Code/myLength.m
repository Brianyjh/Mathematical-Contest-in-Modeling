function len=myLength(A1,A2,atk)
    [a,b]=attack(A1,A2,atk);%调用函数执行攻击
    [~,~,answer] = cal(a,b); %调用函数实现求最大连通分支
    len=answer;
end