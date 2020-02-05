xdata = [-2 -1 0 1 2 3];
ydata = [1 4 11 16 1 -4];
z = chebyshev(-3, 3, 1000);
interp = lagrange_multi(xdata, ydata, z);
hold on
plot(xdata, ydata);
plot(z, interp);