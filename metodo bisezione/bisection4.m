g = @(x) 0;
f = @(x) x+1-2*sin(x*pi);
[res1, iter_err1] = bisection_method(f, 0, 0.5, 10^-5, 100);
[res2, iter_err2] = bisection_method(f, 0.5, 1, 10^-5, 100);
hold on
fplot(f);
fplot(g);
plot(res1, f(res1), 'xb');
plot(res2, f(res2), 'xb');
hold off