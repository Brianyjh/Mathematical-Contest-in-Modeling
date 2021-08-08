%% 计算下一个交易日的值
% 输入序列、需要预测的日期在序列中所排顺序index、参考的天数n（序列的长度必须大于n）
% 输出需要预测当日的预测值
function pred_value=predict_a_day(xulie,index,n)
% for i=1:10 
    % % y=[216 199 222 218 217 259 206 230 255 221 214 212 219 224 210 205 186 249 214 228 211 226 219 238 217 205 206];
    y=xulie(1:index-1);
    m1=length(y);
    n;
    for i=1:m1-n+1
        yhat1(i)=sum(y(i:i+n-1))/n;
    end
%     yhat1;
    m2=length(yhat1);
    for i=1:m2-n+1
        yhat2(i)=sum(yhat1(i:i+n-1))/n;
    end
%     yhat2;
    a21=2*yhat1(end)-yhat2(end);
    b21=2*(yhat1(end)-yhat2(end))/(n-1);
    pred_value=a21+b21;
end
