clc; clear
load('date.mat') 
yuce = gupiao_2;

for i = 1 : 10
    a = size(yuce{i}, 1);
    yuce{i} = [yuce{i}; zeros(250, 6)];
    yuce{i}(a + 1 : end, 1) = ((43916 + 1) : (43916 + 250))';
    b = size(yuce{i}, 1);
    for j = a + 1 : b
        for k = 2 : size(yuce{i}, 2)
            yuce{i}(j, k) = dopredict(yuce{i}(:, k), j, 5, 23);
        end
    end
end

plot((1 : 530), yuce{1}(:, 6))
average_income = zeros(10, 1);
day_income = cell(1, 10);
for i = 1 : 10
    a = length(yuce{i}(:, 5))-1;
    clear income
    income_rate = zeros(a, 1);
    for k = 2 : length(yuce{i}(:, 5))
        income_rate(k - 1) = yuce{i}(k, 5) / yuce{i}(k - 1, 5);
    end
    day_income_rate{i} = income_rate;
    average_income_rate(i) = mean(income_rate);
end
save average_income_rate.mat average_income_rate
for i = 1 : 10
    for j = 1 : length(day_income_rate{i})
        risk{i} = day_income_rate{i} - average_income_rate(i);  % ��i֧��Ʊ���շ���=ÿ���������-ƽ��������
    end
end
for i = 1 : 10
    same_date(i) = length(risk{i});
end
max_date = min(same_date); 
max_date = max(same_date); 
global day_risk
day_risk = zeros(max_date, 10);

for i = 1 : 10
    day_risk(end - length(risk{i}) + 1 : end, i) = cell2mat(risk(i));
end

for i = 1 : size(day_risk, 1)
    if sum(day_risk(i, :) == 0) == 0 
        day_risk(1 : i - 1, :) = [];
        break
    end
end


A = ones(1, 10);
b = [1];
x0 = [0.1; 0.1; 0.1; 0.1; 0.1; 0.1; 0.1; 0.1; 0.1; 0.1];
L = zeros(10, 1);
global q
q = 0.1;
[x, favl] = fmincon(@cal, x0, [], [], A, b, L, [], @solve);
max_in_rate = -favl;
year_in_rate = (max_in_rate) .^ 250
sum_in_rate = (max_in_rate) .^ 279
x
x_ = sum(x)
max_in_rate
q
save answer.mat q x max_in_rate 
load 'answer.mat'

