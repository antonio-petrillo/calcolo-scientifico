f1 = @(x) cosh(x) + cos(x) - 1;
f2 = @(x) cosh(x) + cos(x) - 2;
f3 = @(x) cosh(x) + cos(x) - 3;
fp = @(x) sinh(x) -sin(x);
hold on
fplot(f1, 'b');
fplot(f2, 'y');
fplot(f3, 'r');
fplot(fp);
hold off
%semplicemente guardando il grafico si vede che f1 non interseca l'asse
%delle x quindi non possiede uno 0 (reale).
%per f2 invece si ha che la funzione e'"piatta" nell'intorno del suo 0
%quindi il metodo di newton che sfrutta le tangenti non riesce ad
%avvicinarsi alla soluzione
[res1, iter1] = newton_method(f1, fp, 0, 10^-5, 1000);
[res2, iter2] = newton_method(f2, fp, 0, 10^-5, 1000);
[res3, iter3] = newton_method(f3, fp, 0.5, 10^-5, 1000);