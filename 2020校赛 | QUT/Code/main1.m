clc;
clear;
close all;

a = xlsread('A1.xlsx');%��ȡ����
b = xlsread('A2.xlsx');

atk= 1; %ȷ��Ҫ�����ĵ� 
[a,b]=attack(a,b,atk);%���ú���ִ�й���
[A,B,answer] = cal(a,b); %���ú���ʵ���������ͨ��֧
answer  
[a,b]=attack(a,b,atk);%���ú���ִ�й���

g1=graph(A);
g2=graph(B);
figure,plot(g1,'NodeColor','k','EdgeAlpha',0.6);  %���ӻ���ǰ���硣
hold on   
% figure,plot(g2,'NodeColor','k','EdgeAlpha',0.6);  %���ӻ���ǰ���硣
% hold on








