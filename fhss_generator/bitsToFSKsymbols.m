function [samples] = bitsToFSKsymbols(bits, M)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

numBitsPerInSymbol = log2(M);
N_InSamples = length(bits) / numBitsPerInSymbol;
samples = zeros(1, N_InSamples);
for i = 1: N_InSamples
    sym = 0;
    for j = 1 : numBitsPerInSymbol
        sym = sym + (2^(j-1)) * bits(1 + numBitsPerInSymbol*(i-1) + (j - 1) );
    end   
    samples(i) = sym;
end

end

