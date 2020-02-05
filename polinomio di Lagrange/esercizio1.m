f = @(x) exp(x);
xdata1 = [-1:0.5:1];
ydata1 = f(xdata1);
z1 = [-1:0.25:1];
interp1 = lagrange_multi(xdata1, ydata1, z1);
xdata2 = [-1:0.25:1];
ydata2 = f(xdata2);
z2 = [-1:0.125:1];
interp2 = lagrange_multi(xdata2, ydata2, z2);
xdata3 = [-1:0.125:1];
ydata3 = f(xdata3);
z3 = [-1:0.0625:1];
interp3 = lagrange_multi(xdata3, ydata3, z3);
%e' facile notare che l'interpolazione con piu' nodi e' piu' accurata, ma
%la cosa piu' interessante e' vedere nelle interpolazioni con "meno nodi"
%come in certi punt la funzione differisce molto dall'approx., utilizzando
%la distribuzione di chebyshev questa differenza si in attenua
err1 = interp1'-f(z1);
err2 = interp2'-f(z2);
err3 = interp3'-f(z3);
figure(1);
subplot(1,2,1)
hold on
fplot(f,[-1 1],'g');
plot(z1, interp1,':r');
hold off
subplot(1,2,2)
plot(z1, err1);
figure(2)
subplot(1,2,1)
hold on
fplot(f, [-1 1],'g');
plot(z2, interp2,'-.y');
hold off
subplot(1,2,2);
plot(z2, err2);
figure(3);
subplot(1,2,1)
hold on
fplot(f, [-1 1],'g');
plot(z3, interp3,'-b');
hold off
subplot(1,2,2);
plot(z3, err3);