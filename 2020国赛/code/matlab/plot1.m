figure(1);
x=0:2;
y=[9410,10430,9800];
plot(x,y,'ok-','linewidth',1.1,'markerfacecolor',[36,169,255]/255); 
grid on 
title('第一关可能的最优解');
legend('到达终点剩余金钱');
xlabel('金矿访问次数');ylabel('剩余金钱');
axis([ -0.5 2.3 9100 10700]); % 设置x、y轴刻度范围
text(-0.15,9300,'不采矿');
text(0.7,10500,'采矿一次到终点');
text(1.7,9700,'采矿两次到终点');
set(gca,'linewidth',1.1,'fontsize',16,'fontname','times')
hold on

