f = @(x) cos(2*x)^2 - x^2;
fp = @(x) -2*sin(4*x) -2*x;
[res, iter_err] = newton_method(f, fp, 0.1, 10^-10, 100);