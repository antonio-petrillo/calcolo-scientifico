f = @(x) x^3-7*x^2+14*x-6;
[res1, iter_err1] = bisection_method(f, 0, 1, 10^-2, 1000);
[res2, iter_err2] = bisection_method(f, 1, 3.2, 10^-2, 1000);
[res3, iter_err3] = bisection_method(f, 3.2, 4, 10^-2, 1000);
hold on;
fplot(f);
g = @(x) 0;
fplot(g);
plot(res1, f(res1), 'xb');
plot(res2, f(res2), 'xb');
plot(res3, f(res3), 'xb');
hold off
%come si puo' vedere dal grafico f ha tre radici reali e tramite il metodo
%di bisezione, utilizzando intervalli appropriati, riusciamo ad
%individuarli