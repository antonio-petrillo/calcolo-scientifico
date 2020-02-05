function [t, y] = euler_method(fun, y0, t0, T, N)
    h = (T-t0)/N; % ampiezza degli intervalli
    t = zeros(N+1, 1);
    y = zeros(N+1, 1);
    for i=1:N+1 % preparo i punti che descrivono l'insieme di rete
        t(i) = t0 + h*i;
    end
    y(1) = y0;
    for i=2:N+1
        y(i) = y(i-1) + h*fun(t(i-1), y(i-1));
    end
end