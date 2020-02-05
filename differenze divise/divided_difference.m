function [f_in_x0] = divided_difference(xdata, ydata, x0)
    n = length(xdata);
    A = size(n);
    A = [ydata'];
    for i=2:n
        for j=2:i
            A(i, j) = (A(i,j-1)-A(i-1,j-1))/(xdata(i)-xdata(i-j+1));
        end
    end
    f_in_x0 = A(n,n);
    for i=n-1:-1:1
        f_in_x0 = f_in_x0*(x0-xdata(i))+A(i,i);
    end
end

