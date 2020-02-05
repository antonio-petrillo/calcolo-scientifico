function [f_prime_in_x0] = three_point_midpoint(f, x0, h)
    f_prime_in_x0 = (f(x0+h)-f(x0-h))/2*h;
end


