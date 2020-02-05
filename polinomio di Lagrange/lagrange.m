function [f] = lagrange(xdata, ydata, z)
    n = length(xdata);
    sm = 0;
    for i=1:n
        pr = 1;
        for j=1:n
            if i~=j
                pr = pr*(z-xdata(j))/(xdata(i) - xdata(j));
            end
        end
        sm = sm + ydata(i)*pr;
    end
    f = sm;
