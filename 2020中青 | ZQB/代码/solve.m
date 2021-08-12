function [c, ceq] = solve(x)
    global ri_feng_xian 
    global q  
    E = ri_feng_xian; 
    c = sum((E * x) .^ 2) - q;
    ceq = [];