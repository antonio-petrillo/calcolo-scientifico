function [root, ecc_iter] = bisection_method(fun, a, b, tol, max_iter)
    ecc_iter = 0;
    root = a + (b-a)/2;
    fa = fun(a);
    fp = fun(root);
    while abs(fp) > tol && ecc_iter < max_iter
        if(fp*fa < 0)
            b = root;
        else
            a = root;
            fa = fun(a);
        end
        ecc_iter = ecc_iter + 1;
        root = a + (b-a)/2;
        fp = fun(root);
    end
    if(ecc_iter >= max_iter)
        ecc_iter = 1;
    else
        ecc_iter = 0;
    end
end

% durante ogni iterazione al massimo valutiamo la funzione due volte
% ecc_iter assume il valore 1 quando si supera 
% il numero massimo di iterazioni 0 altrimenti
% inoltre non occorre valutare la fuzione in b!
