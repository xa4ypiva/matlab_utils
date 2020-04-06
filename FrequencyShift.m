function [signalOut] = FrequencyShift(signalIn, fOffset, fs)

time = (0 : length(signalIn)-1) / fs;

if (~isreal(signalIn))
    signalOut = signalIn .* exp(1i * 2*pi*fOffset .* time);
else
    signalOut = hilbert(signalIn) .* exp(1i * 2*pi*fOffset .* time);
end

end

