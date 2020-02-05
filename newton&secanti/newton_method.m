function [root, iter_err] = newton_method(fun, fun_d, x0, tol,max_iter)
    g = @(x) x -fun(x)/fun_d(x);
    iter_err = 0;
    root = g(x0);
    while iter_err < max_iter && abs(root-x0)>tol
        x0 = root;
        root = g(root);
        iter_err = iter_err + 1;
    end
    if iter_err >= max_iter
        iter_err = 1;
    else
        iter_err = 0;
    end
end

