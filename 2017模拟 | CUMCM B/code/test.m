load data.mat;


x= rand(1,10);x=sort(x);
y=rand(1,10);y=sort(y);

plot(x,y,'ok-','linewidth',1.1,'markerfacecolor',[36,169,255]/255);
grid on 
set(gca,'linewidth',1.1,'fontsize',16,'fontname','times')