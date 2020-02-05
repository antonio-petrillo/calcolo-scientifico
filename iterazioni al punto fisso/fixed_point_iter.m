function [x, iter_err] = fixed_point_iter(fun, x0, tol, iter_max)
    iter_err = 0;
    x = fun(x0);
    x_prev = x0;
    %in pratica durante le varie iterazioni troviamo lo zero della funzione
    %"di iterazione" che equivale al risolvere il problema "originale"
    %NB: per poter utilizzare questo metodo occorre fare attenzione a 
    %    cosa vogliamo ottenere e quindi elaborare una funzione da passare
    %    adeguata
    while abs(x - x_prev) > tol && iter_err < iter_max
        iter_err = iter_err + 1;
        x_prev = x;
        x = fun(x);
    end
    if iter_err >= iter_max
        iter_err = 1;
    else
        iter_err = 0;
    end
end


