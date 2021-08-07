clc;
clear;
close all;
load('data1.mat'); 
h1 = graph(A1);
figure(1);
plot(h1,'NodeColor','k','EdgeAlpha',0.1);  
title('����1-1');

h1 = graph(A2);
figure(2);
plot(h1,'NodeColor','k','EdgeAlpha',0.1);  
title('����1-2');

load('data2.mat'); 
h1 = graph(A1);
figure(3);
plot(h1,'NodeColor','k','EdgeAlpha',0.1);  
title('����2-1');
h1 = graph(A2);
figure(4);
plot(h1,'NodeColor','k','EdgeAlpha',0.1);  
title('����2-2');
load('data3.mat'); 

h1 = graph(A1);
figure(5);
plot(h1,'NodeColor','k','EdgeAlpha',0.1); 
title('����3-1');
h1 = graph(A2);
figure(6);
plot(h1,'NodeColor','k','EdgeAlpha',0.1); 
title('����3-2');
load('data4.mat');
h1 = graph(A1);
figure(7);
plot(h1,'NodeColor','k','EdgeAlpha',0.1); 
title('����4-1');
h1 = graph(A2);
figure(8);
plot(h1,'NodeColor','k','EdgeAlpha',0.1); 
title('����4-2');

