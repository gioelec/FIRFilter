clear;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% adjusting the coeffitiens to be integers for vhdl

b = 16;
lsb = -(-1) / (2^(b - 1));  % lsb for converting double to int
coeff = [0.0135, 0.0785, 0.2409, 0.3344, 0.2409, 0.0785, 0.0135]'; 
c_i = round(coeff / lsb);  % integer coefficients

disp("factor = " + lsb);
disp("coefficients for filter: ");
disp(c_i);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calculate expected output

% this must be the same as in io/input_vectors
x = [0, 7, 10, 3, 0, 7, 10, 3, 0, 7, 10, 3, 0];
a = [1];  % fir filter has only a_0 = 1
% calculate the expected filter output
y = filter(coeff, a, x);
% you can also calculate this with a simple convolution
% y2 = conv(x, coeff);
% y2 = y2(1:length(x));

disp("expected output of filter: ");
disp(y);
% this output should match the output of the vhdl filter
disp("expected output of vhdl filter according to factor: ");
disp(y / lsb);

figure(1);
% this would be your sampling period
Ts = 1;
t = linspace(0, length(x) * Ts, length(x));
stem(t, x);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% simulate the filter characteristics

f = linspace(-1/Ts,1/Ts,1000);

% Compute zeros (roots of nominator)
z = roots(coeff);

% Compute poles (roots of denominator)
p = roots(a);

% Pole-zero plot
figure(1)
zplane(z,p);
title('Pole-Zero Plot');

% First 10 samples of the impulse response
figure(2)
impz(coeff,a,10);
grid on;

% Frequency response (assuming a sampling rate of 1kHz)
figure(3)
freqz(coeff,a,f,1/Ts);


