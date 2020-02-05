g = @(x) 1./(1+25*x.^2);
xdata1 = [-1:0.5:1];
ydata1 = g(xdata1);
z1 = [-1:0.25:1];
interp1 = lagrange_multi(xdata1, ydata1, z1);
err1 = interp1'-g(z1);
figure(1);
subplot(1, 2, 1);
hold on
fplot(g, [-1 1], '-.b');
plot(z1, interp1, ':r');
hold off
subplot(1,2,2);
plot(z1, err1, 'g');
