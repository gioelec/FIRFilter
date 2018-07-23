b = 16;

%range [-1,1) (C2)

lsb = -(-1) / (2^(b - 1)); 

c = [0.0135,0.0785,0.2409,0.3344,0.2409,0.0785,0.0135]'; %input coefficients

c_i = round(c/lsb);

c_q = c_i * lsb; %quantized coefficients

theta = [0 : 0.1 : 2 * pi];

x = sin(theta);

x_i = round(x / lsb);   %input for the testbench

o = conv(c_i, x_i);     %output expected

b_o = ceil(log2(2^(b - 1) * sum(abs(c_q)))) + 1; %output bits needed

a = dec2twos(o,16)