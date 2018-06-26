function [ y ] = ASKmod( data, M, nsamp, fc, fs, amplitudes, ini_phase )
%ASKMOD Summary of this function goes here
%   Detailed explanation goes here

if (nargin == 6 && ~isempty(amplitudes) && length(amplitudes) == M)
    ampl = amplitudes;
else
    ampl = (0 : M-1) / (M-1);
end

phi = 0;
if (nargin == 7)
    phi = ini_phase;
end

lenData = length(data);
y = zeros(1, lenData * nsamp);
t = (0 : nsamp-1) / fs;
sig = zeros(M, nsamp);
for i = 1 : M
    sig(i,:) = ampl(i) * cos(2*pi*fc * t + phi);
end

for i = 1 : lenData
    y((i-1)*nsamp + 1 : i*nsamp) = sig(data(i)+1, :);
end

end

