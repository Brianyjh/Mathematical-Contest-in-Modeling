figure(1);
x=0:2;
y=[9410,10430,9800];
plot(x,y,'ok-','linewidth',1.1,'markerfacecolor',[36,169,255]/255); 
grid on 
title('��һ�ؿ��ܵ����Ž�');
legend('�����յ�ʣ���Ǯ');
xlabel('�����ʴ���');ylabel('ʣ���Ǯ');
axis([ -0.5 2.3 9100 10700]); % ����x��y��̶ȷ�Χ
text(-0.15,9300,'���ɿ�');
text(0.7,10500,'�ɿ�һ�ε��յ�');
text(1.7,9700,'�ɿ����ε��յ�');
set(gca,'linewidth',1.1,'fontsize',16,'fontname','times')
hold on

