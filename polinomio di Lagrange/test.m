function [f] = test(xdata,ydata,z)
    m = length(z);
    f = zeros(m, 1);
    for i=1:m
        f(i) = lagrange(xdata, ydata, z(i));
    end
end

