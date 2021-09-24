function [iqOut] = MultiplySignals(iqIn, fc_Hz, grid_Hz, signalsNum, fs)
%MULTIPLY Summary of this function goes here
%   Detailed explanation goes here

iqOut = zeros(size(iqIn));
for i = 0 : signalsNum - 1
    fCurr = fc_Hz + ceil(i - signalsNum / 2) * grid_Hz;
    iqCurr = FrequencyShift(iqIn, fCurr, fs);
    iqOut = iqOut + iqCurr;
end

end

