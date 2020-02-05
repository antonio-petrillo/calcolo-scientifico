function [Sn] = simpson(fun, a, b, n)
    h = (b-a)/n;
    s4 = 0;
    s2 = 0;
    m = n/2;
    for i=0:m-1
        s4 = s4 + fun(a + (2*i+1)*h) ;
    end
    for i=1:m-1
        s2 = s2 + fun(a+(2*i)*h);
    end
    Sn = (fun(a) + fun(b)+ 4*s4 + 2*s2 )*(h/3);
end

