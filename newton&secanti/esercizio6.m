f = @(x) x^2 -2;
fp = @(x) 2*x;
g = @(x) 0;
[res_n1, iter_err_n1] = newton_method(f, fp, 2, 10^-8, 100);
[res_n2, iter_err_n2] = newton_method(f, fp, 200, 10^-8, 100);
[res_s1, iter_err_s1] = secant_method(f, 1, 2, 10^-8, 100);
[res_s2, iter_err_s2] = secant_method(f, 199, 200, 10^-8, 100);