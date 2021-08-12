clc
clear 
P = xlsread('各股Pit.xlsx');
I = xlsread('目标指数It.xlsx');
H = xlsread('Ht.xlsx');

alpha=2;
alpha_=1/alpha;

N=1000;
min_ans = +inf;
min_w=zeros(1, 5);

for rnd = 1 : N
    x = rand(1, 5);
    y = sum(x);
    W = x / y;
    now = 0;
    for t = 1 : 14
        tmp = 0;
        for i = 1 : 5
            tmp = P(t, i) * W(i);
        end
        now = now + H(t) * power(abs(tmp - I(t)), alpha);
    end
    now = power(now, alpha_);
    if min_ans > now
        min_ans = now;
        min_w = W;
    end
end

min_ans
min_w




