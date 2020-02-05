f = @(x) x - 2^-x;
[res, iter_err] = bisection_method(f, 0, 1, 10^-5, 1000);
g = @(x) 0;
hold on
fplot(f);
fplot(g);
plot(res, f(res), 'xb');
hold off