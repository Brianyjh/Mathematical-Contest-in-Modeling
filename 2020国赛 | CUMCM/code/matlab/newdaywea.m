function [nowwea] = newdaywea(lastwea,rnd1,sun_hot,hot_sun)
        if lastwea == 0 % ��ǰ������
        if rnd1 < sun_hot 
            nowwea = 1;
        else
            nowwea = 0;
        end
        else % ��ǰ�Ǹ�������
            if rnd1 < hot_sun
                nowwea = 0;
            else 
                nowwea = 1;
            end
        end
end

