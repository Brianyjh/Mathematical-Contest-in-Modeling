clc
clear

R = xlsread('Rt.xlsx');
P = xlsread('各股Pit.xlsx');

N = 1000;
max_ans = -inf;
max_x = zeros(1, 5);
for n = 1 : N
    x_ = rand(1, 5);
    y_ = sum(x_);
    x = x_ / y_;
    now = 0;
    for t = 2 : 14
        rt = 0;
        t1 = 0;
        t2 = 0;
        for i = 1 : 5
            t1 = P(t, i) * x(i);
            t2 = P(t - 1, i) * x(i);
            rt = rt + log(t1 / t2);
        end
        now = now + rt - R(t - 1);
    end
    if max_ans < now
        max_ans = now;
        max_x = x;
    end
end

max_ans
max_x
