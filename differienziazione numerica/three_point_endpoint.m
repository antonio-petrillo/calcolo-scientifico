function [f_prime_in_x0] = three_point_endpoint(f, x0, h)
    f_prime_in_x0 = (3*f(x0)+ 4*f(x0+h) + f(x0-2*h))/2*h;
end

