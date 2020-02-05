function [root, iter_err] = secant_method(fun, x0, x1, tol, max_iter)
    iter_err = 0;
    fn = fun(x1);
    fp = fun(x0);
    while iter_err < max_iter && abs(x1 - x0)>tol
        iter_err = iter_err + 1;
        tmp = x1 - (fn*(x1-x0)/(fn-fp));
        x0 = x1;
        x1 = tmp;
        fp = fn;
        fn = fun(x1);
    end
    root = x1;
    if iter_err >= max_iter
        iter_err = 1;
    else
        iter_err = 0;
    end
end
