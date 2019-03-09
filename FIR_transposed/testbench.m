coeff = [442 2572 7894 10958 7894 2572 442];
x = [0 0 0 0 0 0 0 0 -3 1 0 -2 -1 4 -5 6 0];
y = zeros(1,10)
for n=8:1:length(x)
    sum = 0;
    for i=1:1:7
        index = n-i
        sum = sum + coeff(i)*x(n-i);
    end
    y(n) = sum;
end