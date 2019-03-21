x_i = round(x / lsb);   %input for the testbench
x_test = x_i';
%o = conv(c_i, x_i);     %output expected
% out = FIR_filter(x_i,c_i);
% b_o = ceil(log2(2^(b - 1) * sum(abs(c_i))))+1; %output bits needed
