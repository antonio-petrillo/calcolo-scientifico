f = @(x) ((x-1.1)^3)*(x-2.1);
fp = @(x) ((x-1.1)^2)*(3*x-6.3-x+1.1);
[res, iter_err] = newton_method(f, fp, 1.5, 10^-5, 100);