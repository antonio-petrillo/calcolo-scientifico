f = @(x) exp(x) - 2*x^2;
fp = @(x) exp(x) -4*x;
fplot(f)
[res1, iter1] = newton_method(f, fp, -1, 10^-5, 1000);
[res2, iter2] = newton_method(f, fp, 1, 10^-5, 1000);
[res3, iter3] = newton_method(f, fp, 3, 10^-5, 1000);
%basta osseervare il grafico e saper come funziona il metodo di newton!