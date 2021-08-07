clc;
clear;
close all;

a = xlsread('A1.xlsx');%读取数据
b = xlsread('A2.xlsx');

atk= 1; %确定要攻击的点 
[a,b]=attack(a,b,atk);%调用函数执行攻击
[A,B,answer] = cal(a,b); %调用函数实现求最大连通分支
answer  
[a,b]=attack(a,b,atk);%调用函数执行攻击

g1=graph(A);
g2=graph(B);
figure,plot(g1,'NodeColor','k','EdgeAlpha',0.6);  %可视化当前网络。
hold on   
% figure,plot(g2,'NodeColor','k','EdgeAlpha',0.6);  %可视化当前网络。
% hold on








