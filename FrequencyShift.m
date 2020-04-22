function [signalOut] = FrequencyShift(signalIn, fOffset, fs)

time = (0 : length(signalIn)-1) / fs;
signalOut = signalIn .* exp(1i * 2*pi*fOffset .* time);

end

