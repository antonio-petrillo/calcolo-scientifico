function [f] = lagrange_multi(xdata, ydata, z)
    n = length(xdata);
    m = length(z);
    f = zeros(m, 1);
    const = ydata;
    for i=1:n
        for j=1:n
            if i~=j
                const(i) = const(i)/(xdata(i) - xdata(j));
            end
        end
    end
    for i=1:m
        for j=1:n
            term = 1;
            for k=1:n
                if j~=k
                    term = term*(z(i)-xdata(k));
                end    
            end
            f(i) = f(i) + term*const(j);
        end
    end