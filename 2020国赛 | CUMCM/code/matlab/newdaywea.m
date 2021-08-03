function [nowwea] = newdaywea(lastwea,rnd1,sun_hot,hot_sun)
        if lastwea == 0 % 当前是晴天
        if rnd1 < sun_hot 
            nowwea = 1;
        else
            nowwea = 0;
        end
        else % 当前是高温天气
            if rnd1 < hot_sun
                nowwea = 0;
            else 
                nowwea = 1;
            end
        end
end

