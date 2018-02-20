syms z
C0 = 0.0135;
C1 = 0.0785;
C2 = 0.2409;
C3 = 0.3344;
C4 = 0.2409;
C5 = 0.0785;
C6 = 0.0135;
Ts = 6;
minreal(H);
nyq_fre = 0.5*1/6;
fc = 1/6;
ft = fc*0.2*1/nyq_fre
bode(H)

