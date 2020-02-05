f = @(x) x^6-x-1;
fp = @(x) 6*x^5-1;
[res, iter_err] = newton_method(f, fp, 2, 10^-3, 100);
hold on
fplot(f);
g = @(x) 0;
fplot(g);
plot(res, f(res), 'xb');
hold off