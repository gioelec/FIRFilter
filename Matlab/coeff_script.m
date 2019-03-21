b = 16;
lsb = -(-1) / (2^(b - 1)); %lsb for converting double to int
coeff = [0.0135,0.0785,0.2409,0.3344,0.2409,0.0785,0.0135]'; 
c_i = round(coeff/lsb);%integer coefficients