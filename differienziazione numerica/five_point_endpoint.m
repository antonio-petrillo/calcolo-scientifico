function [f_prime_in_x0] = five_point_endpoint(f, x0, h)
    f_prime_in_x0 = (-25*f(x0)+48*f(x0+h)-36*f(x0+2*h)+16*f(x0+3*h)-3*f(x0+4*h`))/12*h;
end


