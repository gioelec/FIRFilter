function [Y] = FIR_filter(X,coeff)
    taps = length(coeff)
    len = length(X)
    for n=taps+1:1:len
        out = 0;
        for i=1:1:taps
            index = n-i
            out = out + coeff(i)*X(n-i)
        end
        Y(n) = out;
    end
end

