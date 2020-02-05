function [f] = cubic_spline(xdata, ydata, z, type, der_x0, der_xn)
    %type indica quale tio di spline viene utilizzata basta indicare il tipo 
    %con una stringa 
    %der_x0 e der_xn devono contenere il valore della derivata prima in x0 e xn
    %questi due valori vengono utilizzati solo nel caso di Clamped Spline
    %Sj(x) = aj + bj(x-xj) + cj(x-xj)^2 + dj(x-xj)^3 
    %a = ydata; coefficienti del termine noto 
    n = length(xdata);
    h = zeros(n-1, 1);%vettore che contiene gli intervalli
    aus = zeros(1, n);%vettore ausiliario usato per trovare le costanti c
    d = zeros(1, n);%coefficiente del termine cubico
    A = zeros(n);%matrice usata per trovare le costanti c
    for i=1:n-1
        h(i) = xdata(i+1)-xdata(i);
    end
    for i=2:n-1
        aus(i) = 3*(ydata(i+1) - ydata(i))/h(i) + 3*(ydata(i)-ydata(i-1))/h(i-1);
    end
    if strcmp(type, 'Clamped')
        aus(1) = (3/h(1))*(ydata(2)-ydata(1))-3*der_x0;
        aus(n) = 3*der_xn - (3/h(n-1))*(ydata(n)-ydata(n-1));
        A(1, 1) = 2*h(1);
        A(1, 2) = h(1);
        A(n, n) = 2*h(n-1);
        A(n, n-1) = h(n-1);
    else
        aus(1) = 0;
        aus(n) = 0;
        A(1, 1) = 1;
        A(n, n) = 1;
    end
    A(2:1+n:n*n-2*n-1) = h(1:n-2);
    A(2*n+2:1+n:n*n-1) = h(2:n-1);
    A(2+n:1+n:n*n-(n+1)) = 2*(h(1:n-2)+h(2:n-1));
    c = A/aus;%vettore dei coefficienti
    for i=1:n-1
        d(i) = (c(i+1)-c(i))/3*h(i);
    end
    b = zeros(n,1);
    for i=1:n-1
        b(i) = (1/h(i))*(ydata(i+1)-ydata(i)) - (1/3*h(i))*(2*c(i)+c(i+1));
    end
    m = length(z);%numero di punti in cui valutare la spline
    f = zeros(m, 1);%vettore che conterra' le valutazioni della spline
    if strcmp(type, 'Not-a-Knot')
        d(1) = d(2);
        d(n-1) = d(n-2);
    end
    for i=1:m
        index = binary_search(xdata, z(i));
        hj = (z(i)-xdata(index));%computa x-xj
        f(i) = ydata(index) + b(index)*hj + c(index)*hj^2 + d(index)*hj^3;
    end
end

