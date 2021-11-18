function [mat, comp_rate] = customDCTpress(thrsh , m_in)
absm_in = abs(m_in);
[r, c] = size(absm_in);

[fr, fc] = find(absm_in < 0.001);

clen = length(fr);
nZ = c * r - clen;

k = 1;


