%creare il polinomio interpolante per un braccio robotico che a detrminati
%istanti deve trovarsi in determinate posizioni

x = [0:0.25:5];
y = sin(x);
z = chebyshev(0,5,100);
interp = lagrange_multi(x, y, z);
hold on
scatter(x, y, 'ob');
plot(z, interp, '-.r');