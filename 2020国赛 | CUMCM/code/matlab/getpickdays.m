function [pickday] = getpickdays(tmp)
    if tmp > 0 && tmp < 0.2
        pickday = 1;
    elseif tmp >= 0.2 && tmp < 0.4
        pickday = 2;
    elseif tmp >= 0.4 && tmp < 0.6
        pickday = 3;
    elseif tmp >= 0.6 && tmp < 0.8
        pickday = 4;
    elseif tmp >= 0.8 && tmp < 1
        pickday = 5;
    end
end

