function [f] = divided_difference_multi(xdata, ydata, z)
    n = length(xdata);
    A = size(n);
    A = [ydata'];
    for i=2:n
        for j=2:i
            A(i, j) = (A(i,j-1)-A(i-1,j-1))/(xdata(i)-xdata(i-j+1));
        end
    end
    m = length(z);
    f = zeros(m, 1);
    %praticamente questa e' una implementazione dell'algoritmo di horner
    for k=1:m
        f(k) = A(n,n);
        for i=n-1:-1:1
            f(k) = f(k)*(z(k)-xdata(i))+A(i,i);
        end
    end
end
