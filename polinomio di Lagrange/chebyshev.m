function [distribution] = chebyshev(a, b, k)
    distribution = zeros(k, 1);
    for i=1:k
        distribution(i) = (a+b)/2 + (b-a)*cos((2*i*pi + pi)/(2*k + 2))/2;
    end
end

