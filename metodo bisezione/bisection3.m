g = @(x) 0;
f = @(x) 2*x*cos(2*x)-(x+1)^2;
[res1, iter_err1] = bisection_method(f, -3, -2, 10^-5, 1000);
[res2, iter_err2] = bisection_method(f, -1, 0, 10^-5, 1000);
hold on
fplot(g);
fplot(f);
plot(res1, f(res1), 'xb');
plot(res2, f(res2), 'xb');
hold off