function len=myLength(A1,A2,atk)
    [a,b]=attack(A1,A2,atk);%���ú���ִ�й���
    [~,~,answer] = cal(a,b); %���ú���ʵ���������ͨ��֧
    len=answer;
end