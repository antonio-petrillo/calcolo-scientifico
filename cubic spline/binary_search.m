function [index] = binary_search(vector, value)
    up = length(vector);
    low = 1;
    if up==1
        index = 1;
    else     
        while up ~= low 
            index = (low + up)/2;
            if value <= vector(ceil(index)) && value >= vector(floor(index))
               index = floor(index);
               break;
            elseif value < vector(floor(index))
                    up = floor(index);
            else
                low = ceil(index);
            end
        end
    end
end

