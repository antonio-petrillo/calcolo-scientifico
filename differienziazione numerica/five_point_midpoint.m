function [f_prime_in_x0] = five_point_midpoint(f, x0, h)
    f_prime_in_x0 = (f(x0-2*h)-8*f(x0-h)+8*f(x0+h)-f(x0+2*h))/12*h;
end


