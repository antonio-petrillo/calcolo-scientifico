function [Tn] = trapezi(fun, a, b, n)
    h = (b-a)/n;
    s = 0;
    for i=1:n-1
        s = s + fun(a+i*h); 
    end
    Tn = (2*s + fun(a) + fun(b))*(h/2);
end

