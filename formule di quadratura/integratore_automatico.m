function [S, ierr] = integratore_automatico(fun, a, b, tol, iter_max)
    niter = 0;
    h = a + (b-a)/2;
    ya = fun(a);
    yb = fun(b);
    S2 = fun(a+h);
    S4 = fun(a+h/2) + fun(a+3*h/2);
    I2 = h*(ya + 4*S2 + yb)/3;
    h = h/2;
    I4 = h*(ya + 2*(2*S2) +4*S4 + yb)/3;
    while abs(I2-I4) > 15*tol && niter <= iter_max
        niter = niter + 1;
        h = h/2;
        S4 = fun(a+h);
        for i=3:2:2^(niter+2)-1
            S4 = S4 + fun(a+i*h);
        end
        S2 = S4;
        I2 = I4;
        I4 = h*(ya + 2*S2 + 4*S4 + yb)/3;
    end
    if niter > iter_max
        ierr = -1;
    else
        ierr = 0;
    end
    S = I4;
end