function [Y] = FIR_filter(x, coeff)
    N = length(coeff);
    len = length(x);

    for n = (N + 1):len
        out = 0;
        for i = 1:N
            out = out + coeff(i) * x(n - i);
        end
        Y(n) = out;
    end
end

